import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/error/exception.dart';
import 'package:tddtry4/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tddtry4/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockClient;
  NumberTriviaRemoteDataSourceImpl remote;
  setUp(() {
    mockClient = MockHttpClient();
    remote = NumberTriviaRemoteDataSourceImpl(mockClient);
  });

  void http200Response(Function body) {
    group('200 Response ✔', () {
      setUp(() {
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (realInvocation) async =>
                http.Response(fixture('trivia.json'), 200));
      });

      body();
    });
  }

  void http404Response(Function body) {
    group('404 Response ❌', () {
      setUp(() {
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (realInvocation) async =>
                http.Response('Something Went Wrong', 404));
      });

      body();
    });
  }

  group('getConcreteNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(fixture('trivia.json'));
    final tNumber = 1;
    http200Response(() {
      test('Should return NumberTriviaModel when client Response is 200',
          () async {
        final actual = await remote.getConcreteNumberTrivia(tNumber);

        expect(actual, tNumberTriviaModel);
        verify(mockClient.get(
          'http://numbersapi.com/$tNumber',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      });
    });

    http404Response(() {
      test(
          'Should throw ServerException when client Response Status Code is 404 or > 200',
          () async {
        final actual = remote.getConcreteNumberTrivia;

        expect(() => actual(tNumber), throwsA(isA<ServerException>()));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(fixture('trivia.json'));
    http200Response(() {
      test('Should return NumberTriviaModel when client Response is 200',
          () async {
        final actual = await remote.getRandomNumberTrivia();

        expect(actual, tNumberTriviaModel);
        verify(mockClient.get(
          'http://numbersapi.com/random',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      });
    });

    http404Response(() {
      test(
          'Should throw ServerException when client Response Status Code is 404 or > 200',
          () async {
        final actual = remote.getRandomNumberTrivia;

        expect(() => actual(), throwsA(isA<ServerException>()));
      });
    });
  });
}
