// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ListController on ListControllerBase, Store {
  late final _$listItensAtom =
      Atom(name: 'ListControllerBase.listItens', context: context);

  @override
  ObservableList<ItemWidget> get listItens {
    _$listItensAtom.reportRead();
    return super.listItens;
  }

  @override
  set listItens(ObservableList<ItemWidget> value) {
    _$listItensAtom.reportWrite(value, super.listItens, () {
      super.listItens = value;
    });
  }

  late final _$indexEditAtom =
      Atom(name: 'ListControllerBase.indexEdit', context: context);

  @override
  int get indexEdit {
    _$indexEditAtom.reportRead();
    return super.indexEdit;
  }

  @override
  set indexEdit(int value) {
    _$indexEditAtom.reportWrite(value, super.indexEdit, () {
      super.indexEdit = value;
    });
  }

  late final _$addItemAsyncAction =
      AsyncAction('ListControllerBase.addItem', context: context);

  @override
  Future addItem(ItemWidget item) {
    return _$addItemAsyncAction.run(() => super.addItem(item));
  }

  late final _$editItemAsyncAction =
      AsyncAction('ListControllerBase.editItem', context: context);

  @override
  Future editItem(String item) {
    return _$editItemAsyncAction.run(() => super.editItem(item));
  }

  late final _$removeItemAsyncAction =
      AsyncAction('ListControllerBase.removeItem', context: context);

  @override
  Future removeItem(int index) {
    return _$removeItemAsyncAction.run(() => super.removeItem(index));
  }

  late final _$ListControllerBaseActionController =
      ActionController(name: 'ListControllerBase', context: context);

  @override
  dynamic checkEditItem(ItemModel item, int index) {
    final _$actionInfo = _$ListControllerBaseActionController.startAction(
        name: 'ListControllerBase.checkEditItem');
    try {
      return super.checkEditItem(item, index);
    } finally {
      _$ListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listItens: ${listItens},
indexEdit: ${indexEdit}
    ''';
  }
}
