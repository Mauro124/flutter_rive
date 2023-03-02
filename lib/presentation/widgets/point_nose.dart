import 'package:flutter/material.dart';

class PointNose extends StatefulWidget {
  final double pointX;
  final double pointY;

  const PointNose({Key? key, required this.pointX, required this.pointY}) : super(key: key);

  @override
  State<PointNose> createState() => _PointNoseState();
}

class _PointNoseState extends State<PointNose> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.pointY,
      right: widget.pointX - 10,
      child: Column(
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "X ${widget.pointX}\nY: ${widget.pointY}",
            style: const TextStyle(fontSize: 8),
          ),
        ],
      ),
    );
  }
}
