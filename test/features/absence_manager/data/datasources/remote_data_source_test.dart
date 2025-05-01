import 'dart:convert';
import 'dart:io';

import 'package:api/api.dart';
import 'package:crewmeister_frontend_coding_challenge/core/error/absence_manager/absence_manager_exceptions.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/datasources/remote_data_source.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/models/absence_model.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/models/member_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/mocks.mocks.dart';

void main() {
  late RemoteDataSource dataSource;
  late CrewmeisterApi mockApi;

  setUp(() {
    mockApi = MockCrewmeisterApi();
    dataSource = RemoteDataSourceImpl(mockApi);
  });

  group('RemoteDataSource', () {
    test(
      'WHEN requesting the absences is successful THEN return a list of AbsenceModel',
      () async {
        /// arrange
        final String fileContent =
            await File('api/assets/json_files/absences.json').readAsString();
        final List<dynamic> tAbsencesJsonFormat =
            jsonDecode(fileContent)['payload'];
        final List<AbsenceModel> tAbsences =
            tAbsencesJsonFormat.map((e) => AbsenceModel.fromJson(e)).toList();
        when(mockApi.absences()).thenAnswer((_) async => tAbsencesJsonFormat);

        /// act
        final result = await dataSource.fetchAbsences();

        /// assert
        expect(result, tAbsences);
        verify(mockApi.absences()).called(1);
        verifyNoMoreInteractions(mockApi);
      },
    );

    test(
      'WHEN an exception occurs while calling the api for fetching absences THEN throw a FetchAbsencesException',
      () async {
        /// arrange
        when(mockApi.absences()).thenThrow((_) => Exception());

        /// assert
        expect(
            dataSource.fetchAbsences(), throwsA(isA<FetchAbsencesException>()));
        verify(mockApi.absences()).called(1);
        verifyNoMoreInteractions(mockApi);
      },
    );

    test(
      'WHEN requesting the members is successful THEN return a list of MemberModel',
      () async {
        /// arrange
        final String fileContent =
            await File('api/assets/json_files/members.json').readAsString();
        final List<dynamic> tMembersJsonFormat =
            jsonDecode(fileContent)['payload'];
        final List<MemberModel> tMembers =
            tMembersJsonFormat.map((e) => MemberModel.fromJson(e)).toList();
        when(mockApi.members()).thenAnswer((_) async => tMembersJsonFormat);

        /// act
        final result = await dataSource.fetchMembers();

        /// assert
        expect(result, tMembers);
        verify(mockApi.members()).called(1);
        verifyNoMoreInteractions(mockApi);
      },
    );

    test(
      'WHEN an exception occurs while calling the api for fetching members THEN throw a FetchMembersException',
      () async {
        /// arrange
        when(mockApi.members()).thenThrow((_) => Exception());

        /// assert
        expect(
            dataSource.fetchMembers(), throwsA(isA<FetchMembersException>()));
        verify(mockApi.members()).called(1);
        verifyNoMoreInteractions(mockApi);
      },
    );
  });
}
