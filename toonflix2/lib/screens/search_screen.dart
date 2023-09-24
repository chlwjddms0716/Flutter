import 'package:flutter/material.dart';
import 'package:toonflix2/screens/home_screen.dart';

import '../models/webtoon_model.dart';
import '../services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String inputText = "";

  late Future<List<WebtoonModel>> searchWebtoons;
  bool isSearchLoad = false;

  @override
  void initState() {
    super.initState();

    searchWebtoons = Future.value([]);
  }

  void onSearch(String keyword) {
    setState(() {
      isSearchLoad = false;
      searchWebtoons = ApiService.getToonByKeyword(keyword);
      isSearchLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: TextField(
                      onSubmitted: onSearch,
                      decoration: const InputDecoration(
                        hintText: '제목 또는 작가명 검색',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black12),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: false,
                                builder: (context) => HomeScreen()));
                      },
                      child: const Text(
                        '취소',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (isSearchLoad)
              FutureBuilder(
                future: searchWebtoons,
                builder: (context, snapshot) {
                  // snopshot : future 데이터 받았는지, 오류났는지 알 수 있음
                  if (snapshot.hasError) {
                    return const Text('검색결과가 없습니다.');
                  } else if (snapshot.hasData) {
                    // 데이터가 있는 경우
                    return Expanded(child: makeList(snapshot.data!));
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

ListView makeList(List<WebtoonModel> data) {
  return ListView.separated(
      // ListView.builder, separated - 한번에 다 불러오지 않고, 화면에 보여지는 필요한 아이템만 먼저 가져옴
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        // ListView.builder, separated - 아이템을 build 할 때 호출하는 함수, index 를 사용하여 어떤 항목이 build 되었는지 알 수 있음
        var webtoon = data[index];
        print(webtoon.thumb);
        return Row(
          children: [
            Container(
              width: 80,
              child: Image.network(webtoon.thumb,
                  headers: const {"User-Agent": "Mozilla/5.0"}),
            ),
            SizedBox(
              width: 20,
            ),
            Text(webtoon.title),
          ],
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
