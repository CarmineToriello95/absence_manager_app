import 'package:crewmeister_frontend_coding_challenge/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class AbsenceListTileDateDisplayWidget extends StatelessWidget {
  final String startDate;
  final String endDate;
  const AbsenceListTileDateDisplayWidget({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(
            Icons.calendar_month,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            'Start: ',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            startDate,
          ),
          const SizedBox(
            width: AppSpacing.md,
          ),
          Text(
            'End: ',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            endDate,
          ),
        ],
      );
}
