import 'package:flutter/material.dart';

void main() {
  runApp(const Timer());
}

class Timer extends StatelessWidget {
  const Timer({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15), child: TopBar()),
          SizedBox(
            height: 20,
          ),
          Body(),
        ],
      ),
      backgroundColor: const Color(0xFF1a1a1a),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Hi, User',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 30),
          ),
          Text(
            '25.02.2023',
            style: TextStyle(color: Color(0xFF858584), fontSize: 18),
          )
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)), color: Colors.red[300],),
                  child: Column(
                    children: [
                     const Text(
                        '25:00',
                        style: TextStyle(color: Colors.white, fontSize: 90, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.white,),
                        padding: const EdgeInsets.all(15),
                        child: const Text('START', style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),),
                      )
                    ],
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
