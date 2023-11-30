import 'package:flutter/material.dart';

// Custom widget representing a navigation tab in a web application.
class WebNavigationTabs extends StatelessWidget {
  // Indicates whether the tab is currently selected.
  final bool condition;

  // The title of the navigation tab.
  final String? title;

  // The icon associated with the navigation tab.
  final IconData icon;

  // Constructor for the WebNavigationTabs widget.
  const WebNavigationTabs({
    required this.condition,
    required this.title,
    required this.icon,
  });

  // Build method for the widget, defining its appearance and behavior.
  @override
  Widget build(BuildContext context) {
    return Container(
      // Decorate the container based on the selected condition.
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
            // Display the icon associated with the navigation tab.
            Icon(
              icon,
              color: condition ? Colors.white : Colors.blueGrey,
            ),
            const SizedBox(width: 5),
            // Display the title of the navigation tab.
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
