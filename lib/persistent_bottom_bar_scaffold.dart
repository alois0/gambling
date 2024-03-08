import 'package:flutter/material.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  /// pass the required items for the tabs and BottomNavigationBar
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({super.key, required this.items});

  @override
  _PersistentBottomBarScaffoldState createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  int _selectedTab = 2;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// Check if current tab can be popped
        if (widget.items[_selectedTab].navigatorkey?.currentState?.canPop() ??
            false) {
          widget.items[_selectedTab].navigatorkey?.currentState?.pop();
          return false;
        } else {
          // if current tab can't be popped then use the root navigator
          return true;
        }
      },
      child: Scaffold(
        /// Using indexedStack to maintain the order of the tabs and the state of the
        /// previously opened tab
        body: IndexedStack(
          index: _selectedTab,
          children: widget.items
              .map((page) => Navigator(
            /// Each tab is wrapped in a Navigator so that navigation in
            /// one tab can be independent of the other tabs
            key: page.navigatorkey,
            onGenerateInitialRoutes: (navigator, initialRoute) {
              return [
                MaterialPageRoute(builder: (context) => page.tab)
              ];
            },
          ))
              .toList(),
        ),

        /// Define the persistent bottom bar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) {
            if (index == _selectedTab) {
              widget.items[index].navigatorkey?.currentState?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _selectedTab = index;
              });
            }
          },
          items: widget.items
              .map((item) {
            return BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _selectedTab == widget.items.indexOf(item) ? 36.0 : 24.0, // Set the desired size
                height: _selectedTab == widget.items.indexOf(item) ? 36.0 : 24.0,
                child: Icon(item.icon, color: item.color),
              ),
              label: '', // Empty string to hide the label
            );
          })
              .toList(),
        ),
      ),
    );
  }
}

/// Model class that holds the tab info for the [PersistentBottomBarScaffold]
class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;
  final Color color;

  PersistentTabItem(
      {required this.tab,
        this.navigatorkey,
        required this.title,
        required this.icon,
        required this.color,
      });
}