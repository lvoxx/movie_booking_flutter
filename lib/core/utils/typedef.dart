import 'package:dartz/dartz.dart';

import 'package:movie_booking/core/error/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFuture<void>;
