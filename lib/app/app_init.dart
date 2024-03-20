import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_booking/core/service/service_locator.dart' as di;
import 'package:movie_booking/features/urban/domain/entities/urban_word.dart';

Future<void> appInit() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await Hive.initFlutter();
  await di.initServiceLocator();
}

Future<void> initHiveBox() async {
  Hive.registerAdapter(UrbanWordAdapter());
}
