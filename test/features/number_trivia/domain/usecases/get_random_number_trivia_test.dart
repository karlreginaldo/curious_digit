import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/usecase/usecase.dart';
import 'package:tddtry4/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddtry4/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tddtry4/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  MockNumberTriviaRepository mockNumberTriviaRepository;
  GetRandomNumberTrivia usecase;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });
  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: tNumber, text: 'Test');
  test('should return Right(NumberTrivia) when repository was called',
      () async {
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((realInvocation) async => Right(tNumberTrivia));

    final actual = await usecase(NoParams());

    expect(actual, Right(tNumberTrivia));
  });
}
