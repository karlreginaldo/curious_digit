import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/error/exception.dart';
import 'package:tddtry4/core/error/failure.dart';
import 'package:tddtry4/core/network/network_info.dart';
import 'package:tddtry4/features/date_trivia/data/datasources/date_trivia_local_data_source.dart';
import 'package:tddtry4/features/date_trivia/data/datasources/date_trivia_remote_data_source.dart';
import 'package:tddtry4/features/date_trivia/data/models/date_trivia_model.dart';
import 'package:tddtry4/features/date_trivia/data/repositories/date_trivia_repository_impl.dart';
import 'package:tddtry4/features/date_trivia/domain/entities/date_trivia.dart';

import '../../../../fixture/fixture_reader.dart';

class MockDateTriviaRemoteDataSource extends Mock
    implements DateTriviaRemoteDataSource {}

class MockDateTriviaLocalDataSource extends Mock
    implements DateTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockDateTriviaRemoteDataSource mockRemote;
  MockDateTriviaLocalDataSource mockLocal;
  MockNetworkInfo mockNetwork;
  DateTriviaRepositoryImpl repository;

  setUp(() {
    mockRemote = MockDateTriviaRemoteDataSource();
    mockLocal = MockDateTriviaLocalDataSource();
    mockNetwork = MockNetworkInfo();
    repository = DateTriviaRepositoryImpl(
        local: mockLocal, network: mockNetwork, remote: mockRemote);
  });

  void runTestOnline(Function body) {
    group('Online', () {
      setUp(() {
        when(mockNetwork.isConnected)
            .thenAnswer((realInvocation) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('Offline', () {
      setUp(() {
        when(mockNetwork.isConnected)
            .thenAnswer((realInvocation) async => false);
      });
      body();
    });
  }

  group('getConcreteDatetrivia', () {
    final tMonth = 1;
    final tDay = 1;
    final tDateTriviaModel = DateTriviaModel.fromJson(fixture('date.json'));
    final DateTrivia tDateTrivia = tDateTriviaModel;

    runTestOnline(() {
      test('Should call the network.isConnected', () async {
        await repository.getConcreteDateTrivia(day: tDay, month: tMonth);

        verify(mockNetwork.isConnected);
      });

      test(
          'Should return DateTriviaModel when remoteDataSource has data and expect Right(DateTrivia)',
          () async {
        when(mockRemote.getConcreteDateTrivia(day: 1, month: 1))
            .thenAnswer((realInvocation) async => tDateTriviaModel);

        final actual =
            await repository.getConcreteDateTrivia(day: tDay, month: tMonth);

        expect(actual, Right(tDateTrivia));
      });

      test(
          'Should call the cachecDateTrivia when the remote data source has data',
          () async {
        when(mockRemote.getConcreteDateTrivia(day: 1, month: 1))
            .thenAnswer((realInvocation) async => tDateTriviaModel);
        await repository.getConcreteDateTrivia(day: tDay, month: tMonth);

        verify(mockLocal.cacheDateTrivia(tDateTriviaModel));
      });

      test('Should throw ServerException when remote data souce has no data',
          () async {
        when(mockRemote.getConcreteDateTrivia(day: 1, month: 1))
            .thenThrow(ServerException());

        final actual =
            await repository.getConcreteDateTrivia(day: tDay, month: tMonth);

        expect(actual, Left(ServerFailure()));
      });
    });

    runTestOffline(() {
      test('Should call the network.isConnected', () async {
        await repository.getConcreteDateTrivia(day: tDay, month: tMonth);

        verify(mockNetwork.isConnected);
      });

      test(
          'Should return NumberTriviaModel when localdatasource.getLastDateTrivia has data',
          () async {
        when(mockLocal.getLastDateTrivia())
            .thenAnswer((realInvocation) async => tDateTriviaModel);

        final actual =
            await repository.getConcreteDateTrivia(day: tDay, month: tMonth);

        expect(actual, Right(tDateTrivia));
      });
      test(
          'Should throw CacheException when localdatasource.getLastDateTrivia has no data',
          () async {
        when(mockLocal.getLastDateTrivia()).thenThrow(CacheException());

        final actual =
            await repository.getConcreteDateTrivia(day: tDay, month: tMonth);

        expect(actual, Left(CacheFailure()));
      });
    });
  });
}
