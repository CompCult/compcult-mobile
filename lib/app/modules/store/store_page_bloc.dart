import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/app/modules/shared/models/item.dart';
import 'package:museu_vivo/app/modules/shared/models/user.dart';
import 'package:museu_vivo/app/modules/shared/repositories/item_repository.dart';
import 'package:museu_vivo/app/modules/shared/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class ItemsBloc extends BlocBase {
  final ItemRepository itemRepository;
  final UserRepository userRepository;

  ItemsBloc(this.itemRepository, this.userRepository);

  Observable<List<Item>> get itens => itemRepository.itens;

  Observable<List<Item>> get itensPurchased => itemRepository.itensPurchased;

  Observable<User> get user => userRepository.user;

  updateUser() => userRepository.updateUser();

   Future createItemOrder(itemId) async {
      return await itemRepository.createItemOrder(itemId);
   }
}
