import 'package:crewmeister_frontend_coding_challenge/core/error/absence_manager/absence_manager_exceptions.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/models/absence_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/models/member_model.dart';
import 'package:api/api.dart';

abstract class RemoteDataSource {
  /// Calls the api for fetching the absences
  ///
  /// Throws a [FetchAbsencesException] if an error occurs with the request.
  Future<List<AbsenceModel>> fetchAbsences();

  /// Calls the api for fetching the absences
  ///
  /// Throws a [FetchMembersException] if an error occurs with the request.
  Future<List<MemberModel>> fetchMembers();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final CrewmeisterApi apiClient;

  RemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<AbsenceModel>> fetchAbsences() async {
    try {
      final List<dynamic> response = await apiClient.absences();
      return response.map((e) => AbsenceModel.fromJson(e)).toList();
    } catch (e) {
      throw const FetchAbsencesException('Error while requesting the absences');
    }
  }

  @override
  Future<List<MemberModel>> fetchMembers() async {
    try {
      final List<dynamic> response = await apiClient.members();
      return response.map((e) => MemberModel.fromJson(e)).toList();
    } catch (e) {
      throw const FetchMembersException('Error while requesting the members');
    }
  }
}
