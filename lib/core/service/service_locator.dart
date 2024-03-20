import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:movie_booking/core/network/network_info.dart';
import 'package:movie_booking/features/urban/data/data_sources/local/urban_word_local_datasource.dart';
import 'package:movie_booking/features/urban/data/data_sources/remote/urban_word_remote_datasource.dart';
import 'package:movie_booking/features/urban/data/repositories/urban_word_repository_impl.dart';
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';
import 'package:movie_booking/features/urban/domain/repositories/urban_word_repository.dart';
import 'package:movie_booking/features/urban/domain/usecases/get_local_urban_word.dart';
import 'package:movie_booking/features/urban/domain/usecases/random_urban_word.dart';
import 'package:movie_booking/features/urban/domain/usecases/save_local_urban_word.dart';
import 'package:movie_booking/features/urban/presentation/blocs/urban_word/urban_word_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl
    ..registerFactoryAsync<Box<UrbanWord>>(
      () => Hive.openBox<UrbanWord>('urbanWordBox'),
    )
    ..registerFactory(() => UrbanWordBloc(sl(), sl(), sl()))
    ..registerLazySingleton(() => GetLocalUrbanWord(repository: sl()))
    ..registerLazySingleton(() => RandomUrbanWord(repository: sl()))
    ..registerLazySingleton(() => SaveLocalUrbanWord(repository: sl()))
    ..registerLazySingleton<UrbanWordRepository>(
      () => UrbanWordRepositoryImpl(
        localDataSource: sl(),
        remoteDatasource: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()),
    )
    ..registerLazySingleton(InternetConnectionChecker.new)
    ..registerLazySingleton<UrbanWordLocalDataSource>(
      UrbanWordLocalDataSourceImpl.new,
    )
    ..registerLazySingleton<UrbanWordRemoteDatasource>(
      () => UrbanWordRemoteDatasourceImpl(dio: sl()),
    )
    ..registerFactory(Dio.new)
    ..registerLazySingleton(
      () => Logger(
        printer: PrettyPrinter(),
      ),
    );
}
