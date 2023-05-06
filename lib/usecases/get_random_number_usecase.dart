import 'dart:math';

// este usecase não faz alteração de estado.
// é apenas uma função comum que pode ou nao receber parâmetros.
class GetRandomNumberUsecase {
  int call() {
    return Random().nextInt(10);
  }
}
