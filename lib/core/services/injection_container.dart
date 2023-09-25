import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gaze/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:gaze/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/auth/domain/usecases/sign_in.dart';
import 'package:gaze/features/auth/domain/usecases/sign_up.dart';
import 'package:gaze/features/auth/domain/usecases/update_user.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaze/features/series/data/data_sources/series_remote_data_source.dart';
import 'package:gaze/features/series/data/repositories/series_repo_impl.dart';
import 'package:gaze/features/series/domain/repositories/series_repo.dart';
import 'package:gaze/features/series/domain/usecases/get_popular_series.dart';
import 'package:gaze/features/series/presentation/bloc/series_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _seriesInit();
  await _authInit();
}

Future<void> _seriesInit() async {
  sl
    ..registerFactory(() => SeriesBloc(getPopularSeries: sl()))

    ..registerLazySingleton(() => GetPopularSeriesUseCase(sl()))

    ..registerLazySingleton<SeriesRepo>(() => SeriesRepoImpl(sl()))

    ..registerLazySingleton<SeriesRemoteDataSource>(
      SeriesRemoteDataSourceImpl.new,
    );


}

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        updateUser: sl(),
      ),
    )

    //Use Cases
    ..registerLazySingleton(() => SignInUseCase(sl()))
    ..registerLazySingleton(() => SignUpUseCase(sl()))
    ..registerLazySingleton(() => UpdateUserUseCase(sl()))

    //Repository
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))

    //Data Source
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )

    //Firebase
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}
