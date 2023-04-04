import 'package:flutter/material.dart';

class ResponsiveChildren extends StatelessWidget {
  final List<Widget> children;
  final double size;
  MainAxisAlignment rowAlignment;
  ResponsiveChildren(
      {required this.children, required this.size, required this.rowAlignment, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MediaQuery.of(context).size.width >= size)
        ? Row(
            mainAxisAlignment: rowAlignment,
            children: children,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
  }
}
