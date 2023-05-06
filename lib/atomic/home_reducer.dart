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
  }

  void _setCountCorrectAnswers() {
    state.countCorrectAnswers.value++;
  }

  void _setNumbers(int number1, int number2) {
    state.number1.value = number1;
    state.number2.value = number2;
  }
}
