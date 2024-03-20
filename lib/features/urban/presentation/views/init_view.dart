import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking/core/constant/string.dart' as router;
import 'package:movie_booking/features/urban/presentation/blocs/urban_word/urban_word_bloc.dart';
import 'package:movie_booking/features/urban/presentation/blocs/urban_word/urban_word_event.dart';
import 'package:movie_booking/features/urban/presentation/blocs/urban_word/urban_word_state.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UrbanWordBloc, UrbanWordState>(
      listener: (context, state) {
        state.whenOrNull(
          loadLocalFailed: (failure) => BlocProvider.of<UrbanWordBloc>(context)
              .add(const GetFirstRandomUrbanWords()),
          loadedData: (data) {
            FlutterNativeSplash.remove();
            context.go(router.skeletonRoute);
          },
          initFailed: (failure) {
            FlutterNativeSplash.remove();
            context.go(router.notFoundRoute);
          },
        );
      },
      child: Scaffold(
        body: Container(),
        backgroundColor: Colors.white,
      ),
    );
  }
}
