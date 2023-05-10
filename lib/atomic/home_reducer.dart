import 'package:get/get.dart';
import 'home_state.dart';

class HomeReducer {
  final HomeState state;

  HomeReducer(this.state) {
    ever(state.setCountCorrectAnswers, (callback) {
      _setCountCorrectAnswers();
    });

    ever(state.setNumbers, (callback) {
      _setNumbers(callback["number1"]!, callback["number2"]!);
    });

    ever(state.sumIsCorrect, (response) {
      _checkSumIsCorrect(response);
    });
  }

  void _setCountCorrectAnswers() {
    state.countCorrectAnswers.value++;
  }

  void _setNumbers(int number1, int number2) {
    state.number1.value = number1;
    state.number2.value = number2;
  }

  void _checkSumIsCorrect(int response) {
    bool isCorrect = state.number1.value + state.number2.value == response;

    // modificação de um estado por um usecase
    if (isCorrect) {
      _setCountCorrectAnswers();
    }

    state.returnSumIsCorrect.trigger(isCorrect);
  }
}
