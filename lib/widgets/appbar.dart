import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.onBackPressed,
    this.showTitle = true,
  });

  final String? title;
  final VoidCallback? onBackPressed;
  final bool showTitle;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: onBackPressed != null ? 56 : 0,
        leading: onBackPressed != null
            ? IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackPressed,
              )
            : null,
        title: showTitle && title != null
            ? Text(
                title!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )
            : null,
        titleSpacing: 0,
      ),
    );
  }
}
