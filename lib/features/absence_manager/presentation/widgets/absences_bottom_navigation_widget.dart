import 'package:crewmeister_frontend_coding_challenge/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class AbsencesNavigationWidget extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;
  final int currentPage;
  final int numberOfPages;
  const AbsencesNavigationWidget({
    super.key,
    required this.onBack,
    required this.onNext,
    required this.currentPage,
    required this.numberOfPages,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
            Text(
              '$currentPage/$numberOfPages',
              style: const TextStyle(fontSize: 16.0),
            ),
            IconButton(
              onPressed: onNext,
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      );
}
