import 'package:flutter/material.dart';

class WebNavigationTabs extends StatelessWidget {
  final bool condition;
  final String? title;
  final IconData icon;

  const WebNavigationTabs({
    required this.condition,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: condition
          ? BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 40.0,
                  spreadRadius: 0.0,
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                ),
              ],
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                const BoxShadow(color: Colors.white),
              ],
            ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: condition ? Colors.white : Colors.blueGrey,
            ),
            const SizedBox(width: 5),
            Text(title!,
                style: condition
                    ? TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontFamily: 'Ubuntu')
                    : TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey,
                        fontFamily: 'Ubuntu')),
          ],
        ),
      ),
    );
  }
}
