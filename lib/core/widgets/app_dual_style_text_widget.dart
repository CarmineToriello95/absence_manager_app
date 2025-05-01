import 'package:flutter/material.dart';

class AppDualStyleTextWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const AppDualStyleTextWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(
                width: 4.0,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 20.0,
              ),
              Text(description),
            ],
          ),
        ],
      );
}
