import '../models/math_trivia_model.dart';

import '../../../../core/error/exception.dart';
import 'package:http/http.dart' as http;

abstract class MathTriviaRemoteDataSource {
  ///USE THIS API: http://numbersapi.com/1
  ///
  ///THROW [SERVEREXCEPTION] IF THE SERVER CRASH
  Future<MathTriviaModel> getConcreteMathTrivia(int number);

  ///USE THIS API: http://numbersapi.com/random
  ///
  ///THROW [SERVEREXCEPTION] IF THE SERVER CRASH
  Future<MathTriviaModel> getRandomMathTrivia();
}

class MathTriviaRemoteDataSourceImpl implements MathTriviaRemoteDataSource {
  final http.Client _client;

  MathTriviaRemoteDataSourceImpl(this._client);

  @override
  Future<MathTriviaModel> getConcreteMathTrivia(int number) async =>
      getTriviaModel('http://numbersapi.com/$number/math');

  @override
  Future<MathTriviaModel> getRandomMathTrivia() async =>
      getTriviaModel('http://numbersapi.com/random/math');

  Future<MathTriviaModel> getTriviaModel(String url) async {
    final response = await _client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 200
        ? MathTriviaModel.fromJson(response.body)
        : throw ServerException();
  }
}
