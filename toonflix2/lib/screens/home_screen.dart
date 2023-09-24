import 'package:flutter/material.dart';
import 'package:toonflix2/models/webtoon_model.dart';
import 'package:toonflix2/screens/search_screen.dart';
import 'package:toonflix2/widgets/webtoon_list_widget.dart';
import 'package:toonflix2/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

// const 컴파일 전 값을 알 수 있을 때 사용, Future 사용해서 위 HomeScreen 앞에 const 사용할 수 없음
// FutureBuilder는 StatelessWidget 에서만 가능

  static const textStyle = TextStyle(fontSize: 19);
  final Map<String, String> tabs = {
    "naverDaily": "매일+",
    "mon": "월",
    "tue": "화",
    "wed": "수",
    "thu": "목",
    "fri": "금",
    "sat": "토",
    "sun": "일",
    "finished": "완결"
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: false,
                        builder: (context) => const SearchScreen()));
              },
              icon: const Icon(
                Icons.search,
                size: 35,
                color: Colors.black,
              ),
            ),
          ],
          title: const Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          elevation: 2,
          bottom: TabBar(
              labelColor: Colors.greenAccent.shade400,
              indicatorWeight: 3,
              indicatorColor: Colors.greenAccent.shade400,
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              labelStyle: const TextStyle(fontSize: 16),
              tabs: [
                for (MapEntry item in tabs.entries)
                  Tab(
                    text: item.value,
                  )
              ]),
        ),
        body: TabBarView(children: [
          for (MapEntry item in tabs.entries) WebtoonList(tabId: item.key)
        ]),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
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
        // ListView.separated 에서만 필요로하는 함수
        separatorBuilder: (context, index) => const SizedBox(
              height: 30,
              width: 20,
            )
        // widget을 리턴하는 함수, 아이템들을 구분하는 위젯들
        );
  }
}
