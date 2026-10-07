import 'package:flutter/material.dart';
import 'package:whatsapp_clone/views/calls/calling_screen.dart';
import 'package:whatsapp_clone/views/chat/screens/chat_profile.dart';

class InnerChat extends StatefulWidget {
  final Map<String, dynamic> user;

  const InnerChat({super.key, required this.user});

  @override
  State<InnerChat> createState() => _InnerChatState();
}

class _InnerChatState extends State<InnerChat> {
  @override
  Widget build(BuildContext context) {
    final List conversation = widget.user['conversation'];

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        titleSpacing: 0,

        title: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ChatProfile(user: widget.user)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(widget.user['imageURL']),
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    widget.user['name'],
                    style: const TextStyle(fontSize: 16),
                  ),

                  Text(
                    widget.user['lastSeen'],

                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8),

            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        CallingScreen(user: widget.user, isVideoCall: false),
                  ),
                );
              },

              child: const Icon(Icons.call, color: Color(0xFF25D366), size: 28),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),

            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        CallingScreen(user: widget.user, isVideoCall: true),
                  ),
                );
              },

              child: const Icon(
                Icons.videocam,
                color: Color(0xFF25D366),
                size: 30,
              ),
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: ListView.builder(
        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.all(10),

        itemCount: conversation.length,

        itemBuilder: (context, index) {
          final chat = conversation[index];

          final bool isMe = chat['is_me'];

          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,

            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),

              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),

              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF005C4B) : const Color(0xFF202C33),

                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Text(
                    chat['message'],

                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text(
                        chat['time'],

                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),

                      const SizedBox(width: 5),

                      if (isMe)
                        Icon(
                          chat['isRead'] ? Icons.done_all : Icons.done,

                          size: 16,

                          color: chat['isRead'] ? Colors.blue : Colors.grey,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          color: Colors.black,

          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Message',

                    hintStyle: const TextStyle(color: Colors.grey),

                    filled: true,

                    fillColor: const Color(0xFF202C33),

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),

                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              CircleAvatar(
                radius: 25,

                backgroundColor: const Color(0xFF25D366),

                child: IconButton(
                  onPressed: () {},

                  icon: const Icon(Icons.send, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
