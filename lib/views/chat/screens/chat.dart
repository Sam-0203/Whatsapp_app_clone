import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/chat/screens/inner_chat.dart';
import 'package:whatsapp_clone/views/chat/users_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final UserList userList = UserList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userList.usersList.length,

      itemBuilder: (context, index) {
        final user = userList.usersList[index];

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => InnerChat(user: user)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),

            leading: GestureDetector(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: "Profile",
                  barrierColor: Colors.black.withOpacity(0.8),

                  transitionDuration: const Duration(milliseconds: 300),

                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Center(
                      child: Material(
                        color: Colors.transparent,

                        child: Container(
                          width: 300,
                          height: 380,

                          decoration: BoxDecoration(
                            color: const Color(0xFF111B21),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Column(
                            children: [
                              /// IMAGE + NAME
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),

                                    child: Image.network(
                                      user['imageURL'],
                                      height: 300,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Text(
                                      user['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              /// ICONS
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,

                                  children: const [
                                    Icon(
                                      Icons.message_outlined,
                                      color: Color(0xFF25D366),
                                      size: 30,
                                    ),

                                    Icon(
                                      Icons.info_outline,
                                      color: Color(0xFF25D366),
                                      size: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },

                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,

                          child: ScaleTransition(
                            scale: Tween<double>(begin: 0.4, end: 1).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              ),
                            ),

                            child: child,
                          ),
                        );
                      },
                );
              },
              child: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(user['imageURL']),
              ),
            ),

            title: Text(
              user['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            subtitle: Row(
              children: [
                Icon(
                  user['isRead'] ? Icons.done_all : Icons.done,
                  size: 18,
                  color: user['isRead'] ? Colors.blue : Colors.grey,
                ),

                const SizedBox(width: 5),

                Expanded(
                  child: Text(
                    user['message'],
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),

            trailing: Text(
              user['time'],
              style: TextStyle(
                color: user['isRead'] ? Colors.grey : const Color(0xFF25D366),

                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
