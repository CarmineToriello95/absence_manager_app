import 'package:flutter/material.dart';

class AbsencesPageHeaderWidget extends StatelessWidget {
  final int numberOfAbsences;
  final VoidCallback onFilterIconTapped;

  const AbsencesPageHeaderWidget({
    super.key,
    required this.numberOfAbsences,
    required this.onFilterIconTapped,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const Text(
            'Absences',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              Text(
                'Total: $numberOfAbsences',
                style: const TextStyle(fontSize: 18.0),
              ),
              const Spacer(),
              IconButton(
                onPressed: onFilterIconTapped,
                icon: const Icon(Icons.tune),
              ),
            ],
          )
        ],
      );
}
