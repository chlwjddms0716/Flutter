import 'package:flutter/material.dart';

void main() {

  runApp(FlexibleWidgetExample());
}

class FlexibleWidgetExample extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Flexible(
                  flex: 2,

                child: Container(
                  color: Colors.red,
                ),
              ),

              Flexible(
                  flex: 2,

                  child: Container(
                    color: Colors.blue,
                  ),
              ),

              Flexible(
                flex: 1,

                child: Container(
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColumnWidgetExample extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.red,
              ),

              const SizedBox(width: 12.0),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.green,
              ),

              const SizedBox(width: 12.0),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        ),
      );
  }
}

class RowWidgetExample extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        body: SizedBox(
          height: double.infinity,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.red,
              ),

              const SizedBox(width: 12.0),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.green,
              ),

              const SizedBox(width: 12.0),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingActionButtonExample extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            print('Floating Button On Pressed');
          },
          child: Text('클릭'),
        ),
        body: Container(
         color: Colors.blue,

          child: Container(
            color: Colors.black,
            margin: EdgeInsets.all(10.0),

            child: Padding(
              padding: EdgeInsets.all(10.0),

              child: Container(
                color: Colors.red,
              )
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: (){
              print('On Tap');
            },
            onDoubleTap: (){
              print('On DoubleTap');
            },
            onLongPress: (){
              print('On LongPress');
            },

            child: TextButton(
              onPressed: () {
                print('TextButton OnPressed');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.black,
              ),
                child: Text('버튼이당'),
            ),
          ),
        ),
      ),
    );
  }
 }
