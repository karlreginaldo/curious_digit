import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
import '../models/year_trivia_model.dart';

abstract class YearTriviaLocalDataSource {
  Future<YearTriviaModel> getLastYearTrivia();
  Future<void> cacheYearTrivia(YearTriviaModel triviaToCache);
}

const String CACHED_YEAR_TRIVIA = 'CACHE_YEAR_TRIVIA';

class YearTriviaLocalDataSourceImpl implements YearTriviaLocalDataSource {
  final SharedPreferences _shared;

  YearTriviaLocalDataSourceImpl(this._shared);

  @override
  Future<void> cacheYearTrivia(YearTriviaModel trivia) =>
      _shared.setString(CACHED_YEAR_TRIVIA, trivia.toJson());

  @override
  Future<YearTriviaModel> getLastYearTrivia() async {
    final cachedString = _shared.getString(CACHED_YEAR_TRIVIA);

    return cachedString != null
        ? YearTriviaModel.fromJson(cachedString)
        : throw CacheException();
  }
}
