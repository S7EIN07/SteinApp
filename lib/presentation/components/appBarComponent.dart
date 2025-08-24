import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int dinheiroPerfil =
      1000; //trocar para os dados do perfil DINHEIRO/MONEY
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Text("$dinheiroPerfil", style: TextStyle(color: Color(0xFFFFC107))),
          const SizedBox(width: 10),
        ],
      ),
      centerTitle: false,
      backgroundColor: Color(0xFF212529),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
