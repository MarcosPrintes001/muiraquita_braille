// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muiraquita_braille/pages/splash.dart';
import 'package:muiraquita_braille/pages/register.dart';

//Tela de login de usuário
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final _emaiController = TextEditingController();
  final _senhaController = TextEditingController();
  bool verSenha = false;

  @override
  Widget build(BuildContext context) {
    Color alertColor = Colors.red;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //LOGO
                  const Icon(Icons.supervised_user_circle, size: 200),

                  //EMAIL TEXT FIELD
                  TextFormField(
                    controller: _emaiController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: alertColor),
                      label: const Text('e-mail'),
                      hintText: 'eduardo@email.com',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'Digite seu email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //SENHA TEXT FIELD
                  TextFormField(
                    controller: _senhaController,
                    obscureText: !verSenha,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: alertColor),
                      suffixIcon: IconButton(
                        icon: Icon(verSenha
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            verSenha = !verSenha;
                          });
                        },
                      ),
                      label: const Text('senha'),
                      hintText: 'Digite sua senha',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (senha) {
                      if (senha == null || senha.isEmpty) {
                        return 'Digite uma senha';
                      } else if (senha.length < 6) {
                        return 'senha inválida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  //BOTÂO LOGAR
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(40, 40),
                    ),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.setBool('logado', true);
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const SplashPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: const Text("SIGIN"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //REGISTRAR AGORA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Não tem conta?",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), //GoogleFonts
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const RegistrationPage();
                          }));
                        },
                        child: Text(
                          " Registrar Agora",
                          style: GoogleFonts.roboto(
                              color: Colors.lightBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
