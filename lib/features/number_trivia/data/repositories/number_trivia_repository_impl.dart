import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../models/number_trivia_model.dart';
import '../../../../core/error/exception.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../datasources/number_trivia_remote_data_source.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTriviaModel> ConcreteOrRandom();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource _local;
  final NumberTriviaRemoteDataSource _remote;
  final NetworkInfo _network;
  NumberTriviaRepositoryImpl({
    @required NumberTriviaLocalDataSource local,
    @required NumberTriviaRemoteDataSource remote,
    @required NetworkInfo network,
  })  : _local = local,
        _remote = remote,
        _network = network;
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return getTrivia(() => _remote.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return getTrivia(() => _remote.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> getTrivia(
      ConcreteOrRandom getRandomOrTrivia) async {
    if (await _network.isConnected) {
      try {
        final remoteTrivia = await getRandomOrTrivia();
        _local.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await _local.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
