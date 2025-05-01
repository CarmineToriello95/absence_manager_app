// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:api/api.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'di_config.dart' as _i10;
import 'features/absence_manager/data/datasources/remote_data_source.dart'
    as _i4;
import 'features/absence_manager/data/repositories/absence_manager_repository_impl.dart'
    as _i6;
import 'features/absence_manager/domain/repositories/absence_manager_repository.dart'
    as _i5;
import 'features/absence_manager/domain/usecases/fetch_absences_usecase.dart'
    as _i7;
import 'features/absence_manager/domain/usecases/fetch_members_usecase.dart'
    as _i8;
import 'features/absence_manager/presentation/cubit/absence_manager_cubit.dart'
    as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.CrewmeisterApi>(() => registerModule.apiClient);
    gh.factory<_i4.RemoteDataSource>(
        () => _i4.RemoteDataSourceImpl(gh<_i3.CrewmeisterApi>()));
    gh.factory<_i5.AbsenceManagerRepository>(
        () => _i6.AbsenceManagerRepositoryImpl(gh<_i4.RemoteDataSource>()));
    gh.factory<_i7.FetchAbsencesUsecase>(
        () => _i7.FetchAbsencesUsecase(gh<_i5.AbsenceManagerRepository>()));
    gh.factory<_i8.FetchMembersUsecase>(
        () => _i8.FetchMembersUsecase(gh<_i5.AbsenceManagerRepository>()));
    gh.lazySingleton<_i9.AbsenceManagerCubit>(() => _i9.AbsenceManagerCubit(
          gh<_i7.FetchAbsencesUsecase>(),
          gh<_i8.FetchMembersUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
