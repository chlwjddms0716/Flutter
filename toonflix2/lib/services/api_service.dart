import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/webtoon_detail_model.dart';
import '../models/webtoon_episode_model.dart';
import '../models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static const String todayUrl =
      "https://korea-webtoon-api.herokuapp.com/?service=naver&perPage=100";
  static const String searchUrl =
      "https://korea-webtoon-api.herokuapp.com/?service=naver&search?keyword=";

  static Future<List<WebtoonModel>> getToonsbyDate(String day) async {
    // http 패키지 설치해야됨,
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$todayUrl&updateDay=$day');
    final response = await http.get(url);

    print(url);
    if (response.statusCode == 200) {
      // Json 형식이 dynamic 값으로 이루어짐(어떤 값으로 이루어진지 모르니까), 생략가능

      final List<dynamic> webtoons = jsonDecode(response.body)['webtoons'];

      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }

    throw Error();
  }

  static Future<List<WebtoonModel>> getToonByKeyword(String keyword) async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$searchUrl$keyword');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body)['webtoons'];
      if (webtoons is List && webtoons.isNotEmpty) {
        for (var webtoon in webtoons) {
          webtoonInstances.add(WebtoonModel.fromJson(webtoon));
        }
        return webtoonInstances;
      }
    }

    throw Exception('Failed to fetch webtoons for keyword: $keyword');
  }

// async 일 때 반환 타입에 Future 넣어줘야 됨
// Future - 당장 완료될 수 있는 작업이 아님, async - await
  static Future<List<WebtoonModel>> getTodaysToons() async {
    // http 패키지 설치해야됨,
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Json 형식이 dynamic 값으로 이루어짐(어떤 값으로 이루어진지 모르니까), 생략가능
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }

    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];

    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }

      return episodesInstances;
    }
    throw Error();
  }
}
