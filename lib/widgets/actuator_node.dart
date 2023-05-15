import 'package:flutter/material.dart';
import 'package:iot_app_cusat/values/colors.dart';

class ActuatorNode extends StatefulWidget {
  const ActuatorNode(
      {super.key,
      required this.icon,
      required this.label,
      required this.description,
      required this.btnStatus,
      required this.valueChanged});
  final String icon;
  final String label;
  final String description;
  final bool btnStatus;
  final ValueChanged<String?> valueChanged;

  @override
  State<ActuatorNode> createState() => _ActuatorNodeState();
}

class _ActuatorNodeState extends State<ActuatorNode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage('assets/images/${widget.icon}'),
                    color: ColorValues.primaryColor,
                  ),
                  Text(widget.label),
                ],
              ),
            ),
            Text(widget.description),
            Switch(
                value: widget.btnStatus,
                onChanged: ((value) {
                  widget.valueChanged;
                })),
          ],
        ),
      ),
    );
  }
}
