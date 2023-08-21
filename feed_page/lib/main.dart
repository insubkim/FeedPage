import 'package:feed_page/models/filter_model.dart';
import 'package:feed_page/screens/feed_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => FilterModel(),
    child: const FeedPage(),
  ));
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
