import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyState extends StatelessWidget {
  final String imgPath;
  final String message;

  const EmptyState({Key? key, required this.imgPath, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        color: Color(0XFFE3E4E8),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(
                    imgPath,
                    color: const Color(0XFF929DB3),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(message,
                      style: const TextStyle(
                          color: Color(0XFF15314D), fontSize: 16, height: 1.5)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
