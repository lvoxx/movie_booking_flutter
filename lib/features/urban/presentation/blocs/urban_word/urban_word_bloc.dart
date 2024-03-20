import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:movie_booking/core/service/service_locator.dart' as di;
import 'package:movie_booking/features/urban/domain/usecases/get_local_urban_word.dart';
import 'package:movie_booking/features/urban/domain/usecases/random_urban_word.dart';
import 'package:movie_booking/features/urban/domain/usecases/save_local_urban_word.dart';
import 'package:movie_booking/features/urban/presentation/blocs/urban_word/urban_word_event.dart';
import 'package:movie_booking/features/urban/presentation/blocs/urban_word/urban_word_state.dart';

class UrbanWordBloc extends Bloc<UrbanWordEvent, UrbanWordState> {
  UrbanWordBloc(
    this._getLocalUrbanWord,
    this._randomUrbanWord,
    this._saveLocalUrbanWord,
  ) : super(const UrbanWordState.initial()) {
    on<GetLocalDataStorage>(_onGetLocalDataStorage);
    on<GetFirstRandomUrbanWords>(_onGetFirstRandomUrbanWords);
    on<RetryInitApp>(_onRetryInitApp);
  }

  final GetLocalUrbanWord _getLocalUrbanWord;
  final RandomUrbanWord _randomUrbanWord;
  final SaveLocalUrbanWord _saveLocalUrbanWord;

  FutureOr<void> _onGetLocalDataStorage(
      GetLocalDataStorage event, Emitter<UrbanWordState> emit) async {
    emit(const LoadingLocal());
    di.sl.get<Logger>().i('Emit Loading Local');
    final localResult = await _getLocalUrbanWord.call();
    localResult.fold((failure) {
      emit(LoadLocalFailed(failure));
      di.sl.get<Logger>().i('Emit Load Local Failed');
    }, (urbanWords) {
      emit(LoadedData(urbanWords));
      di.sl.get<Logger>().i('Emit Loaded Data');
    });
  }

  FutureOr<void> _onGetFirstRandomUrbanWords(
      GetFirstRandomUrbanWords event, Emitter<UrbanWordState> emit) async {
    emit(const LoadingRandom());
    di.sl.get<Logger>().i('Emit Loading Random');
    final randomResult = await _randomUrbanWord.call();
    randomResult.fold(
      (failure) {
        emit(InitFailed(failure));
        di.sl.get<Logger>().i('Emit Init Failed');
      },
      (urbanWords) {
        _saveLocalUrbanWord.call(urbanWords);
        di.sl.get<Logger>().i('Save Gotten Data To Local');
        emit(LoadedData(urbanWords));
        di.sl.get<Logger>().i('Emit Loaded Data');
      },
    );
  }

  FutureOr<void> _onRetryInitApp(
      RetryInitApp event, Emitter<UrbanWordState> emit) async {
    emit(const ReInitial());
    di.sl.get<Logger>().i('Emit Re Initial');
    final randomResult = await _randomUrbanWord.call();
    randomResult.fold(
      InitFailed.new,
      (urbanWords) {
        _saveLocalUrbanWord.call(urbanWords);
        di.sl.get<Logger>().i('Save Gotten Data To Local');
        emit(LoadedData(urbanWords));
        di.sl.get<Logger>().i('Emit Loaded Data');
      },
    );
  }
}
