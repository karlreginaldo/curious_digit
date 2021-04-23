import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tddtry4/features/year_trivia/domain/repositories/year_trivia_repository.dart';
import 'package:tddtry4/features/year_trivia/domain/usecases/get_concrete_year_trivia.dart';

class MockYearTriviaRepository extends Mock implements YearTriviaRepository {}

void main() {
  MockYearTriviaRepository mockRepository;
  GetConcreteYearTrivia usecase;

  setUp(() {
    mockRepository = MockYearTriviaRepository();
    usecase = GetConcreteYearTrivia(mockRepository);
  });
  final tYear = 2001;
  final tYearTrivia = YearTrivia(text: 'Test', year: tYear);
  test('Should return YearTrivia when mockrepository returns successfully',
      () async {
    when(mockRepository.getConcreteYearTrivia(any))
        .thenAnswer((realInvocation) async => Right(tYearTrivia));

    final actual = await usecase(YearTriviaParams(tYear));

    expect(actual, Right(tYearTrivia));
  });
}
