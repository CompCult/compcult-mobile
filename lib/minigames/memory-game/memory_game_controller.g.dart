// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_game_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MemoryGameController on _MemoryGameControllerBase, Store {
  final _$timeAtom = Atom(name: '_MemoryGameControllerBase.time');

  @override
  int get time {
    _$timeAtom.context.enforceReadPolicy(_$timeAtom);
    _$timeAtom.reportObserved();
    return super.time;
  }

  @override
  set time(int value) {
    _$timeAtom.context.conditionallyRunInAction(() {
      super.time = value;
      _$timeAtom.reportChanged();
    }, _$timeAtom, name: '${_$timeAtom.name}_set');
  }

  final _$_MemoryGameControllerBaseActionController =
      ActionController(name: '_MemoryGameControllerBase');

  @override
  dynamic startTimer() {
    final _$actionInfo =
        _$_MemoryGameControllerBaseActionController.startAction();
    try {
      return super.startTimer();
    } finally {
      _$_MemoryGameControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic endTime() {
    final _$actionInfo =
        _$_MemoryGameControllerBaseActionController.startAction();
    try {
      return super.endTime();
    } finally {
      _$_MemoryGameControllerBaseActionController.endAction(_$actionInfo);
    }
  }
}
