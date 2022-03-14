import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 20,
      thickness: 1,
      indent: 10,
      endIndent: 10,
      color: Colors.grey,
    );
  }
}