import 'package:shared_preferences/shared_preferences.dart';
import '../models/math_trivia_model.dart';
import '../../../../core/error/exception.dart';

abstract class MathTriviaLocalDataSource {
  ///THIS METHOD WILL CALL IF THE THERE INTERNET IS NOT AVAILABLE
  ///
  ///THROW [CACHEEXCEPTION] IF THE THERE IS NO DATA IN [SHAREDPREFERENCES]
  Future<MathTriviaModel> getLastMathTrivia();

  ///THIS METHOD SHOULD CALL TO CACHE MATHTRIVIAMODEL IN [SHAREDPREFERENCES]
  Future<void> cacheMathTrivia(MathTriviaModel trivia);
}

const String CACHED_MATH_TRIVIA = 'CACHED_MATH_TRIVIA';

class MathTriviaLocalDataSourceImpl implements MathTriviaLocalDataSource {
  final SharedPreferences _shared;

  MathTriviaLocalDataSourceImpl(this._shared);

  @override
  Future<void> cacheMathTrivia(MathTriviaModel trivia) {
    return _shared.setString(CACHED_MATH_TRIVIA, trivia.toJson());
  }

  @override
  Future<MathTriviaModel> getLastMathTrivia() async {
    final cachedString = _shared.getString(CACHED_MATH_TRIVIA);

    return cachedString != null
        ? MathTriviaModel.fromJson(cachedString)
        : throw CacheException();
  }
}
