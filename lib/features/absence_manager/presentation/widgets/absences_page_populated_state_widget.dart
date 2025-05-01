import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/cubit/absence_manager_cubit_state.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/models/absence_view_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/absences_bottom_navigation_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/absences_page_header_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/filters_bottom_sheet/filters_bottom_sheet_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/list_tile/absence_list_tile.dart';
import 'package:flutter/material.dart';

class AbsencesPagePopulatedStateWidget extends StatefulWidget {
  final AbsenceManagerPopulatedState state;
  const AbsencesPagePopulatedStateWidget({super.key, required this.state});

  @override
  State<AbsencesPagePopulatedStateWidget> createState() =>
      _AbsencesPagePopulatedStateWidgetState();
}

class _AbsencesPagePopulatedStateWidgetState
    extends State<AbsencesPagePopulatedStateWidget> {
  final ValueNotifier<List<AbsenceViewModel>> absencesCurrentlyDisplayed =
      ValueNotifier([]);
  final ValueNotifier<int> currentPage = ValueNotifier(1);
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    showFirstPage(widget.state);
    return Column(
      children: [
        AbsencesPageHeaderWidget(
          numberOfAbsences: widget.state.totalNumberOfAbsences,
          onFilterIconTapped: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              )),
              builder: (_) {
                final filtersViewModel = widget.state.filtersViewModel.copy();
                return BottomSheetWidget(
                  filtersViewModel: filtersViewModel,
                );
              },
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: absencesCurrentlyDisplayed,
          builder: (_, absences, __) => Expanded(
            child: ListView.separated(
              controller: scrollController,
              separatorBuilder: (_, i) => const SizedBox(
                height: 8.0,
              ),
              itemCount: absences.length,
              itemBuilder: (_, i) => AbsenceListTile(
                absenceViewModel: absences[i],
              ),
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: currentPage,
          builder: (_, value, __) => AbsencesNavigationWidget(
            onBack: () {
              onBack(widget.state);
            },
            onNext: () {
              onNext(widget.state);
            },
            numberOfPages: widget.state.numberOfPages,
            currentPage: value,
          ),
        )
      ],
    );
  }

  void showFirstPage(AbsenceManagerPopulatedState state) {
    currentPage.value = 1;
    absencesCurrentlyDisplayed.value = state.absencesViewModel
        .skip((currentPage.value - 1) * 10)
        .take(10)
        .toList();
  }

  void onBack(AbsenceManagerPopulatedState state) {
    if (currentPage.value > 1) {
      absencesCurrentlyDisplayed.value = state.absencesViewModel
          .skip((currentPage.value - 2) * 10)
          .take(10)
          .toList();
      currentPage.value--;
      scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  void onNext(AbsenceManagerPopulatedState state) {
    if (currentPage.value < state.numberOfPages) {
      absencesCurrentlyDisplayed.value = state.absencesViewModel
          .skip(currentPage.value * 10)
          .take(10)
          .toList();
      currentPage.value++;
      scrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }
}
