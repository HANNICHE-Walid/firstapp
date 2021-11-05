import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Screens/login.dart';
import 'package:firstapp/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class register extends StatelessWidget {
  static const String idscreen = "register";
  TextEditingController nomTextEditingController = TextEditingController();
  TextEditingController prenomTextEditingController = TextEditingController();
  TextEditingController telephoneTextEditingController =
      TextEditingController();
  TextEditingController mailTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      color: Colors.grey,
      fontSize: 10.0,
    );
    var inputDecoration = const InputDecoration(
      labelText: "prenom",
      labelStyle: TextStyle(fontSize: 14.0),
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 10.0,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 70.0,
              ),
              // ignore: prefer_const_constructors
              Text(
                "se connecter comme client",
                style: const TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: nomTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "nom",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: prenomTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: inputDecoration,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: telephoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "telephone ",
                        labelStyle: const TextStyle(fontSize: 14.0),
                        hintStyle: textStyle,
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: mailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "votre mail",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passTextEditingController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "mot de passe",
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: const SizedBox(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "s'enregistrer",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0)),
                      onPressed: () {
                        if (nomTextEditingController.text.length < 4) {
                          Derror("le nom dois contenir au moins 4 caractere",
                              context);
                        } else if (prenomTextEditingController.text.length <
                            4) {
                          Derror("le prenom dois contenir au moins 4 caractere",
                              context);
                        } else if (mailTextEditingController.text
                            .contains("@")) {
                          Derror(
                              "le E-mail de etre de cette frome ' votremail@gmail.com' ",
                              context);
                        } else if (telephoneTextEditingController
                            .text.isEmpty) {
                          Derror("voyer rentrer un numémro de téléphone valide",
                              context);
                        } else if (prenomTextEditingController.text.length <
                            6) {
                          Derror(
                              "le mot de passe dois contenir au moins 6 caractere",
                              context);
                        }
                        registerNewuser(context);
                      },
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Login.idscreen, (route) => false);
                },
                child: const Text("vous avez déja un compte ? cliquer ici"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  registerNewuser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: mailTextEditingController.text,
                password: passTextEditingController.text)
            .catchError((errMsg) {
      Derror("erreur :" + errMsg.toString(), context);
    }))
        .user;

    // ignore: unnecessary_null_comparison
    if (User != null) {
      Map userDtaeMap = {
        "nom": nomTextEditingController.text.trim(),
        "prenom": prenomTextEditingController.text.trim(),
        "telephone": telephoneTextEditingController.text.trim(),
        "mail": mailTextEditingController.text.trim(),
        "mot de passe": passTextEditingController.text.trim(),
      };
      userRef.child(firebaseUser!.uid).set(userDtaeMap);
      Derror("utilisateur cree", context);
    } else {

      Future.error(userRef);
    }
  }
}

// ignore: non_constant_identifier_names
Derror(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
