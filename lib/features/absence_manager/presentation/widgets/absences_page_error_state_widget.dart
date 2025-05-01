import 'package:crewmeister_frontend_coding_challenge/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class AbsencesPageBodyErrorStateWidget extends StatelessWidget {
  final VoidCallback onFetchAbsencesButtonTapped;
  const AbsencesPageBodyErrorStateWidget({
    super.key,
    required this.onFetchAbsencesButtonTapped,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 50,
          ),
          const SizedBox(
            height: AppSpacing.lg,
          ),
          const Text(
            'An error occurred while fetching the absences, please try again.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSpacing.lg,
          ),
          ElevatedButton(
            onPressed: onFetchAbsencesButtonTapped,
            child: const Text(
              'Fetch Absences',
            ),
          )
        ],
      );
}
