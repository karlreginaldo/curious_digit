import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tddtry4/core/error/failure.dart';
import 'package:tddtry4/core/util/input_converter.dart';

void main() {
  InputConverterImpl input;
  setUp(() {
    input = InputConverterImpl();
  });

  final tNumberString = '123';
  final tNumberParsed = 123;
  final tMonthString = 'February';
  test('Should return Right(int) when user type integer', () async {
    final actual = input.stringToInteger(tNumberString);

    expect(actual, Right(tNumberParsed));
  });

  test('Should return InvalidInputFailure❌ when user type letter', () async {
    final actual = input.stringToInteger('abc');

    expect(actual, Left(InvalidInputFailure()));
  });

  test('Should return InvalidInputFailure❌ when user type negative integer',
      () async {
    final actual = input.stringToInteger('-123');

    expect(actual, Left(InvalidInputFailure()));
  });

  test('Should return integer when the user pick month', () async {
    final actual = input.stringMonthToInteger('February');

    expect(actual, 2);
  });
}
