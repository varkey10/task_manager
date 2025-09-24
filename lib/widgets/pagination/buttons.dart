import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? text;
  final double? width;
  final double? height;
  final Color color;
  final TextStyle textStyle;
  final Widget? leadingImage; // Optional leading image
  final Widget? trailingImage; // Optional trailing image

  CustomButton({
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.color = const Color(0xFF2196F3),
    this.textStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    this.leadingImage,
    this.trailingImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // boxShadow: [
          //   // BoxShadow(
          //   //   color: theme
          //   //       .parseColor(theme.uiConfig!.ContainerUtils.border_color!)
          //   //       .withOpacity(0.6),
          //     spreadRadius: 0.5,
          //     blurRadius: 1,
          //     offset: Offset(0, 1), // changes position of shadow
          //   )
          // ],
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          minWidth: width ?? 0,
          minHeight: height ?? 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (leadingImage != null) leadingImage!,
            text != ""
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        text!,
                        style: textStyle,
                      ),
                    ),
                  )
                : Container(),
            if (trailingImage != null) trailingImage!,
          ],
        ),
      ),
    );
  }
}
