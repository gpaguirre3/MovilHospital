import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/network/dio_client.dart';
import '../../core/network/network_info.dart';
import '../../core/storage/local_storage.dart';
import '../../features/activities/data/datasources/activity_remote_datasource.dart';
import '../../features/activities/data/repositories/activity_repository_impl.dart';
import '../../features/activities/domain/repositories/activity_repository.dart';
import '../../features/activities/domain/usecases/get_activities_usecase.dart';
import '../../features/activities/presentation/bloc/activities_bloc.dart';
import '../../features/assignments/data/datasources/assignment_remote_datasource.dart';
import '../../features/assignments/data/repositories/assignment_repository_impl.dart';
import '../../features/assignments/domain/repositories/assignment_repository.dart';
import '../../features/assignments/domain/usecases/get_assignments_usecase.dart';
import '../../features/assignments/presentation/bloc/assignments_bloc.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/hospitals/data/datasources/hospital_remote_datasource.dart';
import '../../features/hospitals/data/repositories/hospital_repository_impl.dart';
import '../../features/hospitals/domain/repositories/hospital_repository.dart';
import '../../features/hospitals/domain/usecases/get_hospitals_usecase.dart';
import '../../features/hospitals/domain/usecases/update_hospital_assignment_usecase.dart';
import '../../features/hospitals/presentation/bloc/hospitals_bloc.dart';
import '../../features/records/data/datasources/record_remote_datasource.dart';
import '../../features/records/data/repositories/record_repository_impl.dart';
import '../../features/records/domain/repositories/record_repository.dart';
import '../../features/records/domain/usecases/get_records_usecase.dart';
import '../../features/records/presentation/bloc/records_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Dio>(() => Dio());

  // Core
  sl.registerLazySingleton<LocalStorage>(() => LocalStorageImpl(sl()));
  sl.registerLazySingleton<DioClient>(() => DioClient(sl(), sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HospitalRemoteDataSource>(
    () => HospitalRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AssignmentRemoteDataSource>(
    () => AssignmentRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<RecordRemoteDataSource>(
    () => RecordRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ActivityRemoteDataSource>(
    () => ActivityRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<HospitalRepository>(
    () => HospitalRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AssignmentRepository>(
    () => AssignmentRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<RecordRepository>(
    () => RecordRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ActivityRepository>(
    () => ActivityRepositoryImpl(sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => GetHospitalsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHospitalAssignmentUseCase(sl()));
  sl.registerLazySingleton(() => GetAssignmentsUseCase(sl()));
  sl.registerLazySingleton(() => GetRecordsUseCase(sl()));
  sl.registerLazySingleton(() => GetActivitiesUseCase(sl()));
  sl.registerLazySingleton(() => GetSubactivitiesUseCase(sl()));

  // Blocs
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => HospitalsBloc(
      getHospitalsUseCase: sl(),
      updateHospitalAssignmentUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => AssignmentsBloc(
      getAssignmentsUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => RecordsBloc(
      getRecordsUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ActivitiesBloc(
      getActivitiesUseCase: sl(),
      getSubactivitiesUseCase: sl(),
    ),
  );
}
