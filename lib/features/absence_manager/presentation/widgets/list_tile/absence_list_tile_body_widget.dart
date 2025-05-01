import 'package:crewmeister_frontend_coding_challenge/core/widgets/app_dual_style_text_widget.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/widgets/list_tile/absence_list_tile_date_display_widget.dart';
import 'package:flutter/material.dart';

class AbsenceListTileBodyWidget extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String absenceType;
  final String memberNote;
  final String admitterNote;

  const AbsenceListTileBodyWidget({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.absenceType,
    required this.memberNote,
    required this.admitterNote,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          AppDualStyleTextWidget(
            title: 'Type: ',
            description: absenceType,
            icon: Icons.home,
          ),
          const SizedBox(
            height: 4.0,
          ),
          AbsenceListTileDateDisplayWidget(
            startDate: startDate,
            endDate: endDate,
          ),
          if (memberNote.isNotEmpty) ...[
            const SizedBox(
              height: 4.0,
            ),
            AppDualStyleTextWidget(
              icon: Icons.border_color,
              title: 'Member Note: ',
              description: memberNote,
            ),
          ],
          if (admitterNote.isNotEmpty) ...[
            const SizedBox(
              height: 4.0,
            ),
            AppDualStyleTextWidget(
              icon: Icons.border_color,
              title: 'Admitter Note: ',
              description: admitterNote,
            ),
          ],
        ],
      );
}
