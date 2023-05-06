import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_atomic/atomic/home_reducer.dart';
import 'package:poc_atomic/atomic/home_state.dart';
import 'package:poc_atomic/usecases/get_random_number_usecase.dart';

import 'home_page.dart';
import 'usecases/sum_is_correct_usecase.dart';

void main() {
  // atomic
  Get.put(HomeState());
  Get.put(HomeReducer(Get.find()));

  // usecases
  Get.put(GetRandomNumberUsecase());
  Get.put(SumIsCorrectUsecase(Get.find()));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
        title: 'POC Atomic',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(title: 'POC Atomic'),
      ),
    );
  }
}
