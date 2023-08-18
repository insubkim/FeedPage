import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../services/api_service.dart';

class FeedHome extends StatefulWidget {
  const FeedHome({super.key});

  @override
  State<FeedHome> createState() => _FeedHomeState();
}

class _FeedHomeState extends State<FeedHome> {
  //ascending if order = 0
  //descending if order = 1
  int order = 0;
  Future<List<CategoryModel>> categories = ApiService.getCategories();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                var a = snapshot.data![index];
                return Text(
                  a.name,
                  style: const TextStyle(fontSize: 40),
                );
              },
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
