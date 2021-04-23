import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/date_trivia_local_data_source.dart';
import '../datasources/date_trivia_remote_data_source.dart';
import '../models/date_trivia_model.dart';
import '../../domain/entities/date_trivia.dart';
import '../../domain/repositories/date_trivia_repository.dart';
import 'package:meta/meta.dart';

typedef Future<DateTriviaModel> ConcreteOrRandom();

class DateTriviaRepositoryImpl implements DateTriviaRepository {
  final DateTriviaRemoteDataSource _remote;
  final DateTriviaLocalDataSource _local;
  final NetworkInfo _network;

  DateTriviaRepositoryImpl({
    @required DateTriviaRemoteDataSource remote,
    @required DateTriviaLocalDataSource local,
    @required NetworkInfo network,
  })  : _remote = remote,
        _local = local,
        _network = network;

  @override
  Future<Either<Failure, DateTrivia>> getConcreteDateTrivia(
          {int month, int day}) =>
      getTrivia(() => _remote.getConcreteDateTrivia(day: day, month: month));

  @override
  Future<Either<Failure, DateTrivia>> getRandomDateTrivia() =>
      getTrivia(() => _remote.getRandomDateTrivia());

  Future<Either<Failure, DateTrivia>> getTrivia(
      ConcreteOrRandom _concreteOrRandom) async {
    if (await _network.isConnected) {
      try {
        final remoteTrivia = await _concreteOrRandom();
        await _local.cacheDateTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await _local.getLastDateTrivia();

        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
