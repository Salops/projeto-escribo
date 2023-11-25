import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projeto_escribo/theme/app_colors.dart';
import 'package:projeto_escribo/widgets/toast_widget.dart';

showToast({
  required BuildContext context,
  required String message,
  Color color = AppColors.success,
}) {
  FToast fToast = FToast();
  fToast.init(context);

  fToast.showToast(
    child: ToastWidget(
        message: message,
        color: color,
        onClose: () => fToast.removeCustomToast()),
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 3),
  );
}
