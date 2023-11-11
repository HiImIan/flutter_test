import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prova_flutter/db/item_model.dart';
import 'package:prova_flutter/db/list_controller.dart';
import 'package:prova_flutter/home/item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.prefs});
  final SharedPreferences prefs;
  @override
  State<HomePage> createState() => _HomePageState();
}

// controller do campo de texto e variável para
//  manter ativo o foco no campo de texto
// ----
final TextEditingController textController = TextEditingController();
FocusNode focus = FocusNode();
// ----

// variável ligada ao MOBX para melhor gerenciamento de estado
late ListController listController;

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    listController = ListController();

    // atribuição de valores armazenados por shared_ preferences
    // na variável MOBX
    // ----
    for (var item in widget.prefs.getStringList('items')?.toList() ?? []) {
      listController.addItem(ItemWidget(item: ItemModel(text: item)));
    }
    // ----
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //definição das cores de fundo
          // ----
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 32, 77, 95),
                Color.fromARGB(255, 46, 146, 138),
              ],
            ),
          ),
          // ----
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.elliptical(10, 30)),
                    ),
                    // widget central que exibe os
                    // textos após pressionar 'enter'
                    // ----
                    child: Observer(
                      builder: (context) => ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: listController.listItens.length,
                        itemBuilder: (_, index) {
                          ItemWidget actualItem =
                              listController.listItens[index];
                          return Column(
                            children: [
                              ItemWidget(
                                item: actualItem.item,
                                index: index,
                              ),
                              Divider(
                                color: Colors.grey[300],
                                height: 5,
                                indent: 10,
                                endIndent: 10,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    // ----
                  ),
                ),
                // campo de texto que esta sempre com foco
                // não importa aonde seja pressionado
                // ----
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 40),
                  child: TextField(
                    controller: textController,
                    focusNode: focus,
                    autofocus: true,
                    canRequestFocus: true,
                    onTapOutside: (event) => setState(() {
                      FocusScope.of(context).requestFocus(focus);
                    }),
                    // quando enviado, substituirá o botão de editar pressionado
                    // ou criará um novo item para a lista do widget principal
                    // ----
                    onSubmitted: (value) {
                      if (listController.listItens
                          .any((element) => element.item.isEdit)) {
                        listController.editItem(value);
                      } else if (value.isNotEmpty) {
                        listController
                            .addItem(ItemWidget(item: ItemModel(text: value)));
                      }
                      textController.clear();
                      FocusScope.of(context).requestFocus(focus);
                    },
                    // ----
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Digite seu texto",
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      counterText: "",
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                ),
                // ----
                // texto interativo que leva ao site google
                // ----
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                      bottom: 30),
                  child: GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("https://www.google.com/"));
                    },
                    child: Text(
                      "Política de privacidade",
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ),
                // ----
              ],
            ),
          ),
        ),
      ),
    );
  }
}
