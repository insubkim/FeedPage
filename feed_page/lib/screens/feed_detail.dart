import 'package:feed_page/models/detail_model.dart';
import 'package:feed_page/services/api_service.dart';
import 'package:flutter/material.dart';

class FeedDetail extends StatelessWidget {
  final Future<DetailModel> detailModel;
  final int id;
  FeedDetail({super.key, required this.id})
      : detailModel = ApiService.getDetailModel(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Colors.blue[900],
                          height: 20,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          detail.title,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          detail.contents,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(detail.created,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          color: Colors.blue[900],
                          height: 20,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Text(
                          '답변 ${detail.replyModelList.length}',
                          style: const TextStyle(fontSize: 21),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: Colors.grey[350],
                          height: 20,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          detail.replyModelList[index - 1].user.name,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        Divider(
                          color: Colors.grey[350],
                          height: 20,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          detail.replyModelList[index - 1].contents,
                          style: const TextStyle(fontSize: 17),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          detail.replyModelList[index - 1].created,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Colors.grey[350],
                          height: 20,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    );
                  }
                },
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
