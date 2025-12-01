import 'package:coffee_shop_dashboard/core/helpers/colors.dart';
import 'package:coffee_shop_dashboard/widgets/my_widgets/my_text.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {

  final String? title;
  final String? message;
  final String? confirmBtnText;
  final String? cancelBtnText;

  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const ConfirmationDialog({super.key, this.title, this.message, this.confirmBtnText, this.cancelBtnText, this.onCancel, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colorWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),

      icon: Image.asset('assets/images/whiteBgLogo.png', height: 80, width: 80),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyText(title ?? "Are you sure", fontWeight: 700, fontSize: 16, textAlign: TextAlign.center),
          SizedBox(height: 10,),
          MyText(message ?? "you want to logout?", fontWeight: 500, fontSize: 14, textAlign: TextAlign.center),
        ],
      ),

      actions: [
        // Logout Button
        SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryGreen,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            onPressed: onConfirm,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: Colors.white),
                const SizedBox(width: 8),
                MyText(
                  confirmBtnText ?? "Logout",
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: 500,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Cancel Button
        SizedBox(
          width: double.infinity,
          height: 45,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFE5E5E5)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            onPressed: onCancel ?? () {
              Navigator.pop(context);
            },
            child: MyText(
              cancelBtnText ?? "Cancel",
              fontSize: 16,
              color: Colors.black87,
              fontWeight: 500,
            ),
          ),
        ),

      ],

    );
  }
}
