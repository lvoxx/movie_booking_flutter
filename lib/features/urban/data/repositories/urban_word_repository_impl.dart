import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:movie_booking/core/error/exception.dart';
import 'package:movie_booking/core/error/failure.dart';
import 'package:movie_booking/core/network/network_info.dart';
import 'package:movie_booking/core/random/random_words.dart';
import 'package:movie_booking/core/utils/params.dart';
import 'package:movie_booking/core/utils/typedef.dart';
import 'package:movie_booking/features/urban/data/data_sources/local/urban_word_local_datasource.dart';
import 'package:movie_booking/features/urban/data/data_sources/remote/urban_word_remote_datasource.dart';
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';
import 'package:movie_booking/features/urban/domain/repositories/urban_word_repository.dart';

class UrbanWordRepositoryImpl implements UrbanWordRepository {
  const UrbanWordRepositoryImpl({
    required this.localDataSource,
    required this.remoteDatasource,
    required this.networkInfo,
  });
  final UrbanWordLocalDataSource localDataSource;
  final UrbanWordRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  @override
  ResultFuture<List<UrbanWord>> randomUrbanWord() async {
    if (!await networkInfo.isConnected) {
      return const Left(
        NetworkFailure(
          message: 'No network connection',
          httpStatus: HttpStatus.notFound,
        ),
      );
    }
    try {
      final randomIndex = Random().nextInt(urbanWords.length);
      final result = await remoteDatasource
          .getUrbanWords(UrbanWordParam(param: urbanWords[randomIndex]));
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          httpStatus: HttpStatus.notFound,
        ),
      );
    }
  }

  @override
  ResultFuture<List<UrbanWord>> searchUrbanWord(String query) async {
    try {
      final result =
          await remoteDatasource.getUrbanWords(UrbanWordParam(param: query));
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          httpStatus: HttpStatus.notFound,
        ),
      );
    }
  }

  @override
  ResultFuture<List<UrbanWord>> getLocalUrbanWord() async {
    late final List<UrbanWord> localResult;
    try {
      localResult = await localDataSource.getAllUrbanWords();
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          httpStatus: HttpStatus.notFound,
        ),
      );
    }
    if (localResult.isEmpty) {
      return const Left(
        CacheFailure(
          message: 'No local data found!',
          httpStatus: HttpStatus.notFound,
        ),
      );
    }
    return Right(localResult);
  }

  @override
  ResultVoid saveLocalUrbanWord(List<UrbanWord> urbanWords) async {
    if (await localDataSource.clearUrbanWords() == -1) {
      return const Left(
        CacheFailure(
          message: 'Can not connect to local store',
          httpStatus: HttpStatus.forbidden,
        ),
      );
    }
    await localDataSource.saveUrbanWords(urbanWords);
    return const Right(Future.value);
  }
}
