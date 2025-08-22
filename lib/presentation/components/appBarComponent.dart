import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int dinheiroPerfil =
      1000; //trocar para os dados do perfil DINHEIRO/MONEY
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.account_balance_wallet_outlined,
          color: Color(0xFFFFC107),
        ),
        onPressed: () {
          // Ação ao pressionar o ícone
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Ícone pressionado!')));
        },
      ),
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
