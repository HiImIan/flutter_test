import 'package:flutter/material.dart';
import 'package:prova_flutter/home/home_page.dart';
import 'package:prova_flutter/login/login_widgets.dart';
import 'package:prova_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// Essa classe tem os comandos bases da tela de login

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// variável do formulário e os controllers dos campos de texto
final loginForm = GlobalKey<FormState>();
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //definição dos padrões de cores
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
          // campos de login e botão de entrar
          child: Form(
            key: loginForm,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  //funções com as definições detalhadas dos textFormFields
                  //-----
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: textFormField(usernameController, false),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: textFormField(passwordController, true),
                  ),
                  //-----
                  // botão de Entrar
                  // ----
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (loginForm.currentState!.validate()) {
                            prefs = await SharedPreferences.getInstance();
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => HomePage(prefs: prefs),
                              ),
                            );
                          }
                        },
                        style: const ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll(Size(200, 50)),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 68, 189, 110))),
                        child: const Text(
                          "Entrar",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  // ----
                  // texto interativo que leva ao site google
                  // ----
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.2,
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
      ),
    );
  }
}
