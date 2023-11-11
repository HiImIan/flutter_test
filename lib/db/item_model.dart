import 'package:mobx/mobx.dart';
part 'item_model.g.dart';

// classe MOBX que contém variáveis observavéis

class ItemModel = ItemModelBase with _$ItemModel;

abstract class ItemModelBase with Store {
  ItemModelBase({required this.text});

  // variáveis observadas que serão alteradas indiretamente
  // ----
  @observable
  String text = "";

  @observable
  bool isEdit = false;
  // ----
}
