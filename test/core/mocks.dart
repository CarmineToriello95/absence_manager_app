import 'package:api/api.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/data/datasources/remote_data_source.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/domain/repositories/absence_manager_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  AbsenceManagerRepository,
  CrewmeisterApi,
  RemoteDataSource,
])
class Mocks {}
