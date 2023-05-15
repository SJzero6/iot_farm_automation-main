import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_app_cusat/values/colors.dart';
import 'package:iot_app_cusat/values/conf.dart';
import 'package:iot_app_cusat/values/fonts.dart';
import 'package:iot_app_cusat/widgets/sensor_node.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const url = awsEndPoint;
  static const port = 8883;
  static const clientId = 'android123';
  bool mot1BtnStatus = false;
  bool shadeBtnStatus = false;
  bool manualOperationStatus = false;
  final client = MqttServerClient.withPort(url, clientId, port);

  Map<String, dynamic> data = {
    "hum": 0.0,
    "temp": 0.0,
    "soil": false,
    "light": false,
  };
  @override
  void initState() {
    super.initState();
    _connectMQTT();
  }

  _connectMQTT() async {
    //await mqttConnect();
    await newAWSConnection();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/log');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorValues.bgColor,
      body: Column(children: [
        Container(
          height: 200,
          color: ColorValues.primaryColor,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset('assets/images/top_circle.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CircleAvatar(
                    foregroundImage: AssetImage(
                      'assets/images/login_image.png',
                    ),
                    radius: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome AJAY',
                      style: FontValues.whiteStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          height: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: GridView(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3 / 1.5),
            children: [
              SensorNode(
                  icon: 'thermometer.png',
                  label: 'Temperature',
                  value: '${data['temp'].toStringAsFixed(1)}\u00B0 C'),
              SensorNode(
                  icon: 'humidity.png',
                  label: 'Humidity',
                  value: '${data['hum']} %'),
              SensorNode(
                  icon: 'moisture.png',
                  label: 'Soil Moisture',
                  value: '${data['soil'] ? 'Wet' : 'Dry'} '),
              SensorNode(
                  icon: 'sun.png',
                  label: 'Light',
                  value: '${data['light'] ? "Yes" : "No"}')
            ],
          ),
        ),
        Expanded(
          child: ListView(padding: EdgeInsets.zero, children: [
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ImageIcon(
                            AssetImage('assets/images/motor.png'),
                            color: ColorValues.primaryColor,
                          ),
                          Text('Motor 1'),
                        ],
                      ),
                    ),
                    const Text('Manual Override'),
                    Switch(
                        value: manualOperationStatus,
                        onChanged: ((value) {
                          _sendMessage(value
                              ? json.encode({"manual_operation": true})
                              : json.encode({"manual_operation": false}));
                          setState(() {
                            value
                                ? manualOperationStatus = true
                                : manualOperationStatus = false;
                          });
                        })),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ImageIcon(
                            AssetImage('assets/images/motor.png'),
                            color: ColorValues.primaryColor,
                          ),
                          Text('Motor 2'),
                        ],
                      ),
                    ),
                    const Text('Drip Irrigation'),
                    Switch(
                        value: mot1BtnStatus,
                        onChanged: ((value) {
                          _sendMessage(value
                              ? json.encode({"motor_status": true})
                              : json.encode({"motor_status": false}));
                          setState(() {
                            value
                                ? mot1BtnStatus = true
                                : mot1BtnStatus = false;
                          });
                        })),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ImageIcon(
                            AssetImage('assets/images/motor.png'),
                            color: ColorValues.primaryColor,
                          ),
                          Text('Motor 3'),
                        ],
                      ),
                    ),
                    const Text('Sun Shade'),
                    Switch(
                        value: shadeBtnStatus,
                        onChanged: ((value) {
                          _sendMessage(value
                              ? json.encode({"shade_status": true})
                              : json.encode({"shade_status": false}));
                          setState(() {
                            value
                                ? shadeBtnStatus = true
                                : shadeBtnStatus = false;
                          });
                        })),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80,
            )
          ]),
        ),
      ]),
      // floatingActionButton:
      //     FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //         label: 'Charts',
      //         icon: ImageIcon(AssetImage('assets/images/config.png'))),
      //     BottomNavigationBarItem(
      //         label: 'Home',
      //         icon: ImageIcon(AssetImage('assets/images/home.png'))),
      //     BottomNavigationBarItem(
      //         label: 'User',
      //         icon: ImageIcon(AssetImage('assets/images/user_icon.png'))),
      // ],
      // onTap: _onItemTapped,
      // currentIndex: _selectedIndex,
      // elevation: 5,
    );
  }

  Future<int> newAWSConnection() async {
    client.secure = true;
    client.keepAlivePeriod = 20;
    // Set the protocol to V3.1.1 for AWS IoT Core, if you fail to do this you will receive a connect ack with the response code
    client.setProtocolV311();
    // logging if you wish
    client.logging(on: true);

    final context = SecurityContext.defaultContext;

    final ByteData crtData =
        await rootBundle.load('assets/certs/AJAY095-certificate.pem.crt');
    context.useCertificateChainBytes(crtData.buffer.asUint8List());

    final ByteData authoritiesBytes =
        await rootBundle.load('assets/certs/Ajay_AmazonRootCA1 (1).pem');
    context.setClientAuthoritiesBytes(authoritiesBytes.buffer.asUint8List());

    final ByteData keyBytes =
        await rootBundle.load('assets/certs/Ajay_pri1a095-private.pem (1).key');
    context.usePrivateKeyBytes(keyBytes.buffer.asUint8List());

    client.securityContext = context;
    final connMess =
        MqttConnectMessage().withClientIdentifier('android123').startClean();
    client.connectionMessage = connMess;

    try {
      print('MQTT client connecting to AWS IoT....');
      await client.connect();
    } on Exception catch (e) {
      print('MQTT client exception - $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected to AWS IoT');
      const topic = 'ra_pi_pub';

      client.subscribe(topic, MqttQos.atLeastOnce);
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

        setState(() {
          data = json.decode(pt);
        });
        print(
            'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
        print('');
      });
    } else {
      print(
          'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      client.disconnect();
    }

    print('Sleeping....');
    await MqttUtilities.asyncSleep(10);

    //print('Disconnecting');
    //client.disconnect();

    return 0;
  }

  _sendMessage(msg) {
    print('Sent message...');
    const topic = 'ra_pi_sub';
    final builder = MqttClientPayloadBuilder();
    builder.addString(msg);

    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }
}
