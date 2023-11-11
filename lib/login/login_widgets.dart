import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// filtro de caracteres especiais
final validCharacters = RegExp(r'^[a-zA-Z0-9 ]');

// função com as prédefinições dos textFormFields de LOGIN
// com parâmetros para diferenciar usuário e senha.
Widget textFormField(TextEditingController controller, bool isPassword) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 5),
        child: Text(
          isPassword ? "Senha" : "Usuário",
          style: TextStyle(
            color: Colors.grey[300],
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
      TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        obscureText: isPassword,
        maxLength: 20,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          constraints: const BoxConstraints(maxWidth: 300, minWidth: 200),
          prefixIcon: Icon(
            isPassword ? CupertinoIcons.lock_fill : Icons.person,
            size: 16,
            color: Colors.black,
          ),
          errorStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.red[400]),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          fillColor: Colors.grey.shade100,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return isPassword
                ? "Informe sua senha"
                : "Informe seu nome de usuário";
          }
          if (isPassword && value.length < 2) {
            return "Senha com mínimo de 2 caracteres";
          }
          if (isPassword && !validCharacters.hasMatch(value)) {
            return "Senha com caracteres especiais";
          }
          if (value.endsWith(" ")) {
            return "Campo terminando com espaçamento";
          }
          return null;
        },
      ),
    ],
  );
}
