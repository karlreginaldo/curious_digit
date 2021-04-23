
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
import '../models/date_trivia_model.dart';

abstract class DateTriviaLocalDataSource {
  Future<DateTriviaModel> getLastDateTrivia();
  Future<void> cacheDateTrivia(DateTriviaModel trivia);
}

const String CACHED_DATE_TRIVIA = 'CACHED_DATE_TRIVIA';

class DateTriviaLocalDataSourceImpl implements DateTriviaLocalDataSource {
  final SharedPreferences _shared;

  DateTriviaLocalDataSourceImpl(this._shared);
  @override
  Future<void> cacheDateTrivia(DateTriviaModel trivia) async =>
      _shared.setString(CACHED_DATE_TRIVIA, trivia.toJson());

  @override
  Future<DateTriviaModel> getLastDateTrivia() async {
    final cachedString = _shared.getString(CACHED_DATE_TRIVIA);

    return cachedString != null
        ? DateTriviaModel.fromJson(cachedString)
        : throw CacheException();
  }
}
