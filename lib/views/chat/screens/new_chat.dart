import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/chat/users_list.dart';

class NewChats extends StatefulWidget {
  const NewChats({super.key});

  @override
  State<NewChats> createState() => _NewChatsState();
}

class _NewChatsState extends State<NewChats> {
  final UserList userList = UserList();

  Widget _topTile({
    required IconData icon,
    required String title,
    Widget? trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),

      leading: CircleAvatar(
        radius: 28,
        backgroundColor: const Color(0xFF25D366),

        child: Icon(icon, color: Colors.black, size: 30),
      ),

      title: Text(
        title,

        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),

      trailing: trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = userList.usersList.length;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        titleSpacing: 0,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Select contact',

              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              '$user contacts',

              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white, size: 28),
          ),
        ],
      ),

      body: ListView(
        children: [
          const Divider(color: Colors.white12, height: 1),

          const SizedBox(height: 10),

          // NEW GROUP
          _topTile(icon: Icons.group_add, title: 'New group'),
          const SizedBox(height: 5),

          // NEW CONTACT
          _topTile(
            icon: Icons.person_add_alt_1,
            title: 'New contact',
            trailing: const Icon(Icons.qr_code, color: Colors.white),
          ),
          const SizedBox(height: 5),

          // NEW COMMUNITY
          _topTile(icon: Icons.groups, title: 'New community'),

          const SizedBox(height: 20),

          // CONTACTS TEXT
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),

            child: Text(
              'Contacts on WhatsApp',

              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// CONTACT LIST
          ...List.generate(userList.usersList.length, (index) {
            final user = userList.usersList[index];

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),

              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(user['imageURL']),
              ),

              title: Text(
                user['name'],

                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),

              subtitle: Text(
                user['status'],

                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),

              onTap: () {},
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
