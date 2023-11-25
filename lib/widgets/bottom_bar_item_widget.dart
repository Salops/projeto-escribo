import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:projeto_escribo/theme/app_colors.dart';
import 'package:projeto_escribo/widgets/horizontal_spacing.dart';

class BottomBarItemWidget extends StatelessWidget {
  final bool active;
  final String icon;
  final String label;
  final Function() onClick;

  const BottomBarItemWidget({
    required this.active,
    required this.onClick,
    required this.label,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color: active ? AppColors.primary : AppColors.darker,
              ),
              const HorizontalSpacing(spacing: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  color: active ? AppColors.primary : AppColors.darker,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
