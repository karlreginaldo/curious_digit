import 'package:meta/meta.dart';
import '../../../../core/error/exception.dart';
import '../models/date_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class DateTriviaRemoteDataSource {
  Future<DateTriviaModel> getConcreteDateTrivia(
      {@required int month, @required int day});
  Future<DateTriviaModel> getRandomDateTrivia();
}

class DateTriviaRemoteDataSourceImpl implements DateTriviaRemoteDataSource {
  final http.Client _client;

  DateTriviaRemoteDataSourceImpl(this._client);
  @override
  Future<DateTriviaModel> getConcreteDateTrivia({int month, int day}) async =>
      getTriviaModel('http://numbersapi.com/$month/$day/date');

  @override
  Future<DateTriviaModel> getRandomDateTrivia() async =>
      getTriviaModel('http://numbersapi.com/random/date');

  Future<DateTriviaModel> getTriviaModel(String url) async {
    final response =
        await _client.get(url, headers: {'Content-Type': 'application/json'});

    return response.statusCode == 200
        ? DateTriviaModel.fromJson(response.body)
        : throw ServerException();
  }
}
