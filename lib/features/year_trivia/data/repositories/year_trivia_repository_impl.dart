import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/year_trivia_local_data_source.dart';
import '../datasources/year_trivia_remote_data_source.dart';
import '../models/year_trivia_model.dart';
import '../../domain/entities/year_trivia.dart';
import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/year_trivia_repository.dart';
import 'package:meta/meta.dart';

typedef Future<YearTriviaModel> _ConcreteOrRandom();

class YearTriviaRepositoryImpl implements YearTriviaRepository {
  final YearTriviaRemoteDataSource _remote;
  final YearTriviaLocalDataSource _local;
  final NetworkInfo _network;

  YearTriviaRepositoryImpl({
    @required YearTriviaLocalDataSource local,
    @required YearTriviaRemoteDataSource remote,
    @required NetworkInfo network,
  })  : _local = local,
        _remote = remote,
        _network = network;

  @override
  Future<Either<Failure, YearTrivia>> getConcreteYearTrivia(int year) async =>
      getTrivia(() => _remote.getConcreteYearTrivia(year));

  @override
  Future<Either<Failure, YearTrivia>> getRandomYearTrivia() async =>
      getTrivia(() => _remote.getRandomYearTrivia());

  Future<Either<Failure, YearTrivia>> getTrivia(
      _ConcreteOrRandom _concreteOrRandom) async {
    if (await _network.isConnected) {
      try {
        final remoteTrivia = await _concreteOrRandom();
        await _local.cacheYearTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await _local.getLastYearTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
