import 'package:flutter/material.dart';
import 'package:projeto_escribo/theme/app_colors.dart';
import 'package:projeto_escribo/widgets/horizontal_spacing.dart';

class ToastWidget extends StatelessWidget {
  final String message;
  final Color color;
  final Function() onClose;

  const ToastWidget({
    super.key,
    required this.message,
    required this.onClose,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(message,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                )),
          ),
          const HorizontalSpacing(spacing: 16),
          IconButton(
              onPressed: onClose,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.close,
                size: 12,
                color: AppColors.white,
              ))
        ],
      ),
    );
  }
}
