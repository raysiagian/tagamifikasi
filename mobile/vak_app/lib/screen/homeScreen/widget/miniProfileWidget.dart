import 'package:flutter/material.dart';
import 'package:vak_app/style/localColor.dart';

class MiniProfileWidget extends StatelessWidget implements PreferredSizeWidget {
  const MiniProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          height: preferredSize.height,
          color: Colors.white, // Warna AppBar
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: LocalColor.transparent,
                child: ClipOval(
                  child: Image.asset("assets/images/component/maleicon.png"),
                ),
              ),
              const SizedBox(width: 20),
              const Text("Kevin"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
