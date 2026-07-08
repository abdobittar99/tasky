import 'package:flutter/material.dart';

class CustomElevatedButtom extends StatelessWidget {
  const CustomElevatedButtom({super.key, required this.onPressed, this.text});
  final VoidCallback? onPressed;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff15B86C),
        foregroundColor: Color(0xfffffcfc),
        fixedSize: Size(MediaQuery.of(context).size.width, 40),
      ),
      child: Text(text ?? ''),
    );
  }
}
// Widget _buildContent() {
//     if (icon == null) {
//       return Text(text, style: textStyle);
//     }

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, size: 18, color: iconColor),
//         const SizedBox(width: 8),
//         Text(text, style: textStyle),
//       ],
//     );
//   }
