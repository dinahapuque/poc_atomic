import 'package:get/get.dart';

class HomeState {
  final countCorrectAnswers = Rx<int>(0);
  final number1 = Rx<int>(0);
  final number2 = Rx<int>(0);

  // ACTIONS
  final setCountCorrectAnswers = Rx<void>(null);
  final setNumbers = Rx<Map<String, int>>({});

  final sumIsCorrect = Rx<int>(0);
  final returnSumIsCorrect = Rx<bool>(false);
}
