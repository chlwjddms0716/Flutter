import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showTitle = true;

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        home: Scaffold(
          backgroundColor: const Color(0xFFF4EDDB),
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              showTitle ? const MyLargeTitle() : const Text('nothing'),
              IconButton(
                  onPressed: toggleTitle,
                  icon: const Icon(Icons.remove_red_eye))
            ]),
          ),
        ));
  }
}

class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  int count = 0;

  @override
  void initState() {
    // 초기화 메소드, 꼭 사용하지 않아도 됨 그냥 위에서 초기화 할 수 있어서
    // 종종 부모 요소에 의존하는 데이터를 초기화할 때가 있음, Build 메소드보다 먼저 실행되어야 하고 한번만 호출됨
    // 예 - API 업데이트 구독
    super.initState();

    print('initState!');
  }

  @override
  void dispose() {
    // 예 - API 구독 취소, 위젯 트리가 제거되기 전에 무언가를 취소할 때
    super.dispose();
    print('dispose');
  }

  @override
  // context 부모에 접근할 수 있게 해줌, 위젯의 위치에 대한 정보, 누가부모인지,
  // Text 이전에 있는 모든 상위 요소들에 대한 정보를 담고 있음
  Widget build(BuildContext context) {
    print('build!');
    return Text(
      'My Large Title',
      style:
          // Theme.of(context).textTheme.titleLarge,
          TextStyle(
              fontSize: 30,
              // null 값 일 수도 있어서 에러 뜸, ! 붙여줘야됨, const 지워주고, ? 있으면 사용
              color: Theme.of(context).textTheme.titleLarge?.color,
              fontWeight: FontWeight.bold),
    );
  }
}
