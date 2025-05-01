import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:equatable/equatable.dart';

/// Class containing the information to display in the filter section.
class FiltersViewModel extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final Set<AbsenceTypeEnum> absenceType;

  const FiltersViewModel({
    required this.startDate,
    required this.endDate,
    required this.absenceType,
  });

  @override
  List<Object?> get props => [startDate, endDate, absenceType];

  FiltersViewModel copy({
    DateTime? startDate,
    DateTime? endDate,
    Set<AbsenceTypeEnum>? absenceType,
  }) =>
      FiltersViewModel(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        absenceType: Set.from(
          absenceType ?? this.absenceType,
        ),
      );

  int numberOfActiveFilters() {
    int activeFilters = 0;
    if (startDate != null) {
      activeFilters++;
    }
    if (endDate != null) {
      activeFilters++;
    }
    if (absenceType.isNotEmpty) {
      activeFilters++;
    }
    return activeFilters;
  }
}
