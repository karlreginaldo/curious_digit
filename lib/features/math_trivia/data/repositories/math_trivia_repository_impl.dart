import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import '../models/math_trivia_model.dart';
import '../../domain/entities/math_trivia.dart';
import '../../../../core/error/exception.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/math_trivia_local_data_source.dart';
import '../datasources/math_trivia_remote_data_source.dart';
import '../../domain/repositories/math_trivia_repository.dart';

typedef Future<MathTriviaModel> ConcreteOrRandom();

class MathTriviaRepositoryImpl implements MathTriviaRepository {
  final MathTriviaLocalDataSource _local;
  final MathTriviaRemoteDataSource _remote;
  final NetworkInfo _network;
  MathTriviaRepositoryImpl({
    @required MathTriviaLocalDataSource local,
    @required MathTriviaRemoteDataSource remote,
    @required NetworkInfo network,
  })  : _local = local,
        _remote = remote,
        _network = network;

  @override
  Future<Either<Failure, MathTrivia>> getConcreteMathTrivia(int number) async {
    return getTrivia(() => _remote.getConcreteMathTrivia(number));
  }

  @override
  Future<Either<Failure, MathTrivia>> getRandomMathTrivia() async {
    return getTrivia(() => _remote.getRandomMathTrivia());
  }

  Future<Either<Failure, MathTrivia>> getTrivia(
      ConcreteOrRandom getRandomOrTrivia) async {
    if (await _network.isConnected) {
      try {
        final remoteTrivia = await getRandomOrTrivia();
        _local.cacheMathTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await _local.getLastMathTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
