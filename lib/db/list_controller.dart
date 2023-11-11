import 'package:mobx/mobx.dart';
import 'package:prova_flutter/db/item_model.dart';
import 'package:prova_flutter/home/item_widget.dart';
import 'package:prova_flutter/main.dart';
part 'list_controller.g.dart';

// classe MOBX de uma lista com variáveis observáveis

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {
  @observable
  ObservableList<ItemWidget> listItens = ObservableList<ItemWidget>();

// index observável para desmarcar
//um botão de edição quando outro for pressionado
// ----
  @observable
  int indexEdit = -1;
// ----

  // ação de adicionar item na lista e armazenar dentro do shared_preferences
  // ----
  @action
  addItem(ItemWidget item) async {
    listItens.add(item);
    prefs.setStringList(
        'items', listItens.map((element) => element.item.text).toList());
  }
  // ----

  // ação para checar se outro item da lista já esta sendo editado
  // ----
  @action
  checkEditItem(ItemModel item, int index) {
    if (indexEdit >= 0 && indexEdit != index) {
      listItens[indexEdit].item.isEdit = false;
    }
    indexEdit = index;
    item.isEdit = !item.isEdit;
  }
  // ----

  // ação de editar o item selecionado na lista observada e no shared_preferences
  // ----
  @action
  editItem(String item) async {
    listItens[indexEdit].item.text = item;
    listItens[indexEdit].item.isEdit = false;
    await prefs.setStringList(
        'items',
        listItens.map((element) {
          return element.item.text;
        }).toList());
  }
  // ----

  // ação de remover um item da lista observada e no shared_preferences
  // ----
  @action
  removeItem(int index) async {
    listItens.removeAt(index);
    if (indexEdit > 0) {
      indexEdit--;
    }
    await prefs.remove('items');
  }
  // ----
}
