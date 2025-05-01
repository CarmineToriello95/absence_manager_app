import 'package:crewmeister_frontend_coding_challenge/core/extensions/string_extension.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/entities/absence_entity.dart';
import 'package:flutter/material.dart';

class AbsenceTypeSelectionWidget extends StatelessWidget {
  final Set<AbsenceTypeEnum> selectedTypes;
  final Function(Set<AbsenceTypeEnum>) onTapped;
  const AbsenceTypeSelectionWidget({
    super.key,
    required this.selectedTypes,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8.0,
        children: AbsenceTypeEnum.values
            .map(
              (type) => FilterChip(
                selected: selectedTypes.contains(type),
                label: Text(type.name.capitalizeFirstLetterOnly),
                onSelected: (selected) {
                  if (selected) {
                    selectedTypes.add(type);
                  } else {
                    selectedTypes.remove(type);
                  }
                  onTapped(selectedTypes);
                },
              ),
            )
            .toList(),
      );
}
