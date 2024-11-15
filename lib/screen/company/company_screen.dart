import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import '../../widgets/menu/menu.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:convert';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:intl/intl.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  MqttBrowserClient? client;
  bool connected = false;
  String _mqttMsg = "";
  final String receiveTopic = 'topic/receive'; // Not a wildcard topic
  final String sendTopic = 'topic/send'; // Not a wildcard topic

  @override
  void initState() {
    super.initState();
    setupMqtt();  // MQTT Set
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Menu(currentIndex: 0,),
          Text(connected ? "Connected" : "disconnected")
        ],
      ),
    );
  }

  Future<void> setupMqtt() async {
    client = MqttBrowserClient('ws://14.42.209.174', "", maxConnectionAttempts: 1);
    client!.keepAlivePeriod = 30;
    client!.autoReconnect = true;
    client!.port = 7028; //ws는 7028, mqtt는 7029
    client!.setProtocolV311();
    // c:\Program Files\Mosquitto>
    // mosquitto_pub -h 14.42.209.174 -p 7029 -u mings -P Sct91234! -t topic/sample -m {"msg":"tested"}
    // mosquitto_sub -h 14.42.209.174 -p 7029 -u mings -P Sct91234! -t topic/sample

    // MQTT 로그 출력
    client!.logging(on: false);

    // 리스너 등록
    client!.onConnected = onMqttConnected;
    client!.onDisconnected = onMqttDisconnected;
    client!.onSubscribed = onSubscribed;

    client!.pongCallback = pong;

    client!.websocketProtocols = MqttClientConstants.protocolsSingleDefault;

    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic('will-topic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .authenticateAs("mings", "Sct91234!")
        .withWillQos(MqttQos.exactlyOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client!.connectionMessage = connMess;

    try {
      //
      await client!.connect();
    } catch (e) {
      print('Connected Failed.. \nException: $e');
    }


    client!.subscribe(receiveTopic, MqttQos.atMostOnce);

    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      print('');
    });

    client!.published!.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');

      _mqttMsg = 'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}';
    });
  }

  void onMqttConnected() {
    print(':: MqttConnected');
    publishData(sendTopic, "hello");
    setState(() {
      connected = true;
      client!.subscribe(receiveTopic, MqttQos.atLeastOnce);

      client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
        final String message =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        setState(() {
          print(':: Received message: $message');
        });
      });
    });
  }

  void onMqttDisconnected() {
    print(':: MqttDisconnected');
    setState(() {
      connected = false;
    });
  }

  void onSubscribed(String topic) {
    print(':: Subscribed topic: $topic');
  }

  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }

  // 데이터 전송
  void publishData(String topic, String data) {
    final payload = jsonEncode(data);
    final builder = MqttClientPayloadBuilder();
    builder.addString(payload);

    client!.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    print(':: Send message: $data');
  }
}
