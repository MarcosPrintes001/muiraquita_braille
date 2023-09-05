//Tela onde vai ficar direcionador dicionario ou tradutor
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:muiraquita_braille/pages/aprendice.dart';
import 'package:muiraquita_braille/pages/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muiraquita_braille/pages/login.dart';

//Tela Para escolher Dicionario OU Tradutor
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //Deslogar do sistema
    Future logout() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }

    callCamera() {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Camera(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }

    callAprendice() {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) =>
              const Aprendizado(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,

        //Welcome text
        title: const Text("Bem Vindo(a)"),
        backgroundColor: Colors.blue,
      ),

      //Side Bar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Icon(Icons.home),
            ),
            TextButton.icon(
              onPressed: logout,
              icon: const Icon(
                Icons.logout,
              ),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),

      //App Body
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Ink(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),

              //Botão central chamar dicionario
              child: InkWell(
                onTap: callAprendice,
                child: const Icon(
                  Icons.menu_book_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //Botão Central Tradutor
            Ink(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.rectangle,
              ),

              //Botão central chamar dicionario
              child: InkWell(
                onTap: callCamera,
                child: const Icon(
                  Icons.translate_sharp,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
