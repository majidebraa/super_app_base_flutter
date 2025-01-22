import 'package:flutter/material.dart';

class AvatarPage extends StatefulWidget {
  final String avatarUrl;
  const AvatarPage({super.key, required this.avatarUrl});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            widget.avatarUrl,
            fit: BoxFit.fill,
          ),
        )
    );
  }
}
