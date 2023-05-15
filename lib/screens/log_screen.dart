import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iot_app_cusat/values/colors.dart';
import 'package:iot_app_cusat/values/conf.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});
  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  List<double> temp = [];
  List<double> hum = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _fetchData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _fetchData();
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var request = http.Request('GET', Uri.parse('${endpoint}getData'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var dataArray = json.decode(data);

      dataArray.forEach((item) {
        temp.add(double.parse(item['humidity']));
        hum.add(double.parse(item['temperature']));
      });
    } else {
      print(response.reasonPhrase);
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorValues.bgColor,
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SafeArea(
              child: FutureBuilder(
            future: _fetchData(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text('Temperature')],
                    ),
                  ),
                  Container(
                      child: SfSparkLineChart(
                    //Enable the trackball
                    trackball: const SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: const SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    data: temp,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [Text('Humidity')],
                    ),
                  ),
                  Container(
                      child: SfSparkLineChart(
                    //Enable the trackball
                    trackball: const SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: const SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    data: hum,
                  )),
                ]);
              } else {
                print("Some error has occured");
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          )),
        ));
  }
}
