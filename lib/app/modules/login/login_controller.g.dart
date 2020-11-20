// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$loadingAtom = Atom(name: '_LoginControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$showErrorMessageAtom =
      Atom(name: '_LoginControllerBase.showErrorMessage');

  @override
  bool get showErrorMessage {
    _$showErrorMessageAtom.reportRead();
    return super.showErrorMessage;
  }

  @override
  set showErrorMessage(bool value) {
    _$showErrorMessageAtom.reportWrite(value, super.showErrorMessage, () {
      super.showErrorMessage = value;
    });
  }

  final _$visibilityInputTextAtom =
      Atom(name: '_LoginControllerBase.visibilityInputText');

  @override
  bool get visibilityInputText {
    _$visibilityInputTextAtom.reportRead();
    return super.visibilityInputText;
  }

  @override
  set visibilityInputText(bool value) {
    _$visibilityInputTextAtom.reportWrite(value, super.visibilityInputText, () {
      super.visibilityInputText = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_LoginControllerBase.login');

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  void setVisibilityInputText(bool newValue) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.setVisibilityInputText');
    try {
      return super.setVisibilityInputText(newValue);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
showErrorMessage: ${showErrorMessage},
visibilityInputText: ${visibilityInputText}
    ''';
  }
}
