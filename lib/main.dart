import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:movie_booking/app/app_init.dart' as app_init;
import 'package:movie_booking/app/urban_app.dart';
import 'package:movie_booking/core/service/service_locator.dart' as di;

void main() {
  runZonedGuarded(() async {
    await app_init.initHiveBox();
    await app_init.appInit();
    runApp(const UrbanApp());
  }, (e, st) {
    di.sl.get<Logger>().f('Init App Failed', error: e, stackTrace: st);
  });
}
