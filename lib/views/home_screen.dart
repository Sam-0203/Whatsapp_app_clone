import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/calls/calls.dart';
import 'package:whatsapp_clone/views/chat/screens/chat.dart';
import 'package:whatsapp_clone/views/chat/screens/new_chat.dart';
import 'package:whatsapp_clone/views/community/commuity.dart';
import 'package:whatsapp_clone/views/status/status_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String? text;
  Color? color;
  IconData? icon;
  VoidCallback? onPressed;
  List<Widget>? actionsList;

  final List<Widget> pages = const [
    ChatScreen(),
    StatusSCreen(),
    CommunityScreen(),
    CallsScreen(),
  ];

  List<String> filters = [
    'All',
    'Unread 4',
    'Favorites',
    'Groups 9',
    'Communities 2',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 1) {
      text = 'Status';
      color = Colors.white;
      icon = Icons.camera_alt;
      onPressed = () {};
      actionsList = [
        Padding(padding: EdgeInsets.all(8), child: Icon(Icons.search)),
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.more_vert_outlined),
        ),
      ];
    } else if (_currentIndex == 2) {
      text = 'Communities';
      color = Colors.white;
      onPressed = () {};
      actionsList = [
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.more_vert_outlined),
        ),
      ];
    } else if (_currentIndex == 3) {
      text = 'Calls';
      icon = Icons.add_call;
      color = Colors.white;
      onPressed = () {};
      actionsList = [
        Padding(padding: EdgeInsets.all(8), child: Icon(Icons.search)),
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.more_vert_outlined),
        ),
      ];
    } else {
      text = 'WhatsApp';
      color = Color(0xFF25D366);
      icon = Icons.chat;
      onPressed = () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => NewChats()));
      };
      actionsList = [
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.currency_rupee_outlined),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.camera_alt_outlined),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.more_vert_outlined),
        ),
      ];
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: _currentIndex == 0 ? 100 : kToolbarHeight,
        title: Text(
          text!,
          style: TextStyle(
            color: color!,
            // color: Color(0xFF25D366),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: actionsList!,
        bottom: _currentIndex == 0
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      // Search
                      Container(
                        height: 45,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),

                        child: TextField(
                          style: const TextStyle(color: Colors.white),

                          decoration: InputDecoration(
                            hintText: 'Ask Meta AI or Search',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                            ),

                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white.withOpacity(0.6),
                            ),

                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      //filters
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: Row(
                          children: filters.map((filter) {
                            bool isSelected = filter == filters.first;

                            return Padding(
                              padding: const EdgeInsets.only(right: 10),

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade800,
                                  ),

                                  borderRadius: BorderRadius.circular(20),

                                  color: isSelected
                                      ? Color(0xFF25D366)
                                      : Colors.transparent,
                                ),

                                child: Text(
                                  filter,

                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),

      body: pages[_currentIndex],
      floatingActionButton: _currentIndex == 2
          ? null
          : FloatingActionButton(
              heroTag: 'home_fab_$_currentIndex',
              onPressed: onPressed,
              backgroundColor: const Color(0xFF25D366),
              child: Icon(icon!),
            ),
      bottomNavigationBar: SizedBox(
        height: 115,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,

          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.chat_rounded, size: 28),

              activeIcon: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.chat_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),

              label: 'Chats',
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.circle_outlined, size: 28),

              activeIcon: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.circle_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),

              label: 'Updates',
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.groups_outlined, size: 28),

              activeIcon: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.groups_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),

              label: 'Communities',
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.call_outlined, size: 28),

              activeIcon: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF25D366),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.call_outlined,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),

              label: 'Calls',
            ),
          ],
        ),
      ),
    );
  }
}
