import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_booking/common/routes/AppRouter.dart';
import 'package:movie_booking/common/theme/app_theme.dart';
import 'package:movie_booking/core/service/service_locator.dart' as di;
import 'package:movie_booking/features/urban/presentation/blocs/urban_word/urban_word_bloc.dart';
import 'package:movie_booking/features/urban/presentation/blocs/urban_word/urban_word_event.dart';
import 'package:oktoast/oktoast.dart';

class UrbanApp extends StatelessWidget {
  const UrbanApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<UrbanWordBloc>()
            ..add(const UrbanWordEvent.getLocalDataStorage()),
        )
      ],
      child: OKToast(
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.routes,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
