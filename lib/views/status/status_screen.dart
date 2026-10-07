import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/chat/users_list.dart';
import 'package:whatsapp_clone/views/status/status_view.dart';

class StatusSCreen extends StatefulWidget {
  const StatusSCreen({super.key});

  @override
  State<StatusSCreen> createState() => _StatusSCreenState();
}

class _StatusSCreenState extends State<StatusSCreen> {
  final UserList userList = UserList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          /// MY STATUS
          Container(
            child: ListTile(
              leading: Stack(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,

                    child: Container(
                      padding: const EdgeInsets.all(2),

                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              title: const Text(
                'My Status',

                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: const Text(
                'Tap to add status update',

                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// RECENT UPDATES
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            child: Text(
              'Recent updates',

              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),

          ...List.generate(userList.usersList.length, (index) {
            final user = userList.usersList[index];

            return Container(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(2),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF25D366),
                      width: 3,
                    ),
                  ),

                  child: CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(user['imageURL']),
                  ),
                ),

                title: Text(
                  user['name'],

                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                subtitle: Text(
                  user['time'],
                  style: const TextStyle(color: Colors.grey),
                ),

                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) => StatusViewScreen(user: user),
                    ),
                  );
                },
              ),
            );
          }),

          const SizedBox(height: 10),

          /// VIEWED UPDATES
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            child: Text(
              'Viewed updates',

              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),

          ...List.generate(3, (index) {
            final user = userList.usersList[index];

            return Container(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(2),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 3),
                  ),

                  child: CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(user['imageURL']),
                  ),
                ),

                title: Text(
                  user['name'],

                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                subtitle: const Text(
                  'Yesterday, 8:30 PM',

                  style: TextStyle(color: Colors.grey),
                ),

                onTap: () {},
              ),
            );
          }),

          const SizedBox(height: 80),
        ],
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          FloatingActionButton.small(
            heroTag: 'status_edit_fab',
            backgroundColor: const Color(0xFF202C33),

            onPressed: () {},

            child: const Icon(Icons.edit, color: Colors.white),
          ),

          const SizedBox(height: 15),

          FloatingActionButton(
            heroTag: 'status_camera_fab',
            backgroundColor: const Color(0xFF25D366),

            onPressed: () {},

            child: const Icon(Icons.camera_alt, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
