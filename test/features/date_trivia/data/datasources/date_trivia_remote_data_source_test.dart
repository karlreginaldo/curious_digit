import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tddtry4/features/date_trivia/data/datasources/date_trivia_remote_data_source.dart';

import '../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockClient;
  DateTriviaRemoteDataSourceImpl remote;

  setUp(() {
    mockClient = MockHttpClient();
    remote = DateTriviaRemoteDataSourceImpl(mockClient);
  });

  group('getConcreteDateTrivia', () {
    test('Should call get method in http', () async {
      await remote.getConcreteDateTrivia(day: 1, month: 1);

      verify(mockClient.get(any, headers: anyNamed('headers')));
    });
    group('200 Response', () {
      setUp(() {
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (realInvocation) async => http.Response(fixture('date.json'), 200));
      });
    });
  });
}
