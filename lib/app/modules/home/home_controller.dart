import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:museu_vivo/app/shared/auth/auth_controller.dart';
import 'package:museu_vivo/app/shared/repositories/local_storage_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  // Recuperando a injeção de dependências pelo contrato
  // As operações de salvar offline é feita usando o _storage
  final ILocalStorage _storage = Modular.get();

  @observable
  int currentTabIndex = 0;

  _HomeControllerBase() {
    init();
  }

  @action
  init() {
    // TODO: Alterar a lógica para iniciar o usuário
  }
}
