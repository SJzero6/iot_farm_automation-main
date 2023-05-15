import 'package:flutter/material.dart';
import 'package:iot_app_cusat/values/colors.dart';
import 'package:iot_app_cusat/values/fonts.dart';

class SensorNode extends StatefulWidget {
  const SensorNode(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});
  final String icon;
  final String label;
  final String value;

  @override
  State<SensorNode> createState() => _SensorNodeState();
}

class _SensorNodeState extends State<SensorNode> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ImageIcon(
              AssetImage('assets/images/${widget.icon}'),
              color: ColorValues.primaryColor,
              size: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: FontValues.sensorNodeLabel,
                ),
                Text(
                  widget.value,
                  style: FontValues.sensorNodeValue,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
