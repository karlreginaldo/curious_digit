import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/error/exception.dart';
import 'package:tddtry4/core/error/failure.dart';
import 'package:tddtry4/core/network/network_info.dart';
import 'package:tddtry4/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tddtry4/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddtry4/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tddtry4/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:tddtry4/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixture/fixture_reader.dart';

class MockNumberTriviaLocalDataSource extends Mock
    implements NumberTriviaLocalDataSource {}

class MockNumberTriviaRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockNumberTriviaLocalDataSource mockLocal;
  MockNumberTriviaRemoteDataSource mockRemote;
  MockNetworkInfo mockNetwork;
  setUp(() {
    mockLocal = MockNumberTriviaLocalDataSource();
    mockRemote = MockNumberTriviaRemoteDataSource();
    mockNetwork = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      local: mockLocal,
      remote: mockRemote,
      network: mockNetwork,
    );
  });

  void internetAvailable(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetwork.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void internetIsNotAvailable(Function body) {
    group('Offline', () {
      setUp(() {
        when(mockNetwork.isConnected)
            .thenAnswer((realInvocation) async => false);
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTrivialModel =
        NumberTriviaModel.fromJson(fixture('trivia.json'));
    final NumberTrivia tNumberTrivia = tNumberTrivialModel;

    internetAvailable(() {
      test('Check if the network.isConnected is called', () async {
        repository.getConcreteNumberTrivia(tNumber);

        verify(mockNetwork.isConnected);
      });

      test(
          'Should return NumberTrivia when the RemoteDataSource gives NumberTriviaModel',
          () async {
        when(mockRemote.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => tNumberTrivialModel);

        final actual = await repository.getConcreteNumberTrivia(tNumber);

        expect(actual, Right(tNumberTrivia));
      });
      test(
          'Should cache the NumberTrivia when the RemoteDataSource gives NumberTriviaModel',
          () async {
        when(mockRemote.getConcreteNumberTrivia(any))
            .thenAnswer((realInvocation) async => tNumberTrivialModel);

        await repository.getConcreteNumberTrivia(tNumber);

        verify(mockLocal.cacheNumberTrivia(tNumberTrivialModel));
      });

      test(
          'Should return Left(ServerFailure)❌ if RemoteDataSource throw ServerException',
          () async {
        when(mockRemote.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

        final actual = await repository.getConcreteNumberTrivia(tNumber);
        expect(actual, Left(ServerFailure()));
      });
    });

    internetIsNotAvailable(() {
      test(
          'Sould return LastTrivia if there is no internet connection when calling LocalDataSource',
          () async {
        when(mockLocal.getLastNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTrivialModel);

        final actual = await repository.getConcreteNumberTrivia(tNumber);

        expect(actual, Right(tNumberTrivia));
        verifyNoMoreInteractions(mockRemote);
      });

      test(
          'Should return Left(CacheFailure)❌ when LocalDataSource throw CacheException',
          () async {
        when(mockLocal.getLastNumberTrivia()).thenThrow(CacheException());

        final actual = await repository.getConcreteNumberTrivia(tNumber);

        expect(actual, Left(CacheFailure()));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTrivialModel =
        NumberTriviaModel.fromJson(fixture('trivia.json'));
    final NumberTrivia tNumberTrivia = tNumberTrivialModel;

    internetAvailable(() {
      test('Check if the network.isConnected is called', () async {
        repository.getRandomNumberTrivia();

        verify(mockNetwork.isConnected);
      });

      test(
          'Should return NumberTrivia when the RemoteDataSource gives NumberTriviaModel',
          () async {
        when(mockRemote.getRandomNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTrivialModel);

        final actual = await repository.getRandomNumberTrivia();

        expect(actual, Right(tNumberTrivia));
      });
      test(
          'Should cache the NumberTrivia when the RemoteDataSource gives NumberTriviaModel',
          () async {
        when(mockRemote.getRandomNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTrivialModel);

        await repository.getRandomNumberTrivia();

        verify(mockLocal.cacheNumberTrivia(tNumberTrivialModel));
      });

      test(
          'Should return Left(ServerFailure)❌ if RemoteDataSource throw ServerException',
          () async {
        when(mockRemote.getRandomNumberTrivia()).thenThrow(ServerException());

        final actual = await repository.getRandomNumberTrivia();
        expect(actual, Left(ServerFailure()));
      });
    });

    internetIsNotAvailable(() {
      test(
          'Sould return LastTrivia if there is no internet connection when calling LocalDataSource',
          () async {
        when(mockLocal.getLastNumberTrivia())
            .thenAnswer((realInvocation) async => tNumberTrivialModel);

        final actual = await repository.getRandomNumberTrivia();

        expect(actual, Right(tNumberTrivia));
        verifyNoMoreInteractions(mockRemote);
      });

      test(
          'Should return Left(CacheFailure)❌ when LocalDataSource throw CacheException',
          () async {
        when(mockLocal.getLastNumberTrivia()).thenThrow(CacheException());

        final actual = await repository.getRandomNumberTrivia();

        expect(actual, Left(CacheFailure()));
      });
    });
  });
}
