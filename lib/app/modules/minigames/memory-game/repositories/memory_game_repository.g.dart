// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_game_repository.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MemoryGameRepository on _MemoryGameRepositoryBase, Store {
  final _$memoryGamesAtom = Atom(name: '_MemoryGameRepositoryBase.memoryGames');

  @override
  ObservableList<MemoryGame> get memoryGames {
    _$memoryGamesAtom.context.enforceReadPolicy(_$memoryGamesAtom);
    _$memoryGamesAtom.reportObserved();
    return super.memoryGames;
  }

  @override
  set memoryGames(ObservableList<MemoryGame> value) {
    _$memoryGamesAtom.context.conditionallyRunInAction(() {
      super.memoryGames = value;
      _$memoryGamesAtom.reportChanged();
    }, _$memoryGamesAtom, name: '${_$memoryGamesAtom.name}_set');
  }

  final _$getAllAsyncAction = AsyncAction('getAll');

  @override
  Future getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }
}
