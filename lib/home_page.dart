import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:gambling/persistent_bottom_bar_scaffold.dart';
import 'dart:math';



class HomePage extends StatelessWidget {
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();
  final _tab4navigatorKey = GlobalKey<NavigatorState>();
  final _tab5navigatorKey = GlobalKey<NavigatorState>();

  static ValueNotifier<int> globalNumber = ValueNotifier<int>(500);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentBottomBarScaffold(
      items: [
        PersistentTabItem(
          tab: const TabPage1(),
          color: Colors.amber,
          icon: Icons.dataset,
          title: 'Home',
          navigatorkey: _tab1navigatorKey,
        ),
        PersistentTabItem(
          tab: const TabPage2(),
          color: Colors.deepPurple,
          icon: Icons.table_rows_rounded,
          title: 'Search',
          navigatorkey: _tab2navigatorKey,
        ),
        PersistentTabItem(
          tab: const TabPage3(),
          color: Colors.blue,
          icon: Icons.home,
          title: 'Profile',
          navigatorkey: _tab3navigatorKey,
        ),
        PersistentTabItem(
          tab: const TabPage4(),
          color: Colors.deepPurple,
          icon: Icons.gamepad,
          title: 'Dice',
          navigatorkey: _tab4navigatorKey,
        ),
        PersistentTabItem(
          tab: const TabPage5(),
          color: Colors.amber,
          icon: Icons.lens_sharp,
          title: 'Loot',
          navigatorkey: _tab5navigatorKey,
        ),
      ],
    );
  }
}

class TabPage1 extends StatefulWidget {
  const TabPage1({super.key});

  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  int firstNumber = 6;
  int secondNumber = 6;
  int thirdNumber = 6;
  int pot = 0;
  final List<int> values = [
    10,
    50,
    100,
    250,
    1000,
    5000,
  ];
  final List<double> mlp = [
    0.1,
    0.6,
    0.8,
    1.2,
    1.4,
    2.0,
  ];

  void generateRandomNumbers() {
    setState(() {
      firstNumber = Random().nextInt(6) + 1;
      secondNumber = Random().nextInt(6) + 1;
      thirdNumber = Random().nextInt(6) + 1;
    });
  }

  void addToPot(index) {
    setState(() {
      if (HomePage.globalNumber.value >= values[index]) {
        pot += values[index];
        HomePage.globalNumber.value -= values[index];
      }
    });
  }

  void collectFromPot() {
    setState(() {
      HomePage.globalNumber.value += pot;
      pot = 0;
    });
  }

  void roll() {
    setState(() {
      generateRandomNumbers();
      pot *= (mlp[firstNumber-1]*mlp[firstNumber-1]*mlp[firstNumber-1]) as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dice')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Pot",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              "$pot",
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row( // Use Row instead of Column for horizontal layout
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$firstNumber',
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                const SizedBox(width: 20),
                Text(
                  '$secondNumber',
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
                const SizedBox(width: 20),
                Text(
                  '$thirdNumber',
                  style: const TextStyle(fontSize: 40, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
              width: 300,
              backgroundColor: Colors.white,
              isThreeD: true,
              height: 50,
              borderRadius: 5,
              animate: true,
              margin: const EdgeInsets.all(10),
              onPressed: () {
                roll();
              },
              child: const Text(
                "Roll the dice",
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              width: 300,
              backgroundColor: Colors.white,
              isThreeD: true,
              height: 50,
              borderRadius: 5,
              animate: true,
              margin: const EdgeInsets.all(10),
              onPressed: () {
                collectFromPot();
              },
              child: const Text(
                "Collect",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                children: List.generate(6, (index) {
                  return ElevatedButton(
                    onPressed: () {
                      addToPot(index);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                      minimumSize: const Size(30, 30),
                    ),
                    child: Text(
                      '${values[index]}',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabPage2 extends StatelessWidget {
  const TabPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab 2')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tab 2'),
            ValueListenableBuilder<int>(
              valueListenable: HomePage.globalNumber,
              builder: (context, number, child) {
                return Text('Global Number: $number');
              },
            ),
            CustomButton(
              width: 300,
              backgroundColor: Colors.white,
              isThreeD: true,
              height: 50,
              borderRadius: 5,
              animate: true,
              margin: const EdgeInsets.all(10),
              onPressed: () {
                HomePage.globalNumber.value++; // Increase global number
              },
              child: const Text(
                "Increment",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabPage3 extends StatelessWidget {
  const TabPage3({super.key});

  @override
  Widget build(BuildContext context) {
    int debt = 584630; // Replace with your actual variable for debt

    return Scaffold(
      appBar: AppBar(title: const Text('')),
      backgroundColor: Colors.white38,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Gambler',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            ValueListenableBuilder<int>(
              valueListenable: HomePage.globalNumber,
              builder: (context, number, child) {
                return Text(
                    'Account: €$number',
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Debt: € $debt',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 60),
            CustomButton(
              width: 300,
              backgroundColor: Colors.white,
              isThreeD: true,
              height: 50,
              borderRadius: 5,
              animate: true,
              margin: const EdgeInsets.all(10),
              onPressed: () {
                // Are you sure, on yes : new account val, new debt
              },
              child: const Text(
                "Restart",
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              width: 300,
              backgroundColor: Colors.white,
              isThreeD: true,
              height: 50,
              borderRadius: 5,
              animate: true,
              margin: const EdgeInsets.all(10),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Page2('tab2')));
              },
              child: const Text(
                "Settings",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabPage4 extends StatelessWidget {
  const TabPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab 4')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tab 4'),
            CustomButton(
              width: 300,
              backgroundColor: Colors.white,
              isThreeD: true,
              height: 50,
              borderRadius: 5,
              animate: true,
              margin: const EdgeInsets.all(10),
              onPressed: () {
                HomePage.globalNumber.value++; // Increase global number
              },
              child: const Text(
                "Increment",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabPage5 extends StatelessWidget {
  const TabPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab 5')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tab 5'),
            ElevatedButton(
                onPressed: () {
                  HomePage.globalNumber.value--; // Decrease global number
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Page2('tab5')));
                },
                child: const Text('Go to page2'))
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  final String inTab;

  const Page1(this.inTab, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 1')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('in $inTab Page 1'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Page2(inTab)));
                },
                child: const Text('Go to page2'))
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  final String inTab;

  const Page2(this.inTab, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 2')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('in $inTab Page 2'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Page3(inTab)));
                },
                child: const Text('Go to page3'))
          ],
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  final String inTab;

  const Page3(this.inTab, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 3')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('in $inTab Page 3'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Go back'))
          ],
        ),
      ),
    );
  }
}