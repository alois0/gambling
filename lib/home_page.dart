import 'package:custom_button_builder/custom_button_builder.dart';
import 'package:flutter/material.dart';
// import 'package:gambling/home_page.dart';
import 'package:gambling/persistent_bottom_bar_scaffold.dart';
import 'dart:math';

class HomePage extends StatelessWidget {
  final _tab1navigatorKey = GlobalKey<NavigatorState>();
  final _tab2navigatorKey = GlobalKey<NavigatorState>();
  final _tab3navigatorKey = GlobalKey<NavigatorState>();
  final _tab4navigatorKey = GlobalKey<NavigatorState>();
  final _tab5navigatorKey = GlobalKey<NavigatorState>();

  static ValueNotifier<int> balance = ValueNotifier<int>(0);
  static ValueNotifier<int> debt = ValueNotifier<int>(0);

  static List startBal = [30, 500, 1500, 60, 750, 2500];
  static List startDebt = [100, 1000, 10000, 200, 2000, 20000];

  void beginGame(int o, BuildContext context) {
    num newBalance = (Random().nextInt(startBal[o]) + startBal[o + 3]) * 10;
    num newDebt = (Random().nextInt(startDebt[o]) + startDebt[o + 3]) * 100;
    balance.value = newBalance as int;
    debt.value = newDebt as int;
    // Close the initial popup
    Navigator.of(context).pop();
    // Navigate to the next popup
    showDialog(
      barrierDismissible: false,
      context: _tab1navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Begin Game"),
          content: const Text("Game is about to start..."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  HomePage({super.key});

  @override

  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Welcome to the Gambler"),
            content: const Text("Select difficulty:"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  beginGame(0, context); // Easy
                  Navigator.pop(context);
                },
                child: const Text("Easy"),
              ),
              TextButton(
                onPressed: () {
                  beginGame(1, context); // Medium
                  Navigator.pop(context);
                },
                child: const Text("Medium"),
              ),
              TextButton(
                onPressed: () {
                  beginGame(2, context); // Hard
                  Navigator.pop(context);
                },
                child: const Text("Hard"),
              ),
            ],
          );
        },
      );
    });

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
  int nFirst = 6;
  int nSecond = 6;
  int nThird = 6;
  int pot = 0;
  final List<int> values = [
    1,
    10,
    100,
    1000,
    10000,
    100000,
  ];
  final List<double> mlp = [
    0.5,
    0.6,
    0.8,
    1.3,
    1.5,
    2.0,
  ];

  void generateRandomNumbers() {
    setState(() {
      nFirst = Random().nextInt(6) + 1;
      nSecond = Random().nextInt(6) + 1;
      nThird = Random().nextInt(6) + 1;
    });
  }

  void addToPot(index) {
    setState(() {
      if (HomePage.balance.value >= values[index]) {
        pot += values[index];
        HomePage.balance.value -= values[index];
      }
    });
  }

  void collectFromPot() {
    setState(() {
      HomePage.balance.value += pot;
      pot = 0;
    });
  }

  int getPot() {
    if (nFirst == 1 && nSecond == 1 && nThird == 1) {
      return 0;
    } else if (nFirst == 6 && nSecond == 6 && nThird == 6) {
      return pot * 100;
    } else if (nFirst == 5 && nSecond == 5 && nThird == 5) {
      return pot * 50;
    }
    double f = (pot * mlp[nFirst - 1] * mlp[nSecond - 1] * mlp[nThird - 1] * 1);
    int g = f.truncate();
    return g;
  }

  void roll() {
    generateRandomNumbers();
    setState(() {
      pot = getPot();
    });
  }

  String formatNumberWithCommas(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<int>(
          valueListenable: HomePage.balance,
          builder: (context, number, child) {
            return Text('€ ${formatNumberWithCommas(number)}');
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Pot",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              "€ ${formatNumberWithCommas(pot)}",
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row( // Use Row instead of Column for horizontal layout
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/dicesprites/dice_$nFirst.png',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(width: 20),
                Image.asset(
                  'assets/dicesprites/dice_$nSecond.png',
                  height: 80,
                  width: 80,
                ),
                const SizedBox(width: 20),
                Image.asset(
                  'assets/dicesprites/dice_$nThird.png',
                  height: 80,
                  width: 80,
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
              width: 290,
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
                      formatNumberWithCommas(values[index]),
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
      appBar: AppBar(
        title: ValueListenableBuilder<int>(
          valueListenable: HomePage.balance,
          builder: (context, number, child) {
            return Text('€ $number');
          },
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tab 2'),
            ValueListenableBuilder<int>(
              valueListenable: HomePage.balance,
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
                HomePage.balance.value++; // Increase global number
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

  void victoryScreen(BuildContext context) {
    int val1 = HomePage.balance.value; // Access the value using .value
    int val2 = HomePage.debt.value;    // Access the value using .value
    if (val1 >= val2) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("DEBT SETTLED"),
            content: const Text("Well done"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("restarting"),
                        content: const Text("initializing conditions"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              HomePage.balance.value = 500;
                              HomePage.debt.value = 10000;
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text("easy"),
                          ),
                          TextButton(
                            onPressed: () {
                              HomePage.balance.value = 5000;
                              HomePage.debt.value = 100000;
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text("medium"),
                          ),
                          TextButton(
                            onPressed: () {
                              HomePage.balance.value = 15000;
                              HomePage.debt.value = 500000;
                              Navigator.pop(context); // Close the dialog
                            },
                            child: const Text("hard"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text("Restart"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("insufficient"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("ok")
              ),
            ],
          );
        },
      );
    }
  }

  String formatNumberWithCommas(int number) {
    return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), 
            (Match match) => '${match[1]},',
    );
  }

  static List startBal = [30, 500, 1500, 60, 750, 2500];
  static List startDebt = [100, 1000, 10000, 200, 2000, 300000];
  void restartGame(o) {
    num newBalance = (Random().nextInt(startBal[o]) + startBal[o + 3]) * 10;
    num newDebt = (Random().nextInt(startDebt[o]) + startDebt[o + 3]) * 100;
    HomePage.balance.value = newBalance as int;
    HomePage.debt.value = newDebt as int;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      backgroundColor: Colors.white38,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'gambler',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ValueListenableBuilder<int>(
              valueListenable: HomePage.balance,
              builder: (context, number, child) {
                return Text(
                    'account: €${formatNumberWithCommas(number)}',
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<int>(
              valueListenable: HomePage.debt,
              builder: (context, number, child) {
                return Text(
                  'debt: €${formatNumberWithCommas(number)}',
                  style: const TextStyle(fontSize: 18),
                );
              },
            ),
            const SizedBox(height: 40),
            CustomButton(
              width: 300,
              backgroundColor: Colors.white,
              isThreeD: true,
              height: 50,
              borderRadius: 5,
              animate: true,
              margin: const EdgeInsets.all(10),
              onPressed: () {
                victoryScreen(context);
              },
              child: const Text(
                "Pay debts",
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("restarting"),
                      content: const Text("are you sure?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            restartGame(0);
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text("easy"),
                        ),
                        TextButton(
                          onPressed: () {
                            restartGame(1);
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text("medium"),
                        ),
                        TextButton(
                          onPressed: () {
                            restartGame(2);
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text("hard"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text("cancel"),
                        ),
                      ],
                    );
                  },
                );
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

class TabPage4 extends StatefulWidget {
  const TabPage4({super.key});

  @override
  _TabPage4State createState() => _TabPage4State();
}

class _TabPage4State extends State<TabPage4> {
  int totalCrates = 0;

  void openCrate() {
    setState(() {
      if (totalCrates > 0) {
        totalCrates--;
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("No more crates to open!"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loot Crates')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: openCrate,
              child: const Text('Open Crate'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: totalCrates,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Crate ${index + 1}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const InventoryPage('tab4')));
                },
                child: const Text('open inventory')
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryPage extends StatelessWidget {
  final String inTab;

  const InventoryPage(this.inTab, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('inventory'),
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
      body: SingleChildScrollView(
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