import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/chat/users_list.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommuityScreeState();
}

class _CommuityScreeState extends State<CommunityScreen> {
  final UserList userList = UserList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 8,
              ),

              leading: Stack(
                children: [
                  Container(
                    width: 58,
                    height: 58,

                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: const Icon(
                      Icons.groups,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,

                    child: Container(
                      padding: const EdgeInsets.all(3),

                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Icon(
                        Icons.add,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              title: const Text(
                'New community',

                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            child: Column(
              children: [
                Divider(),

                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(18),

                    child: Image.network(
                      userList.usersList[0]['imageURL'],

                      width: 58,
                      height: 58,
                      fit: BoxFit.cover,
                    ),
                  ),

                  title: const Text(
                    'Flutter Developers',

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ListTile(
                  leading: Container(
                    width: 45,
                    height: 45,

                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Icon(Icons.campaign, color: Colors.black),
                  ),

                  title: const Text(
                    'Announcements',

                    style: TextStyle(color: Colors.white),
                  ),

                  subtitle: const Text(
                    'Welcome to Flutter Community 🚀',

                    style: TextStyle(color: Colors.grey),
                  ),

                  trailing: const Text(
                    '10:45 AM',

                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      userList.usersList[1]['imageURL'],
                    ),
                  ),

                  title: const Text(
                    'UI Designers',

                    style: TextStyle(color: Colors.white),
                  ),

                  subtitle: const Text(
                    'New Figma design uploaded',

                    style: TextStyle(color: Colors.grey),
                  ),

                  trailing: const Text(
                    'Yesterday',

                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      userList.usersList[2]['imageURL'],
                    ),
                  ),

                  title: const Text(
                    'Backend Team',

                    style: TextStyle(color: Colors.white),
                  ),

                  subtitle: const Text(
                    'API integration completed 🔥',

                    style: TextStyle(color: Colors.grey),
                  ),

                  trailing: const Text(
                    'Monday',

                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),

          const SizedBox(height: 10),
          SizedBox(
            child: Column(
              children: [
                Divider(),

                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(18),

                    child: Image.network(
                      userList.usersList[4]['imageURL'],

                      width: 58,
                      height: 58,
                      fit: BoxFit.cover,
                    ),
                  ),

                  title: const Text(
                    'Weekend Plans',

                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ListTile(
                  leading: Container(
                    width: 45,
                    height: 45,

                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: const Icon(Icons.campaign, color: Colors.black),
                  ),

                  title: const Text(
                    'Announcements',

                    style: TextStyle(color: Colors.white),
                  ),

                  subtitle: const Text(
                    'Trip starts at 6 AM 🌄',

                    style: TextStyle(color: Colors.grey),
                  ),

                  trailing: const Text(
                    '9:00 AM',

                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      userList.usersList[5]['imageURL'],
                    ),
                  ),

                  title: const Text(
                    'Goa Trip',

                    style: TextStyle(color: Colors.white),
                  ),

                  subtitle: const Text(
                    'Tickets booked successfully ✈️',

                    style: TextStyle(color: Colors.grey),
                  ),

                  trailing: const Text(
                    'Sunday',

                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),

                ListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      userList.usersList[7]['imageURL'],
                    ),
                  ),

                  title: const Text(
                    'Food Lovers',

                    style: TextStyle(color: Colors.white),
                  ),

                  subtitle: const Text(
                    'Dinner tonight? 🍕',

                    style: TextStyle(color: Colors.grey),
                  ),

                  trailing: const Text(
                    'Saturday',

                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
