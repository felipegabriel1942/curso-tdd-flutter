import 'package:curso_tdd_flutter/features/number_trivia/data/models/number_trivia.dart';
import 'package:curso_tdd_flutter/features/number_trivia/data/repositories/number_trivia_repository.dart';
import 'package:curso_tdd_flutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(
    number: tNumber,
    text: 'test',
  );

  test('Should get trivia for the number from repository', () async {
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));

    final result = await usecase(Params(number: tNumber));

    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}

