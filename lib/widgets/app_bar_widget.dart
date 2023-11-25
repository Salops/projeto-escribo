import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_escribo/theme/app_colors.dart';
import 'package:projeto_escribo/widgets/horizontal_spacing.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lighther,
      flexibleSpace: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                spreadRadius: -10,
                blurRadius: 20,
                offset: const Offset(0, 20),
              ),
            ],
          ),
        )
      ]),
      title: Row(
        children: [
          SvgPicture.asset(
            'assets/images/book.svg',
            height: 32,
            width: 32,
          ),
          const HorizontalSpacing(spacing: 8),
          const Text(
            'Leitor de E-books',
            style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
