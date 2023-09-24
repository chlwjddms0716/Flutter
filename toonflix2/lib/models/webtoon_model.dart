class WebtoonModel {
  final String title, thumb, id, author;

// {id: 775141,
// title: 66666년 만에 환생한 흑마법사,
// thumb: https://image-comic.pstatic.net/webtoon/775141/thumbnail/thumbnail_IMAG21_11d97e88-9ccf-4e7a-a10d-dde42725e3fa.jpg}

// named constructor 생성자 fromJson
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'].toString(),
        thumb = json['img'].toString(),
        id = json['webtoonId'].toString().substring(7),
        author = json['author'] ?? "author";
}
