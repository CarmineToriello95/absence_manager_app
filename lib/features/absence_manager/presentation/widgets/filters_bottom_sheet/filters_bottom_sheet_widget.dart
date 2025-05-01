import 'package:crewmeister_frontend_coding_challenge/core/constants/app_spacing.dart';
import 'package:crewmeister_frontend_coding_challenge/di_config.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/cubit/absence_manager_cubit.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/models/filters_view_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/filters_bottom_sheet/absence_type_selection_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/filters_bottom_sheet/date_picker_field_widget.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  final FiltersViewModel filtersViewModel;
  const BottomSheetWidget({
    super.key,
    required this.filtersViewModel,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  late final ValueNotifier<DateTime?> currentStartDateNotifier;
  late final ValueNotifier<DateTime?> currentEndDateNotifier;
  late final ValueNotifier<Set<AbsenceTypeEnum>> selectedTypes;
  final AbsenceManagerCubit _cubit = getIt.get();

  @override
  void initState() {
    currentStartDateNotifier = ValueNotifier(widget.filtersViewModel.startDate);
    currentEndDateNotifier = ValueNotifier(widget.filtersViewModel.endDate);
    selectedTypes = ValueNotifier(widget.filtersViewModel.absenceType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filters',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const Text(
              'Date Range',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: ValueListenableBuilder(
                valueListenable: currentEndDateNotifier,
                builder: (_, currentEndDateValue, __) => DatePickerFieldWidget(
                  label: 'Start Date',
                  currentDate: currentStartDateNotifier.value,
                  firstDate: DateTime(2000),
                  lastDate: currentEndDateValue ?? DateTime(2100),
                  onPickedDate: (pickedDate) {
                    currentStartDateNotifier.value = pickedDate;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: ValueListenableBuilder(
                valueListenable: currentStartDateNotifier,
                builder: (_, currentStartDateValue, __) =>
                    DatePickerFieldWidget(
                  label: 'End Date',
                  currentDate: currentEndDateNotifier.value,
                  firstDate: currentStartDateValue ?? DateTime(2000),
                  lastDate: DateTime(2100),
                  onPickedDate: (pickedDate) {
                    currentEndDateNotifier.value = pickedDate;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            const Text(
              'Status',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            const SizedBox(
              height: AppSpacing.md,
            ),
            ValueListenableBuilder(
              valueListenable: selectedTypes,
              builder: (_, value, __) => AbsenceTypeSelectionWidget(
                selectedTypes: value,
                onTapped: (newSelectedTypes) =>
                    selectedTypes.value = Set.from(newSelectedTypes),
              ),
            ),
            const SizedBox(
              height: AppSpacing.lg,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  _cubit.applyFilters(
                    FiltersViewModel(
                      startDate: currentStartDateNotifier.value,
                      endDate: currentEndDateNotifier.value,
                      absenceType: selectedTypes.value,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    selectedTypes.value = {};
    currentStartDateNotifier.dispose();
    currentEndDateNotifier.dispose();

    selectedTypes.dispose();
    super.dispose();
  }
}
