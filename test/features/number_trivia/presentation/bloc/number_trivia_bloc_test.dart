import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/constant/strings.dart';
import 'package:tddtry4/core/error/failure.dart';
import 'package:tddtry4/core/usecase/usecase.dart';
import 'package:tddtry4/core/util/input_converter.dart';
import 'package:tddtry4/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tddtry4/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tddtry4/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tddtry4/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MockGetConcreteNumberTrivia mockGetConcrete;
  MockGetRandomNumberTrivia mockGetRandom;
  MockInputConverter mockInput;
  NumberTriviaBloc bloc;
  setUp(() {
    mockGetConcrete = MockGetConcreteNumberTrivia();
    mockGetRandom = MockGetRandomNumberTrivia();
    mockInput = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcrete,
      input: mockInput,
      random: mockGetRandom,
    );
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test');
    test('Check if the initial State is Empty', () async {
      expect(bloc.initialState, Empty());
    });

    test('Verify if the getRandoNumberTrivia was called', () async {
      when(mockGetRandom(any))
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));

      bloc.add(GetTriviaForRandomNumber());

      await untilCalled(mockGetRandom(any));

      verify(mockGetRandom(NoParams()));
    });

    test('Should Emit Loading Error when trivia return ServerFailure',
        () async {
      when(mockGetRandom(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      final matcher = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.asBroadcastStream(), emitsInOrder(matcher));

      bloc.add(GetTriviaForRandomNumber());
    });

    test('Should Emit Loading Error when trivia return CacheFailure', () async {
      when(mockGetRandom(any))
          .thenAnswer((realInvocation) async => Left(CacheFailure()));

      final matcher = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc.asBroadcastStream(), emitsInOrder(matcher));

      bloc.add(GetTriviaForRandomNumber());
    });

    test(
        'Should Emit Loading when Input is valid and Emit Loaded when trivia is present',
        () async {
      when(mockGetRandom(any))
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));

      final matcher = [Empty(), Loading(), Loaded(trivia: tNumberTrivia)];
      expectLater(bloc.asBroadcastStream(), emitsInOrder(matcher));

      bloc.add(GetTriviaForRandomNumber());
    });
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '123';
    final tNumberParsed = 123;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'Test');
    test('Check if the initial State is Empty', () async {
      expect(bloc.initialState, Empty());
    });

    test('Verify if the stringToInteger was called', () async {
      when(mockInput.stringToInteger(any)).thenReturn(Right(tNumberParsed));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));

      await untilCalled(mockInput.stringToInteger(any));

      verify(mockInput.stringToInteger(tNumberString));
    });

    test('Should Emit Error when stringToInteger return InvalidInputFailure',
        () async {
      when(mockInput.stringToInteger(any))
          .thenReturn(Left(InvalidInputFailure()));

      final matcher = [Empty(), Error(message: INVALID_INPUT_FAILURE_MESSAGE)];

      expectLater(bloc.asBroadcastStream(), emitsInOrder(matcher));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('Verify if the getConcreteNumberTrivia was called', () async {
      when(mockInput.stringToInteger(any)).thenReturn(Right(tNumberParsed));
      when(mockGetConcrete(any))
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));

      await untilCalled(mockInput.stringToInteger(any));
      await untilCalled(mockGetConcrete(any));

      verify(mockInput.stringToInteger(tNumberString));
      verify(mockGetConcrete(NumberTriviaParams(tNumberParsed)));
    });

    test(
        'Should Emit Loading when Input is valid and Emit Error when trivia return ServerFailure',
        () async {
      when(mockInput.stringToInteger(any)).thenReturn(Right(tNumberParsed));

      when(mockGetConcrete(any))
          .thenAnswer((realInvocation) async => Left(ServerFailure()));

      final matcher = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc.asBroadcastStream(), emitsInOrder(matcher));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test(
        'Should Emit Loading when Input is valid and Emit Error when trivia return CacheFailure',
        () async {
      when(mockInput.stringToInteger(any)).thenReturn(Right(tNumberParsed));

      when(mockGetConcrete(any))
          .thenAnswer((realInvocation) async => Left(CacheFailure()));

      final matcher = [
        Empty(),
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc.asBroadcastStream(), emitsInOrder(matcher));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test(
        'Should Emit Loading when Input is valid and Emit Loaded when trivia is present',
        () async {
      when(mockInput.stringToInteger(any)).thenReturn(Right(tNumberParsed));

      when(mockGetConcrete(any))
          .thenAnswer((realInvocation) async => Right(tNumberTrivia));

      final matcher = [Empty(), Loading(), Loaded(trivia: tNumberTrivia)];
      expectLater(bloc.asBroadcastStream(), emitsInOrder(matcher));

      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });
}
