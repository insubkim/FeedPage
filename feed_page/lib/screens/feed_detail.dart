import 'package:feed_page/models/detail_model.dart';
import 'package:feed_page/services/api_service.dart';
import 'package:flutter/material.dart';

class FeedDetail extends StatelessWidget {
  late Future<DetailModel> detailModel;
  final int id;
  FeedDetail({super.key, required this.id}) {
    detailModel = ApiService.getDetailModel(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: detailModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DetailModel detail = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: detail.replyModelList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.blue,
                        height: 20,
                        thickness: 1,
                      ),
                      Text(detail.title),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(detail.contents),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(detail.created),
                      const Divider(
                        color: Colors.blue,
                        height: 20,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('답변 ${detail.replyModelList.length}'),
                    ],
                  );
                } else {
                  return const Text('a');
                }
              },
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
