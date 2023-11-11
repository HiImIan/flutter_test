import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prova_flutter/db/item_model.dart';
import 'package:prova_flutter/home/home_page.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key, required this.item, this.index})
      : super(key: key);

// parâmetros da classe
// ----
  final ItemModel item;
  final int? index;
// ----

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
            title: Text(item.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 18)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // iconButton de edição, quando pressionado mostrará uma
                // cor diferente e o campo de texto substituirá o item referente
                // ----
                IconButton(
                  onPressed: () {
                    listController.checkEditItem(item, index!);
                    if (item.isEdit) {
                      textController.text = item.text;
                    } else {
                      textController.clear();
                    }
                  },
                  color: item.isEdit ? Colors.white : Colors.black,
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(item.isEdit
                          ? const Color.fromARGB(255, 46, 146, 138)
                          : Colors.white)),
                  icon: Image.asset(
                    'assets/edit.png',
                    filterQuality: FilterQuality.high,
                  ),
                ),
                // ----
                // IconButton que deletará o item referente
                // ----
                IconButton(
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        // confirmação para deletar o item selecionado
                        // ----
                        AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text(
                        "ATENÇÃO",
                        textAlign: TextAlign.center,
                      ),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              'O item selecionado será excluído!',
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            'Voltar',
                            style: TextStyle(
                                color: Color.fromARGB(255, 46, 146, 138),
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          child: const Text(
                            'Deletar!',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            listController.removeItem(index!);
                          },
                        ),
                      ],
                    ),
                    // ----
                  ),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white)),
                  icon: Image.asset(
                    'assets/delete.png',
                    filterQuality: FilterQuality.high,
                  ),
                ),
                // ----
              ],
            ),
          ),
        );
      },
    );
  }
}
