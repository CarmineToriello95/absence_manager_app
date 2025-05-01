import 'package:flutter/material.dart';

class AbsenceListTileHeaderWidget extends StatelessWidget {
  final String memberName;
  final String absenceStatus;
  final Color absenceStatusColor;

  const AbsenceListTileHeaderWidget({
    super.key,
    required this.memberName,
    required this.absenceStatus,
    required this.absenceStatusColor,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          CircleAvatar(
            child: Text(memberName.substring(0, 1).toUpperCase()),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Text(
            memberName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: absenceStatusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              absenceStatus,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: absenceStatusColor,
              ),
            ),
          ),
        ],
      );
}
