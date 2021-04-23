import '../../../../core/error/exception.dart';
import '../models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  ///USE THIS API: http://numbersapi.com/1
  ///
  ///THROW [SERVEREXCEPTION] IF THE SERVER CRASH
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  ///USE THIS API: http://numbersapi.com/random
  ///
  ///THROW [SERVEREXCEPTION] IF THE SERVER CRASH
  Future<NumberTriviaModel> getRandomNumberTrivia();

  //THIS METHOD IS MY OPTIONS FOR CLEAN ARCHITECTURE PURPOSE
  Future<NumberTriviaModel> getTriviaModel(String url);
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client _client;

  NumberTriviaRemoteDataSourceImpl(this._client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async =>
      getTriviaModel('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async =>
      getTriviaModel('http://numbersapi.com/random');

  @override
  Future<NumberTriviaModel> getTriviaModel(String url) async {
    final response = await _client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 200
        ? NumberTriviaModel.fromJson(response.body)
        : throw ServerException();
  }
}
