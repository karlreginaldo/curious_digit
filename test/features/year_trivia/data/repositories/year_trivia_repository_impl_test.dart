import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/error/exception.dart';
import 'package:tddtry4/core/error/failure.dart';
import 'package:tddtry4/core/network/network_info.dart';
import 'package:tddtry4/features/year_trivia/data/datasources/year_trivia_local_data_source.dart';
import 'package:tddtry4/features/year_trivia/data/datasources/year_trivia_remote_data_source.dart';
import 'package:tddtry4/features/year_trivia/data/models/year_trivia_model.dart';
import 'package:tddtry4/features/year_trivia/data/repositories/year_trivia_repository_impl.dart';

import '../../../../fixture/fixture_reader.dart';

class MockYearTriviaRemoteDataSource extends Mock
    implements YearTriviaRemoteDataSource {}

class MockYearTriviaLocalDataSource extends Mock
    implements YearTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  YearTriviaRepositoryImpl repository;
  MockNetworkInfo mockNetwork;
  MockYearTriviaRemoteDataSource mockRemote;
  MockYearTriviaLocalDataSource mockLocal;

  setUp(() {
    mockNetwork = MockNetworkInfo();
    mockRemote = MockYearTriviaRemoteDataSource();
    mockLocal = MockYearTriviaLocalDataSource();
    repository = YearTriviaRepositoryImpl(
      local: mockLocal,
      network: mockNetwork,
      remote: mockRemote,
    );
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

  group('getConcreteYearTrivia', () {
    final tYear = 1;
    final tYearTriviaModel = YearTriviaModel.fromJson(fixture('trivia.json'));
    final tYearTrivia = tYearTriviaModel;
    runTestOnline(() {
      test('should call the network info', () async {
        await repository.getConcreteYearTrivia(tYear);

        verify(mockNetwork.isConnected);
      });

      test('should return YearTriviaModel when remoteDataSource has data',
          () async {
        when(mockRemote.getConcreteYearTrivia(any))
            .thenAnswer((realInvocation) async => tYearTriviaModel);

        final actual = await repository.getConcreteYearTrivia(tYear);

        expect(actual, Right(tYearTrivia));
      });

      test('should return Failure when remoteDataSource has no data', () async {
        when(mockRemote.getConcreteYearTrivia(any))
            .thenThrow(ServerException());

        final actual = await repository.getConcreteYearTrivia(tYear);

        expect(actual, Left(ServerFailure()));
      });

      test('should call cacheYearTrivia when remoteDataSource has data',
          () async {
        when(mockRemote.getConcreteYearTrivia(any))
            .thenAnswer((realInvocation) async => tYearTriviaModel);

        await repository.getConcreteYearTrivia(tYear);

        verify(mockLocal.cacheYearTrivia(tYearTriviaModel));
      });
    });

    runTestOffline(() {
      group('getLastYearTrivia', () {
        test('should return YearTrivia when localdatasource has data',
            () async {
          when(mockLocal.getLastYearTrivia())
              .thenAnswer((realInvocation) async => tYearTriviaModel);

          final actual = await repository.getConcreteYearTrivia(tYear);

          expect(actual, Right(tYearTrivia));
        });

        test('should return Failure when localdatasource has no data',
            () async {
          when(mockLocal.getLastYearTrivia()).thenThrow(CacheException());

          final actual = await repository.getConcreteYearTrivia(tYear);

          expect(actual, Left(CacheFailure()));
        });
      });
    });
  });

  group('getRandomYearTrivia', () {
    final tYearTriviaModel = YearTriviaModel.fromJson(fixture('trivia.json'));
    final tYearTrivia = tYearTriviaModel;
    runTestOnline(() {
      test('should call the network info', () async {
        await repository.getRandomYearTrivia();

        verify(mockNetwork.isConnected);
      });

      test('should return YearTriviaModel when remoteDataSource has data',
          () async {
        when(mockRemote.getRandomYearTrivia())
            .thenAnswer((realInvocation) async => tYearTriviaModel);

        final actual = await repository.getRandomYearTrivia();

        expect(actual, Right(tYearTrivia));
      });

      test('should return Failure when remoteDataSource has no data', () async {
        when(mockRemote.getRandomYearTrivia()).thenThrow(ServerException());

        final actual = await repository.getRandomYearTrivia();

        expect(actual, Left(ServerFailure()));
      });

      test('should call cacheYearTrivia when remoteDataSource has data',
          () async {
        when(mockRemote.getRandomYearTrivia())
            .thenAnswer((realInvocation) async => tYearTriviaModel);

        await repository.getRandomYearTrivia();

        verify(mockLocal.cacheYearTrivia(tYearTriviaModel));
      });
    });

    runTestOffline(() {
      group('getLastYearTrivia', () {
        test('should return YearTrivia when localdatasource has data',
            () async {
          when(mockLocal.getLastYearTrivia())
              .thenAnswer((realInvocation) async => tYearTriviaModel);

          final actual = await repository.getRandomYearTrivia();

          expect(actual, Right(tYearTrivia));
        });

        test('should return Failure when localdatasource has no data',
            () async {
          when(mockLocal.getLastYearTrivia()).thenThrow(CacheException());

          final actual = await repository.getRandomYearTrivia();

          expect(actual, Left(CacheFailure()));
        });
      });
    });
  });
}
