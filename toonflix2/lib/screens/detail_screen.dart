import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix2/models/webtoon_detail_model.dart';
import 'package:toonflix2/models/webtoon_episode_model.dart';

import '../services/api_service.dart';
import '../widgets/episode_widget.dart';

// 핸드폰 저장소 - flutter pub add shared_preferences
// 1. 핸드폰 저장소와 커넥션 - getInstance
// 2. 각기 다른 값과, 자료형을 설정할 수 있음 - setInt, setBool, setDouble, setStringListm,,
// 3. 데이터 가져오기 - getInt, getDouble, getString,,

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
// webtoon property 초기화 할 때 다른 propert인 id에 접근 불가능
// StateFulWidget으로 변경해줘야됨(함수에 파라미터 필요할 때), property 쓸 때 widget 붙여야댐, 위에 class에만 프로퍼티를 넘겨줘서
//
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          // initState 에서 호출했더라도 setState를 해줘야 ui 반영됨
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }

      await prefs.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

// 정의와 동시에 프로퍼티(widget.id)를 쓸 수 없어서 init 할 때 불러옴
  @override
  void initState() {
    // build보다 먼저 호출되며, 한번만 호출됨
    super.initState();
    webtoon = ApiService.getToonById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon:
                Icon(!isLiked ? Icons.favorite_border_rounded : Icons.favorite),
          ),
        ],
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: Container(
                      width: 250,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                offset: const Offset(10, 10),
                                color: Colors.black.withOpacity(0.5)),
                          ]),
                      child: Image.network(
                        widget.thumb,
                        headers: const {"User-Agent": "Mozilla/5.0"},
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return const Text('...');
                },
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      // ListViewsms 아이템이 많을 때 사용하는게 좋음, 데이터 10개 밖에 안되니까 Column 사용
                      // 데이터 몇개인지 모를 땐 ListView 사용하는 게 좋음
                      children: [
                        for (var episode in snapshot.data!)
                          Episode(episode: episode, webtoonId: widget.id),
                      ],
                    );
                  }
                  return Container();
                },
                future: episodes,
              )
            ],
          ),
        ),
      ),
    );
  }
}
