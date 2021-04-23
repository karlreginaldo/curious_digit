import 'package:dartz/dartz.dart';
import '../error/failure.dart';

abstract class InputConverter {
  Either<Failure, int> stringToInteger(String str);
  int stringMonthToInteger(String stringMonth);
}

class InputConverterImpl implements InputConverter {
  @override
  Either<Failure, int> stringToInteger(String str) {
    try {
      final integer = int.parse(str);
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }

  @override
  int stringMonthToInteger(String stringMonth) {
    switch (stringMonth) {
      case 'January':
        return 1;
        break;
      case 'February':
        return 2;
        break;
      case 'March':
        return 3;
        break;
      case 'April':
        return 4;
        break;
      case 'May':
        return 5;
        break;
      case 'June':
        return 6;
        break;
      case 'July':
        return 7;
        break;
      case 'August':
        return 8;
        break;
      case 'September':
        return 9;
        break;
      case 'October':
        return 10;
        break;
      case 'November':
        return 11;
        break;
      case 'December':
        return 12;
        break;
      default:
        return 0;
        break;
    }
  }
}
