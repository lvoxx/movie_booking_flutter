import 'package:movie_booking/core/utils/typedef.dart';
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';

abstract class UrbanWordRepository {
  const UrbanWordRepository();

  ResultFuture<List<UrbanWord>> randomUrbanWord();

  ResultFuture<List<UrbanWord>> searchUrbanWord(String query);

  ResultFuture<List<UrbanWord>> getLocalUrbanWord();

  ResultVoid saveLocalUrbanWord(List<UrbanWord> urbanWords);
}
