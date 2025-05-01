import 'package:flutter/material.dart';

class AppDualStyleTextWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isIconVisible;

  const AppDualStyleTextWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.isIconVisible = true,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(
            width: 4.0,
          ),
          Flexible(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  TextSpan(
                    text: description,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
