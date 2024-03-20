import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_booking/core/error/failure.dart';
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';

part 'urban_word_state.freezed.dart';

@freezed
abstract class UrbanWordState with _$UrbanWordState {
  const factory UrbanWordState.initial() = Initial;
  const factory UrbanWordState.reInitial() = ReInitial;
  const factory UrbanWordState.loadingLocal() = LoadingLocal;
  const factory UrbanWordState.loadingRandom() = LoadingRandom;
  const factory UrbanWordState.loadedData(List<UrbanWord> data) = LoadedData;
  const factory UrbanWordState.initFailed(Failure failure) = InitFailed;
  const factory UrbanWordState.loadLocalFailed(Failure failure) =
      LoadLocalFailed;
}
