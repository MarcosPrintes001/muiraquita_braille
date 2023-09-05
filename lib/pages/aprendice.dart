import 'package:flutter/material.dart';

class Aprendizado extends StatefulWidget {
  const Aprendizado({super.key});

  @override
  State<Aprendizado> createState() => _AprendizadoState();
}

class _AprendizadoState extends State<Aprendizado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data"), actions: []),
      body: Center(
        child: Text("PAGINA Aprendizado"),
      ),
    );
  }
}
