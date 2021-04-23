import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/constant/strings.dart';
import 'package:tddtry4/core/error/failure.dart';
import 'package:tddtry4/core/util/input_converter.dart';
import 'package:tddtry4/features/year_trivia/domain/entities/year_trivia.dart';
import 'package:tddtry4/features/year_trivia/domain/usecases/get_concrete_year_trivia.dart';
import 'package:tddtry4/features/year_trivia/domain/usecases/get_random_year_trivia.dart';
import 'package:tddtry4/features/year_trivia/presentation/bloc/year_trivia_bloc.dart';

class MockGetConcreteYearTrivia extends Mock implements GetConcreteYearTrivia {}

class MockGetRandomYearTrivia extends Mock implements GetRandomYearTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MockGetConcreteYearTrivia mockConcrete;
  MockGetRandomYearTrivia mockRandom;
  MockInputConverter mockConverter;
  YearTriviaBloc bloc;

  setUp(() {
    mockConcrete = MockGetConcreteYearTrivia();
    mockRandom = MockGetRandomYearTrivia();
    mockConverter = MockInputConverter();
    bloc = YearTriviaBloc(
        concrete: mockConcrete, input: mockConverter, random: mockRandom);
  });

  group('GetTriviaForConcreteYear', () {
    final tStrYear = '1';
    final tParsedYear = 1;
    final tYearTrivia = YearTrivia(text: 'Test', year: 1);

    test('Check if the 1st State is Empty()', () async {
      expect(bloc.state, Empty());
    });

    test('should call the converter.stringToInteger', () async {
      bloc.add(GetTriviaForConcreteYear(tStrYear));

      await untilCalled(mockConverter.stringToInteger(any));

      verify(mockConverter.stringToInteger(tStrYear));
    });

    test(
        'should emit [Empty(),Loading()] when converted.stringToInteger returns integet',
        () async {
      when(mockConverter.stringToInteger(any)).thenReturn(Right(tParsedYear));

      final matchers = [Empty(), Loading()];

      expectLater(bloc.cast(), emitsInOrder(matchers));
      bloc.add(GetTriviaForConcreteYear(tStrYear));
    });

    test(
        'should emit [Empty(),Error()] when converted.stringToInteger returns Failure',
        () async {
      when(mockConverter.stringToInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      final matchers = [Empty(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)];

      expectLater(bloc.cast(), emitsInOrder(matchers));

      bloc.add(GetTriviaForConcreteYear(tStrYear));
    });

    test('Should call concrete', () async {
      when(mockConverter.stringToInteger(any)).thenReturn(Right(tParsedYear));

      bloc.add(GetTriviaForConcreteYear(tStrYear));

      await untilCalled(mockConcrete(any));

      verify(mockConcrete(YearTriviaParams(tParsedYear)));
    });

    test(
        'should emit [Empty(),Loading(),Loaded()] when concrete returns YearTrivia and stringToInteger returns integer]',
        () async {
      when(mockConverter.stringToInteger(any)).thenReturn(Right(tParsedYear));
      when(mockConcrete(any))
          .thenAnswer((realInvocation) async => Right(tYearTrivia));

      final matcher = [Empty(), Loading(), Loaded(trivia: tYearTrivia)];

      expectLater(bloc.cast(), emitsInOrder(matcher));

      bloc.add(GetTriviaForConcreteYear(tStrYear));
    });

    test(
        'should emit [Empty(),Loading(),Error()] when concrete returns Failure and stringToInteger returns integer]',
        () async {
      when(mockConverter.stringToInteger(any)).thenReturn(Right(tParsedYear));
      when(mockConcrete(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      final matcher = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];

      expectLater(bloc.cast(), emitsInOrder(matcher));

      bloc.add(GetTriviaForConcreteYear(tStrYear));
    });
  });
}
