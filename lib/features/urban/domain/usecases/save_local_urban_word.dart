import 'package:movie_booking/core/utils/typedef.dart';
import 'package:movie_booking/core/utils/usecase.dart';
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';
import 'package:movie_booking/features/urban/domain/repositories/urban_word_repository.dart';

class SaveLocalUrbanWord extends UsecaseWithParams<void, List<UrbanWord>> {
  const SaveLocalUrbanWord({required UrbanWordRepository repository})
      : _repository = repository;
  final UrbanWordRepository _repository;

  @override
  ResultFuture<void> call(List<UrbanWord> params) async =>
      _repository.saveLocalUrbanWord(params);
}
