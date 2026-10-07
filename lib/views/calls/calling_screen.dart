import 'package:flutter/material.dart';

class CallingScreen extends StatelessWidget {
  final Map<String, dynamic> user;
  final bool isVideoCall;

  const CallingScreen({
    super.key,
    required this.user,
    required this.isVideoCall,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        fit: StackFit.expand,

        children: [
          /// BACKGROUND IMAGE
          Image.network(user['imageURL'], fit: BoxFit.cover),

          Container(color: Colors.black.withOpacity(0.55)),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),

                /// PROFILE
                CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(user['imageURL']),
                ),

                const SizedBox(height: 20),

                Text(
                  user['name'],

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  isVideoCall ? 'Video calling...' : 'Calling...',

                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),

                const Spacer(),

                /// CALL ACTIONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    _callButton(icon: Icons.mic_off, color: Colors.white24),

                    _callButton(icon: Icons.volume_up, color: Colors.white24),

                    _callButton(
                      icon: isVideoCall ? Icons.videocam : Icons.call,

                      color: const Color(0xFF25D366),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                /// END CALL
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Container(
                    width: 75,
                    height: 75,

                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 38,
                    ),
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _callButton({required IconData icon, required Color color}) {
    return Container(
      width: 60,
      height: 60,

      decoration: BoxDecoration(color: color, shape: BoxShape.circle),

      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
