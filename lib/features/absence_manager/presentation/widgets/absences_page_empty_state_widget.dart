import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/cubit/absence_manager_cubit_state.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/absences_page_header_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/filters_bottom_sheet/filters_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';

class AbsencesPageEmptyStateWidget extends StatelessWidget {
  final AbsenceManagerEmptyState state;
  const AbsencesPageEmptyStateWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AbsencesPageHeaderWidget(
            numberOfAbsences: 0,
            onFilterIconTapped: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (_) => BottomSheetWidget(
                  filtersViewModel: state.filtersViewModel.copy(),
                ),
              );
            },
          ),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  size: 50,
                ),
                Text(
                  'No absence found.',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
        ],
      );
}
