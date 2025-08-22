import 'package:flutter/material.dart';
import 'package:stein_aplication/presentation/components/appBarComponent.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Center(child: Text("Bem-vindo ao Stein Aprendizado!")),
      ),
    );
  }
}
