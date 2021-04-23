import '../../../../core/error/exception.dart';
import '../models/year_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class YearTriviaRemoteDataSource {
  Future<YearTriviaModel> getConcreteYearTrivia(int year);
  Future<YearTriviaModel> getRandomYearTrivia();
}

class YearTriviaRemoteDataSourceImpl implements YearTriviaRemoteDataSource {
  final http.Client _client;

  YearTriviaRemoteDataSourceImpl(this._client);

  @override
  Future<YearTriviaModel> getConcreteYearTrivia(int year) =>
      _getTriviaModel('http://numbersapi.com/$year/year');

  @override
  Future<YearTriviaModel> getRandomYearTrivia() =>
      _getTriviaModel('http://numbersapi.com/random/year');

  Future<YearTriviaModel> _getTriviaModel(String url) async {
    final response = await _client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200
        ? YearTriviaModel.fromJson(response.body)
        : throw ServerException();
  }
}
