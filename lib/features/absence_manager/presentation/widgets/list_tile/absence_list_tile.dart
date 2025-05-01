import 'package:crewmeister_frontend_coding_challenge/core/extensions/date_time_extension.dart';
import 'package:crewmeister_frontend_coding_challenge/core/extensions/string_extension.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/models/absence_view_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/list_tile/absence_list_tile_body_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/list_tile/absence_list_tile_header_widget.dart';
import 'package:flutter/material.dart';

class AbsenceListTile extends StatelessWidget {
  final AbsenceViewModel absenceViewModel;
  const AbsenceListTile({
    super.key,
    required this.absenceViewModel,
  });

  @override
  Widget build(BuildContext context) => Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AbsenceListTileHeaderWidget(
                memberName: absenceViewModel.memberName,
                absenceStatus: absenceViewModel
                    .absenceStatus.name.capitalizeFirstLetterOnly,
                absenceStatusColor:
                    getAbscenceStatusColor(absenceViewModel.absenceStatus),
              ),
              const SizedBox(
                height: 4.0,
              ),
              AbsenceListTileBodyWidget(
                absenceType:
                    absenceViewModel.absenceType.name.capitalizeFirstLetterOnly,
                startDate: absenceViewModel.startDate.formatToYYYYmmdd,
                endDate: absenceViewModel.endDate.formatToYYYYmmdd,
                memberNote: absenceViewModel.memberNote,
                admitterNote: absenceViewModel.admitterNote,
              ),
            ],
          ),
        ),
      );

  Color getAbscenceStatusColor(AbsenceStatusEnum absenceStatus) {
    switch (absenceStatus) {
      case AbsenceStatusEnum.confirmed:
        return Colors.green;
      case AbsenceStatusEnum.rejected:
        return Colors.red;
      case AbsenceStatusEnum.requested:
        return Colors.orange;
    }
  }
}
