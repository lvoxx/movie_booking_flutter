import 'package:movie_booking/core/utils/typedef.dart';
import 'package:movie_booking/core/utils/usecase.dart';
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';
import 'package:movie_booking/features/urban/domain/repositories/urban_word_repository.dart';

class RandomUrbanWord extends UsecaseWithoutParams<List<UrbanWord>> {
  const RandomUrbanWord({required UrbanWordRepository repository})
      : _repository = repository;
  final UrbanWordRepository _repository;

  @override
  ResultFuture<List<UrbanWord>> call() async => _repository.randomUrbanWord();
}
