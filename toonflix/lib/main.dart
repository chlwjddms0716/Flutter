import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';
import 'package:toonflix/widgets/card.dart';

class Player {
  // ? 붙으면 생성자에 아래와 같이 안쓰고 공백으로 놔둬도됨
  String? name;

// 중괄호를 써주면 작동하지 않음 , 그냥 "nico" 썼을 때, 네임드 파라미터라서 name 붙여줘야됨
  Player({required this.name});
}

void main() {
  var nico = Player(name: "nico");
// 아래 Text 쓴 것과 같은 종류의 생성자
// Text class 사용
// class 의 파라미터가 많을 때 named parameter 사용
// 아래 home, appBar, title, child 같이 nameed parameter
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // StatelessWidget는 builde 를 구현해줘야됨
  @override
  Widget build(BuildContext context) {
// 두 개 중 하나를 return 해야됨
// material, cupertino 각각 구글과 애플의 디자인 시스템
// home - MaterialApp Class 의 프로퍼티
// 화면이 scaffold 를 가져야함 - 구조를 제공해줌 - 모바일 앱의 모든 화면은 필요함
// 모든게 Widget 이고 = class, Widget 을 사용해줄 때마다 인스터스 생성, New 쓸 필요 없음
    return MaterialApp(
      home: Scaffold(
        // Scaffold 안에 body 라는 옵션이 있음
        // class 만들때마다 , 필수!
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Hey, Selena',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  'Total balance',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '\$5 194 482',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Button(
                      text: 'Transfer',
                      bgColor: Colors.amber,
                      textColor: Colors.black,
                    ),
                    Button(
                      text: 'Request',
                      bgColor: Color(0XFF1F2123),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Wallets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const CurrencyCard(
                  mainText: 'Euro',
                  amount: '6 428',
                  subText: 'EUR',
                  icon: Icons.euro_rounded,
                  isInverted: false,
                  order: 0,
                ),
                const CurrencyCard(
                  mainText: 'Bitcoin',
                  amount: '9 785',
                  subText: 'BTC',
                  icon: Icons.currency_bitcoin,
                  isInverted: true,
                  order: 1,
                ),
                const CurrencyCard(
                  mainText: 'Dollar',
                  amount: '428',
                  subText: 'USD',
                  icon: Icons.monetization_on_outlined,
                  isInverted: false,
                  order: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
