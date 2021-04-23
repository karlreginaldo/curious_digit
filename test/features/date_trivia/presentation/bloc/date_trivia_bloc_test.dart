import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/util/input_converter.dart';
import 'package:tddtry4/features/date_trivia/domain/usecases/get_concrete_date_trivia.dart';
import 'package:tddtry4/features/date_trivia/domain/usecases/get_random_date_trivia.dart';
import 'package:tddtry4/features/date_trivia/presentation/bloc/date_trivia_bloc.dart';

class MockGetConcreteDateTrivia extends Mock implements GetConcreteDateTrivia {}

class MockGetRandomDateTrivia extends Mock implements GetRandomDateTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MockGetConcreteDateTrivia mockConcrete;
  MockGetRandomDateTrivia mockRandom;
  MockInputConverter mockInput;
  DateTriviaBloc bloc;
  setUp(() {
    mockConcrete = MockGetConcreteDateTrivia();
    mockRandom = MockGetRandomDateTrivia();
    mockInput = MockInputConverter();
    bloc = DateTriviaBloc(
        concrete: mockConcrete, random: mockRandom, input: mockInput);
  });

  test('Check if the initialstate is Empty', () async {
    expect(bloc.initialState, Empty());
  });
}
