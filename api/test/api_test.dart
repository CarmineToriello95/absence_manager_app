import 'package:api/api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final CrewmeisterApi api = CrewmeisterApi(isTest: true);
  group('every member has key', () {
    ['id', 'name', 'userId', 'image'].forEach((key) {
      test(key, () async {
        List<dynamic> memberData = await api.members();
        memberData.forEach((member) {
          expect(member.containsKey(key), isTrue);
        });
      });
    });
  });

  group('every absence has key', () {
    [
      'admitterNote',
      'confirmedAt',
      'createdAt',
      'crewId',
      'endDate',
      'id',
      'memberNote',
      'rejectedAt',
      'startDate',
      'type',
      'userId',
    ].forEach((key) {
      test(key, () async {
        List<dynamic> absenceData = await api.absences();
        absenceData.forEach((absence) {
          expect(absence.containsKey(key), isTrue);
        });
      });
    });
  });
}
