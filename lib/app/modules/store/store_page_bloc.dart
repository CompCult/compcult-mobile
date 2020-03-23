import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:museu_vivo/app/modules/shared/models/item.dart';
import 'package:museu_vivo/app/modules/shared/repositories/item_repository.dart';
import 'package:rxdart/rxdart.dart';

class ItensBloc extends BlocBase {
  final ItemRepository itemRepository;

  ItensBloc(this.itemRepository);

  Observable<List<Item>> get itens => itemRepository.itens;
}
