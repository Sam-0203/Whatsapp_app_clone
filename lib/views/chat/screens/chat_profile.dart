import 'package:flutter/material.dart';

class ChatProfile extends StatefulWidget {
  final Map<String, dynamic> user;

  const ChatProfile({super.key, required this.user});

  @override
  State<ChatProfile> createState() => _ChatProfileState();
}

class _ChatProfileState extends State<ChatProfile> {
  bool isMuted = false;

  static const _bg = Color(0xFF111B21);
  static const _surface = Color(0xFF202C33);
  static const _green = Color(0xFF25D366);
  static const _textPrimary = Color(0xFFE9EDEF);
  static const _textMuted = Color(0xFF8696A0);
  static const _red = Color(0xFFEA4335);
  static const _orange = Color(0xFFF9AB00);

  @override
  void initState() {
    super.initState();
    isMuted = widget.user['isMuted'] ?? false;
  }

  void _showConfirmDialog({
    required String title,
    required String content,
    required String confirmText,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: _surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          title,
          style: const TextStyle(color: _textPrimary, fontSize: 16),
        ),
        content: Text(
          content,
          style: const TextStyle(color: _textMuted, fontSize: 13, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: _textMuted)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: Text(
              confirmText,
              style: TextStyle(
                color: confirmColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDeleteChat() => _showConfirmDialog(
    title: 'Delete chat',
    content:
        'Are you sure you want to delete this chat? This cannot be undone.',
    confirmText: 'Delete',
    confirmColor: _red,
    onConfirm: () {
      Navigator.popUntil(context, (r) => r.isFirst);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Chat deleted')));
    },
  );

  void _onBlockUser() => _showConfirmDialog(
    title: 'Block ${widget.user['name']}',
    content: 'Blocked contacts can no longer call you or send you messages.',
    confirmText: 'Block',
    confirmColor: _red,
    onConfirm: () => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.user['name']} has been blocked')),
    ),
  );

  void _onReportUser() => _showConfirmDialog(
    title: 'Report ${widget.user['name']}',
    content:
        'The last 5 messages from this contact will be forwarded to WhatsApp. They will not be notified.',
    confirmText: 'Report',
    confirmColor: _orange,
    onConfirm: () => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.user['name']} has been reported')),
    ),
  );

  Widget _sectionLabel(String label) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
    child: Text(
      label,
      style: const TextStyle(
        color: _green,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _infoRow({
    required IconData icon,
    required String value,
    required String subtitle,
  }) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
    leading: Icon(icon, color: _textMuted, size: 22),
    title: Text(
      value,
      style: const TextStyle(color: _textPrimary, fontSize: 15),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(color: _textMuted, fontSize: 12),
    ),
  );

  Widget _rowDivider() => const Divider(
    color: Color(0x14FFFFFF),
    thickness: 0.5,
    indent: 52,
    height: 0,
  );

  Widget _dangerTile({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) => ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    leading: Icon(icon, color: color, size: 22),
    title: Text(label, style: TextStyle(color: color, fontSize: 15)),
  );

  Widget _quickBtn(IconData icon, String label, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF2A3942),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: _green, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(color: _textMuted, fontSize: 12),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final bool isOnline = user['isOnline'] == true;
    final String lastSeenText = isOnline ? 'online' : (user['lastSeen'] ?? '');

    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero SliverAppBar ──────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: _surface,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    user['imageURL'],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: _surface,
                      child: const Icon(
                        Icons.person,
                        size: 80,
                        color: _textMuted,
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xCC000000)],
                        stops: [0.45, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 14,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            if (isOnline)
                              Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.only(right: 5),
                                decoration: const BoxDecoration(
                                  color: _green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            Text(
                              lastSeenText,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // ── Quick Actions ────────────────────────────────────────────
                Container(
                  color: _surface,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _quickBtn(Icons.call_outlined, 'Audio', () {}),
                      _quickBtn(Icons.videocam_outlined, 'Video', () {}),
                      _quickBtn(Icons.search, 'Search', () {}),
                      _quickBtn(Icons.mail_outline, 'Email', () {}),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ── About / Bio ──────────────────────────────────────────────
                Container(
                  color: _surface,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel('About'),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                        child: Text(
                          user['bio'] ?? 'Hey there! I am using WhatsApp.',
                          style: const TextStyle(
                            color: _textPrimary,
                            fontSize: 14,
                            height: 1.55,
                          ),
                        ),
                      ),
                      if (user['status'] != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _bg,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              user['status'],
                              style: const TextStyle(
                                color: _textMuted,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ── Status ───────────────────────────────────────────────────
                if (user['status'] != null)
                  Container(
                    color: _surface,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionLabel('Status'),
                        const SizedBox(height: 4),
                        Text(
                          user['status'],
                          style: const TextStyle(
                            color: _textPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 8),

                // ── Contact Info ─────────────────────────────────────────────
                Container(
                  color: _surface,
                  child: Column(
                    children: [
                      _infoRow(
                        icon: Icons.phone_outlined,
                        value: user['mobile'] ?? 'N/A',
                        subtitle: 'Mobile · Tap to call',
                      ),
                      _rowDivider(),
                      _infoRow(
                        icon: Icons.location_on_outlined,
                        value: user['location'] ?? 'Unknown',
                        subtitle: 'Location',
                      ),
                      _rowDivider(),
                      _infoRow(
                        icon: Icons.access_time,
                        value: isOnline ? 'Online' : lastSeenText,
                        subtitle: 'Last seen',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ── Media strip ──────────────────────────────────────────────
                Container(
                  color: _surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel('Media, links and docs'),
                      Row(
                        children: List.generate(
                          3,
                          (i) => Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                margin: EdgeInsets.only(right: i < 2 ? 2 : 0),
                                color: const Color(0xFF2A3942),
                                alignment: Alignment.center,
                                child: i == 2
                                    ? const Text(
                                        '+14',
                                        style: TextStyle(
                                          color: _textMuted,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {},
                        title: const Text(
                          'See all media',
                          style: TextStyle(color: _green, fontSize: 14),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: _green,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ── Mute / Wallpaper / Timer ─────────────────────────────────
                Container(
                  color: _surface,
                  child: Column(
                    children: [
                      SwitchListTile(
                        value: isMuted,
                        activeColor: _green,
                        secondary: Icon(
                          isMuted
                              ? Icons.notifications_off_outlined
                              : Icons.notifications_outlined,
                          color: _textMuted,
                        ),
                        title: const Text(
                          'Mute notifications',
                          style: TextStyle(color: _textPrimary, fontSize: 15),
                        ),
                        subtitle: Text(
                          isMuted ? 'Notifications off' : 'Notifications on',
                          style: const TextStyle(
                            color: _textMuted,
                            fontSize: 12,
                          ),
                        ),
                        onChanged: (v) => setState(() => isMuted = v),
                      ),
                      _rowDivider(),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.wallpaper, color: _textMuted),
                        title: const Text(
                          'Chat wallpaper',
                          style: TextStyle(color: _textPrimary, fontSize: 15),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: _textMuted,
                          size: 20,
                        ),
                      ),
                      _rowDivider(),
                      ListTile(
                        onTap: () {},
                        leading: const Icon(
                          Icons.timer_outlined,
                          color: _textMuted,
                        ),
                        title: const Text(
                          'Message timer',
                          style: TextStyle(color: _textPrimary, fontSize: 15),
                        ),
                        subtitle: const Text(
                          'Off',
                          style: TextStyle(color: _textMuted, fontSize: 12),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: _textMuted,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ── E2E Note ─────────────────────────────────────────────────
                Container(
                  color: _surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        color: _textMuted,
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: _textMuted,
                              fontSize: 12,
                              height: 1.4,
                            ),
                            children: [
                              const TextSpan(
                                text:
                                    'Messages and calls are end-to-end encrypted. ',
                              ),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const Text(
                                    'Learn more',
                                    style: TextStyle(
                                      color: _green,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ── Danger Zone ───────────────────────────────────────────────
                Container(
                  color: _surface,
                  child: Column(
                    children: [
                      _dangerTile(
                        icon: Icons.delete_outline,
                        label: 'Delete chat',
                        color: _red,
                        onTap: _onDeleteChat,
                      ),
                      _rowDivider(),
                      _dangerTile(
                        icon: Icons.block,
                        label: 'Block ${user['name']}',
                        color: _red,
                        onTap: _onBlockUser,
                      ),
                      _rowDivider(),
                      _dangerTile(
                        icon: Icons.flag_outlined,
                        label: 'Report ${user['name']}',
                        color: _orange,
                        onTap: _onReportUser,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
