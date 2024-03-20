import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:movie_booking/core/constant/string.dart' as api;
import 'package:movie_booking/core/service/service_locator.dart' as di;
import 'package:movie_booking/core/error/exception.dart';
import 'package:movie_booking/core/utils/params.dart';
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';

abstract class UrbanWordRemoteDatasource {
  Future<List<UrbanWord>> getUrbanWords(UrbanWordParam param);
}

class UrbanWordRemoteDatasourceImpl implements UrbanWordRemoteDatasource {
  UrbanWordRemoteDatasourceImpl({required this.dio});
  final Dio dio;

  @override
  Future<List<UrbanWord>> getUrbanWords(UrbanWordParam param) async {
    final response = await dio.get<Map<String, dynamic>>(
      api.baseUrl,
      options: Options(headers: api.headers),
      queryParameters: {api.paramName: param.param},
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ServerException(response.statusMessage!);
    }
    if (response.data == null) {
      throw const ServerException('No such result found!');
    }
    //di.sl.get<Logger>().i(jsonEncode(response.data!['list']));
    return UrbanWord.fromJsonList(response.data!['list'] as List<dynamic>);
  }
}
