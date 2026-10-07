import 'package:flutter/material.dart';

class StatusViewScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final List<Map<String, dynamic>>? statuses;

  const StatusViewScreen({super.key, required this.user, this.statuses});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen>
    with SingleTickerProviderStateMixin {
  static const Duration _statusDuration = Duration(seconds: 5);

  late List<Map<String, dynamic>> _statuses;

  late AnimationController _controller;

  int _current = 0;

  bool _playing = true;

  @override
  void initState() {
    super.initState();

    _statuses =
        widget.statuses ??
        [
          {
            'imageURL': widget.user['imageURL'],

            'caption': widget.user['message'] ?? '',

            'time': widget.user['time'] ?? '',
          },
        ];

    _controller = AnimationController(vsync: this, duration: _statusDuration)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _next();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_current < _statuses.length - 1) {
      setState(() {
        _current++;
      });

      _controller
        ..reset()
        ..forward();
    } else {
      Navigator.pop(context);
    }
  }

  void _previous() {
    if (_current > 0) {
      setState(() {
        _current--;
      });

      _controller
        ..reset()
        ..forward();
    }
  }

  void _togglePause() {
    setState(() {
      if (_playing) {
        _controller.stop();
      } else {
        _controller.forward();
      }

      _playing = !_playing;
    });
  }

  Map<String, dynamic> get _currentStatus => _statuses[_current];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 65,

        automaticallyImplyLeading: false,

        flexibleSpace: SafeArea(
          child: Column(
            children: [
              /// LOADER ABOVE APPBAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),

                child: Row(
                  children: List.generate(_statuses.length, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),

                          child: LinearProgressIndicator(
                            value: index < _current
                                ? 1
                                : index == _current
                                ? _controller.value
                                : 0,

                            minHeight: 3,

                            backgroundColor: Colors.white24,

                            valueColor: const AlwaysStoppedAnimation(
                              Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              /// APPBAR CONTENT
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),

                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),

                      CircleAvatar(
                        radius: 20,

                        backgroundImage: NetworkImage(widget.user['imageURL']),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              widget.user['name'],

                              style: const TextStyle(
                                color: Colors.white,

                                fontSize: 16,

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Text(
                              _currentStatus['time'],

                              style: const TextStyle(
                                color: Colors.white70,

                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {},

                        icon: const Icon(Icons.more_vert, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;

          if (details.globalPosition.dx < width / 3) {
            _previous();
          } else if (details.globalPosition.dx > width * 2 / 3) {
            _next();
          } else {
            _togglePause();
          }
        },

        child: Stack(
          fit: StackFit.expand,

          children: [
            Image.network(
              _currentStatus['imageURL'],

              fit: BoxFit.cover,

              color: Colors.black.withOpacity(0.4),

              colorBlendMode: BlendMode.darken,
            ),

            Hero(
              tag: 'status_${widget.user['id']}',

              child: InteractiveViewer(
                minScale: 1,
                maxScale: 4,

                child: Image.network(
                  _currentStatus['imageURL'],

                  fit: BoxFit.cover,

                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              if ((_currentStatus['caption'] ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),

                  child: Text(
                    _currentStatus['caption'],

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      color: Colors.white,

                      fontSize: 15,

                      height: 1.5,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),

                        border: Border.all(color: Colors.white54),

                        color: Colors.black.withOpacity(0.2),
                      ),

                      child: TextField(
                        style: const TextStyle(color: Colors.white),

                        decoration: const InputDecoration(
                          hintText: 'Reply...',

                          hintStyle: TextStyle(color: Colors.white70),

                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  IconButton(
                    onPressed: () {},

                    icon: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
