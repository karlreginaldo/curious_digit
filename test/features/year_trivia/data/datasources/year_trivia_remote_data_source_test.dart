import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/error/exception.dart';
import 'package:tddtry4/features/year_trivia/data/datasources/year_trivia_remote_data_source.dart';
import 'package:tddtry4/features/year_trivia/data/models/year_trivia_model.dart';

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  YearTriviaRemoteDataSourceImpl remote;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remote = YearTriviaRemoteDataSourceImpl(mockHttpClient);
  });

  void response200(Function body) {
    group('HTTP 200 RESPONSE', () {
      setUp(() {
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (realInvocation) async =>
                http.Response(fixture('trivia.json'), 200));
      });

      body();
    });
  }

  void response404(Function body) {
    group('HTTP 404 RESPONSE', () {
      setUp(() {
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (realInvocation) async =>
                http.Response('Something went wrong', 404));
      });

      body();
    });
  }

  group('getConcreteYearTrivia', () {
    final tYear = 1;
    final tYearTriviaModel = YearTriviaModel.fromJson(fixture('trivia.json'));

    response200(() {
      test('Should return NumberTriviaModel', () async {
        final actual = await remote.getConcreteYearTrivia(tYear);

        expect(actual, tYearTriviaModel);
      });
    });

    response404(() {
      test('Should throw ServerException', () async {
        final actual = remote.getConcreteYearTrivia;

        expect(() => actual(tYear), throwsA(isA<ServerException>()));
      });
    });
  });

  group('getRandomYearTrivia', () {
    final tYearTriviaModel = YearTriviaModel.fromJson(fixture('trivia.json'));

    response200(() {
      test('Should return NumberTriviaModel', () async {
        final actual = await remote.getRandomYearTrivia();

        expect(actual, tYearTriviaModel);
      });
    });

    response404(() {
      test('Should throw CacheException', () async {
        final actual = remote.getRandomYearTrivia;

        expect(() => actual(), throwsA(isA<ServerException>()));
      });
    });
  });
}
