import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tddtry4/features/date_trivia/data/datasources/date_trivia_local_data_source.dart';
import 'package:tddtry4/features/date_trivia/data/models/date_trivia_model.dart';

import '../../../../fixture/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockShared;
  DateTriviaLocalDataSourceImpl local;

  setUp(() {
    mockShared = MockSharedPreferences();
    local = DateTriviaLocalDataSourceImpl(mockShared);
  });

  group('cacheDateTrivia', () {
    final tDateTriviaModel = DateTriviaModel.fromJson(fixture('date.json'));

    test('Should cache the trivia into sharedPreferences', () async {
      await local.cacheDateTrivia(tDateTriviaModel);

      verify(
          mockShared.setString(CACHED_DATE_TRIVIA, tDateTriviaModel.toJson()));
    });
  });

  group('getLastDateTrivia', () {
    final tDateTriviaModel = DateTriviaModel.fromJson(fixture('date.json'));

    test('Should return NumberTriviaModel when there is a data', () async {
      when(mockShared.get(any))
          .thenAnswer((realInvocation) async => tDateTriviaModel.toJson());

      final actual = await local.getLastDateTrivia();

      expect(actual, tDateTriviaModel);
    });
  });
}
