import 'package:flutter/material.dart';

class DLListTile extends StatelessWidget {
  const DLListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.trailing,
    required this.tileColor,
  });
  final Widget title, subtitle, leading, trailing;
  final Color? tileColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tileColor,
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: leading,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title,
                subtitle,
              ],
            ),
          ),
          SizedBox(
            width: 80,
            child: trailing,
          ),
        ],
      ),
    );
  }
}
