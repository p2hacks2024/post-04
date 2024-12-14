import 'package:design_sync/design_sync.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
  final String title;

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          toolbarHeight: 100.adaptedHeight,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              onPressed: () {
                context.pop();
              }, 
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 40
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(fontSize: 32,color: Colors.white),
          ),
        ),
      );
  }
  
  @override
  Size get preferredSize => Size(double.infinity, 100.adaptedHeight);
}