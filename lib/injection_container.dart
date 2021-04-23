import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/util/input_converter.dart';
import 'features/date_trivia/data/datasources/date_trivia_local_data_source.dart';
import 'features/date_trivia/data/datasources/date_trivia_remote_data_source.dart';
import 'features/date_trivia/data/repositories/date_trivia_repository_impl.dart';
import 'features/date_trivia/domain/repositories/date_trivia_repository.dart';
import 'features/date_trivia/domain/usecases/get_concrete_date_trivia.dart';
import 'features/date_trivia/domain/usecases/get_random_date_trivia.dart';
import 'features/date_trivia/presentation/bloc/date_trivia_bloc.dart';
import 'features/math_trivia/data/datasources/math_trivia_local_data_source.dart';
import 'features/math_trivia/data/datasources/math_trivia_remote_data_source.dart';
import 'features/math_trivia/data/repositories/math_trivia_repository_impl.dart';
import 'features/math_trivia/domain/repositories/math_trivia_repository.dart';
import 'features/math_trivia/domain/usecases/get_concrete_math_trivia.dart';
import 'features/math_trivia/domain/usecases/get_random_math_trivia.dart';
import 'features/math_trivia/presentation/bloc/math_trivia_bloc.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:http/http.dart' as http;
import 'core/network/network_info.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/year_trivia/data/datasources/year_trivia_local_data_source.dart';
import 'features/year_trivia/data/datasources/year_trivia_remote_data_source.dart';
import 'features/year_trivia/data/repositories/year_trivia_repository_impl.dart';
import 'features/year_trivia/domain/repositories/year_trivia_repository.dart';
import 'features/year_trivia/domain/usecases/get_concrete_year_trivia.dart';
import 'features/year_trivia/domain/usecases/get_random_year_trivia.dart';
import 'features/year_trivia/presentation/bloc/year_trivia_bloc.dart';

final trivia = GetIt.instance;

Future<void> init() async {
  // BLoC [NumberTrivia]
  trivia.registerFactory(
    () => NumberTriviaBloc(
      concrete: trivia(),
      input: trivia(),
      random: trivia(),
    ),
  );

  // BLoC [YearTrivia]
  trivia.registerFactory(
    () => YearTriviaBloc(
      concrete: trivia(),
      input: trivia(),
      random: trivia(),
    ),
  );

  // BLoC [MathTrivia]
  trivia.registerFactory(
    () => MathTriviaBloc(
      concrete: trivia(),
      input: trivia(),
      random: trivia(),
    ),
  );

  // BLoC [DateTrivia]
  trivia.registerFactory(
    () => DateTriviaBloc(
      concrete: trivia(),
      input: trivia(),
      random: trivia(),
    ),
  );

  //Use Case [YearTrivia]
  trivia.registerLazySingleton(() => GetConcreteYearTrivia(trivia()));
  trivia.registerLazySingleton(() => GetRandomYearTrivia(trivia()));

  //Use Case [NumberTrivia]
  trivia.registerLazySingleton(() => GetConcreteNumberTrivia(trivia()));
  trivia.registerLazySingleton(() => GetRandomNumberTrivia(trivia()));

  //Use Case [MathTrivia]
  trivia.registerLazySingleton(() => GetConcreteMathTrivia(trivia()));
  trivia.registerLazySingleton(() => GetRandomMathTrivia(trivia()));

  //Use Case [DateTrivia]
  trivia.registerLazySingleton(() => GetConcreteDateTrivia(trivia()));
  trivia.registerLazySingleton(() => GetRandomDateTrivia(trivia()));

  //Repository [YearTrivia]
  trivia.registerLazySingleton<YearTriviaRepository>(() =>
      YearTriviaRepositoryImpl(
          local: trivia(), network: trivia(), remote: trivia()));

  //Repository [NumberTrivia]
  trivia.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          local: trivia(), network: trivia(), remote: trivia()));

  //Repository [MathTrivia]
  trivia.registerLazySingleton<MathTriviaRepository>(() =>
      MathTriviaRepositoryImpl(
          local: trivia(), network: trivia(), remote: trivia()));

  //Repository [DateTrivia]
  trivia.registerLazySingleton<DateTriviaRepository>(() =>
      DateTriviaRepositoryImpl(
          local: trivia(), network: trivia(), remote: trivia()));

  //DataSource [YearTrivia]
  trivia.registerLazySingleton<YearTriviaLocalDataSource>(
      () => YearTriviaLocalDataSourceImpl(trivia()));
  trivia.registerLazySingleton<YearTriviaRemoteDataSource>(
      () => YearTriviaRemoteDataSourceImpl(trivia()));

  //DataSource [NumberTrivia]
  trivia.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(trivia()));
  trivia.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(trivia()));

  //DataSource [MathTrivia]
  trivia.registerLazySingleton<MathTriviaLocalDataSource>(
      () => MathTriviaLocalDataSourceImpl(trivia()));
  trivia.registerLazySingleton<MathTriviaRemoteDataSource>(
      () => MathTriviaRemoteDataSourceImpl(trivia()));

  //DataSource [DateTrivia]
  trivia.registerLazySingleton<DateTriviaLocalDataSource>(
      () => DateTriviaLocalDataSourceImpl(trivia()));
  trivia.registerLazySingleton<DateTriviaRemoteDataSource>(
      () => DateTriviaRemoteDataSourceImpl(trivia()));

  //! Core
  trivia.registerLazySingleton<InputConverter>(() => InputConverterImpl());
  trivia.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(trivia()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  trivia.registerLazySingleton(() => sharedPreferences);
  trivia.registerLazySingleton(() => http.Client());
  trivia.registerLazySingleton(() => DataConnectionChecker());
}
