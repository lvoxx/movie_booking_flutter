import 'package:freezed_annotation/freezed_annotation.dart';

part 'urban_word_event.freezed.dart';

@freezed
abstract class UrbanWordEvent with _$UrbanWordEvent {
  const factory UrbanWordEvent.getLocalDataStorage() = GetLocalDataStorage;
  const factory UrbanWordEvent.getFirstRandomUrbanWords() =
      GetFirstRandomUrbanWords;
  const factory UrbanWordEvent.retryInitApp() = RetryInitApp;
}
