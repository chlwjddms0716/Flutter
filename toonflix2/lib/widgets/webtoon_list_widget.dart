import 'package:flutter/material.dart';
import 'package:toonflix2/widgets/webtoon_widget.dart';

import '../models/webtoon_model.dart';
import '../services/api_service.dart';

class WebtoonList extends StatefulWidget {
  final String tabId;
  const WebtoonList({super.key, required this.tabId});

  @override
  State<WebtoonList> createState() => _WebtoonListState();
}

class _WebtoonListState extends State<WebtoonList> {
  late Future<List<WebtoonModel>> webtoons;
  @override
  void initState() {
    super.initState();

    webtoons = ApiService.getToonsbyDate(widget.tabId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: webtoons,
      builder: (context, snapshot) {
        // snopshot : future 데이터 받았는지, 오류났는지 알 수 있음
        if (snapshot.hasData) {
          return Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Expanded(
                flex: 18,
                child: makeList2(snapshot),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

GridView makeList2(AsyncSnapshot<List<WebtoonModel>> snapshot) {
  return GridView.builder(
    // ListView.builder, separated - 한번에 다 불러오지 않고, 화면에 보여지는 필요한 아이템만 먼저 가져옴
    scrollDirection: Axis.vertical,
    itemCount: snapshot.data!.length,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    itemBuilder: (context, index) {
      // ListView.builder, separated - 아이템을 build 할 때 호출하는 함수, index 를 사용하여 어떤 항목이 build 되었는지 알 수 있음
      var webtoon = snapshot.data![index];
      return Webtoon(
        title: webtoon.title,
        thumb: webtoon.thumb,
        id: webtoon.id,
        author: webtoon.author,
      );
    },
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
      childAspectRatio: 0.52, //item 의 가로 1, 세로 2 의 비율
      mainAxisSpacing: 0, //수평 Padding
      crossAxisSpacing: 10, //수직 Padding
    ),
  );
}
