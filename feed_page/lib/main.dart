import 'package:feed_page/screens/feed_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FeedPage());
}

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FeedHome(),
    );
  }
}
