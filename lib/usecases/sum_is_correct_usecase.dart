import 'package:poc_atomic/atomic/home_state.dart';

// esse usecase só virou um usecase, em vez de um redutor, porque precisa retornar um valor.
// esse valor retornado não é relevante para o estado da aplicação. um dos motivos de eu não salvá-lo no state.
class SumIsCorrectUsecase {
  final HomeState state;

  SumIsCorrectUsecase(this.state);

  bool call(int response) {
    bool isCorrect = state.number1.value + state.number2.value == response;

    // modificação de um estado por um usecase
    if (isCorrect) {
      state.setCountCorrectAnswers.trigger(null);
    }

    return isCorrect;
  }
}
