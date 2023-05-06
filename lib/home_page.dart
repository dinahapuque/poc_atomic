import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_atomic/usecases/sum_is_correct_usecase.dart';

import 'atomic/home_state.dart';
import 'usecases/get_random_number_usecase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeState state = Get.find();

  // ESSA É A QUESTAO (ver abaixo)
  // seria esse o local correto de pegar a instancia dos usecases?
  // se eles ficassem aqui, apesar de tudo funcionar, nâo quebraria o principio que o reducer
  // e o state tentam resolver, de impedir a view de ter conhecimento das regras e ver apenas o estado?
  final GetRandomNumberUsecase getRandomNumberUsecase = Get.find();
  final SumIsCorrectUsecase sumIsCorrectUsecase = Get.find();

  final textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    resetNumbers();
  }

  void resetNumbers() {
    state.setNumbers.trigger({
      "number1": getRandomNumberUsecase(),
      "number2": getRandomNumberUsecase(),
    });

    textFieldController.clear();
  }

  void checkSum() async {
    // essa função é uma simples representação de como eu usaria o retorno do usecase.
    // esse retorno, na prática, é utilizado dentro de outros reducers/usecases, de tal forma que a execução
    // desses outros reducers/usecases só é possivel caso haja esse retorno.
    final isCorrect = sumIsCorrectUsecase(int.parse(textFieldController.text));

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(isCorrect ? "CONGRATULATIONS!" : "Sorry, you're wrong"),
        );
      },
    );

    resetNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  const Text('TOTAL CORRECT ANSWERS '),
                  Obx(
                    () => Text(
                      state.countCorrectAnswers.value.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Obx(() => Text("${state.number1.value} + ${state.number2.value} = ")),
                  SizedBox(
                    width: 100,
                    child: TextField(controller: textFieldController),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: checkSum,
                    child: const Text('CHECK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
