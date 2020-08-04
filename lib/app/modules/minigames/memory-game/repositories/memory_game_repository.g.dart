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
    _$memoryGamesAtom.reportRead();
    return super.memoryGames;
  }

  @override
  set memoryGames(ObservableList<MemoryGame> value) {
    _$memoryGamesAtom.reportWrite(value, super.memoryGames, () {
      super.memoryGames = value;
    });
  }

  final _$getAllAsyncAction = AsyncAction('_MemoryGameRepositoryBase.getAll');

  @override
  Future<dynamic> getAll() {
    return _$getAllAsyncAction.run(() => super.getAll());
  }

  final _$fetchSecretMemoryGameAsyncAction =
      AsyncAction('_MemoryGameRepositoryBase.fetchSecretMemoryGame');

  @override
  Future<dynamic> fetchSecretMemoryGame(String memoryGameId) {
    return _$fetchSecretMemoryGameAsyncAction
        .run(() => super.fetchSecretMemoryGame(memoryGameId));
  }

  final _$createMemoryGameAnswerAsyncAction =
      AsyncAction('_MemoryGameRepositoryBase.createMemoryGameAnswer');

  @override
  Future<dynamic> createMemoryGameAnswer(String memoryGameId) {
    return _$createMemoryGameAnswerAsyncAction
        .run(() => super.createMemoryGameAnswer(memoryGameId));
  }

  @override
  String toString() {
    return '''
memoryGames: ${memoryGames}
    ''';
  }
}
