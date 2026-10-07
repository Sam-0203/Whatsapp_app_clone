import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/calls/calling_screen.dart';
import 'package:whatsapp_clone/views/chat/users_list.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  final UserList userList = UserList();

  Widget _topOption({required IconData icon, required String title}) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,

          decoration: BoxDecoration(
            color: Colors.black38,
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: Colors.grey),
          ),

          child: Icon(icon, color: Colors.white, size: 28),
        ),

        const SizedBox(height: 8),

        Text(title, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  _topOption(icon: Icons.phone_outlined, title: 'Call'),

                  _topOption(
                    icon: Icons.calendar_month_outlined,
                    title: 'Schedule',
                  ),

                  _topOption(icon: Icons.dialpad, title: 'Keypad'),

                  _topOption(icon: Icons.favorite_outline, title: 'Favorites'),
                ],
              ),
            ),

            /// RECENT CALLS TEXT
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),

              child: Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Recent',

                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            /// CALL LIST
            Expanded(
              child: ListView.builder(
                itemCount: userList.usersList.length,

                itemBuilder: (context, index) {
                  final user = userList.usersList[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),

                    /// PROFILE IMAGE
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(user['imageURL']),
                    ),

                    /// NAME + STATUS
                    title: Text(
                      user['name'],

                      style: TextStyle(
                        color: user['callStatus'] == 'missed'
                            ? Colors.red
                            : Colors.white,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Row(
                      children: [
                        Icon(
                          user['callStatus'] == 'missed'
                              ? Icons.call_received
                              : user['callStatus'] == 'outgoing'
                              ? Icons.call_made
                              : Icons.call_received,

                          color: user['callStatus'] == 'missed'
                              ? Colors.red
                              : const Color(0xFF25D366),

                          size: 18,
                        ),

                        const SizedBox(width: 5),

                        Expanded(
                          child: Text(
                            user['callStatus'],

                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),

                    /// CALL TYPE
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) => CallingScreen(
                              user: user,

                              isVideoCall: user['callType'] == 'video',
                            ),
                          ),
                        );
                      },

                      icon: Icon(
                        user['callType'] == 'video'
                            ? Icons.videocam_outlined
                            : Icons.call_outlined,

                        color: const Color(0xFF25D366),

                        size: 28,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
