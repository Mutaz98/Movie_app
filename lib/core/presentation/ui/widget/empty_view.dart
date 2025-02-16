import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String content;
  final String? image;
  final IconData? icon;
  final Widget? iconWidget;

  const EmptyView({
    super.key,
    required this.content,
    this.image,
    this.icon,
    this.iconWidget,
  }) : assert(icon != null || image != null || iconWidget != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: Colors.grey,
                  size: 100.0,
                )
              : image != null
                  ? Image.asset(
                      image!,
                      width: MediaQuery.of(context).size.width * 0.3,
                      fit: BoxFit.contain,
                      color: Colors.grey,
                    )
                  : iconWidget!,
          const SizedBox(height: 12.0),
          Text(
            content.toString(),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
