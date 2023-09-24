import 'package:flutter/material.dart';
import 'package:toonflix2/screens/detail_screen.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id, author;

  const Webtoon(
      {super.key,
      required this.title,
      required this.thumb,
      required this.id,
      required this.author});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 애니메이션 효과를 이용해서 페이지 이동 느낌을 줌
        Navigator.push(
            context,
            MaterialPageRoute(
                fullscreenDialog: false,
                builder: (context) => DetailScreen(
                      title: title,
                      thumb: thumb,
                      id: id,
                    )));
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: id,
              child: Container(
                width: 150,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  thumb,
                  headers: const {"User-Agent": "Mozilla/5.0"},
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Flexible(
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.clip,
                author,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }
}
