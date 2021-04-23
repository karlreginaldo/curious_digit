import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  ///THIS METHOD WILL CALL IF THE THERE INTERNET IS NOT AVAILABLE
  ///
  ///THROW [CACHEEXCEPTION] IF THE THERE IS NO DATA IN [SHAREDPREFERENCES]
  Future<NumberTriviaModel> getLastNumberTrivia();

  ///THIS METHOD SHOULD CALL TO CACHE NUMBERTRIVIAMODEL IN [SHAREDPREFERENCES]
  Future<void> cacheNumberTrivia(NumberTriviaModel trivia);
}

const String CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences _shared;

  NumberTriviaLocalDataSourceImpl(this._shared);

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel trivia) {
    return _shared.setString(CACHED_NUMBER_TRIVIA, trivia.toJson());
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() async {
    final cachedString = _shared.getString(CACHED_NUMBER_TRIVIA);

    return cachedString != null
        ? NumberTriviaModel.fromJson(cachedString)
        : throw CacheException();
  }
}
