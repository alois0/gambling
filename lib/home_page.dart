import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter/material.dart';
import 'package:gambling/persistent_bottom_bar_scaffold.dart';



class HomePage extends StatelessWidget {
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();
  final _tab4navigatorKey = GlobalKey<NavigatorState>();
  final _tab5navigatorKey = GlobalKey<NavigatorState>();

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
          color: Colors.red,
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
          color: Colors.red,
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

class TabPage1 extends StatelessWidget {
  const TabPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab 1')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tab 1'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Page1('Tab1')));
                },
                child: const Text('Go to page1'))
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
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Page2('tab2')));
                },
                child: const Text('Go to page2'))
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
    int account = 95; // Replace with your actual variable for account
    int debt = 5846; // Replace with your actual variable for debt

    return Scaffold(
      appBar: AppBar(title: const Text('Gambler')),
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
            const SizedBox(height: 20),
            Text(
              'Account: $account',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Debt: $debt',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            CustomButton(
              width: 300,
              backgroundColor: Colors.white,
              isThreeD: true,
              height: 50,
              borderRadius: 25,
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
              borderRadius: 25,
              animate: true,
              margin: const EdgeInsets.all(10),
              onPressed: () {
                // Are you sure, on yes : new account val, new debt
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
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Page2('tab4')));
                },
                child: const Text('Go to page2'))
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