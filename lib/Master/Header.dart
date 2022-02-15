import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final String title;
  final TextStyle? appText;
  const Header({Key? key, required this.title, required this.appText})
      : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          widget.title,
          style: widget.appText!.copyWith(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
