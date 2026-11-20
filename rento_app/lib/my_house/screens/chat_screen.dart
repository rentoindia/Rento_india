import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String bhkType;
  final String city;
  final String locality;

  const ChatScreen({
    super.key,
    this.bhkType = '2 BHK',
    this.city = 'Chennai',
    this.locality = 'Anna Nagar',
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hi, is the property still available?',
      'fromMe': false,
      'time': '10:02 AM',
      'status': null,
    },
    {
      'text': 'Yes, it is available.',
      'fromMe': true,
      'time': '10:03 AM',
      'status': 'Delivered',
    },
    {
      'text': 'Can we schedule a visit tomorrow?',
      'fromMe': false,
      'time': '10:05 AM',
      'status': null,
    },
    {
      'text': 'Sure, please select a time slot.',
      'fromMe': true,
      'time': '10:06 AM',
      'status': 'Delivered',
    },
  ];

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add({
        'text': text,
        'fromMe': true,
        'time': 'Now',
        'status': 'Delivered',
      });
      messageController.clear();
    });
  }

  Widget _avatar(bool fromMe) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: fromMe ? const Color(0xFF1A1A1A) : const Color(0xFFE0E0E0),
      child: Icon(
        Icons.person,
        size: 18,
        color: fromMe ? Colors.white : const Color(0xFF1A1A1A),
      ),
    );
  }

  Widget _messageBubble(Map<String, dynamic> msg) {
    final bool fromMe = msg['fromMe'];
    final String text = msg['text'];
    final String time = msg['time'] ?? '';
    final String? status = msg['status'];

    final bubble = Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      constraints: const BoxConstraints(maxWidth: 230),
      decoration: BoxDecoration(
        color: fromMe ? const Color(0xFF1A1A1A) : Colors.white,
        border: fromMe ? null : Border.all(color: const Color(0xFFDADADA)),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(14),
          topRight: const Radius.circular(14),
          bottomLeft: Radius.circular(fromMe ? 14 : 2),
          bottomRight: Radius.circular(fromMe ? 2 : 14),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: fromMe ? Colors.white : const Color(0xFF1A1A1A),
          height: 1.4,
        ),
      ),
    );

    final nameLabel = Text(
      fromMe ? 'You' : 'Mr. Ramesh Kumar',
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1A1A1A),
      ),
    );

    final timeLabel = Text(
      time,
      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
    );

    final content = Column(
      crossAxisAlignment: fromMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: fromMe
              ? [timeLabel, const SizedBox(width: 6), nameLabel]
              : [nameLabel, const SizedBox(width: 6), timeLabel],
        ),
        bubble,
        if (status != null)
          Padding(
            padding: const EdgeInsets.only(top: 3, right: 2),
            child: Text(
              status,
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            ),
          ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: fromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fromMe
            ? [
                Flexible(child: content),
                const SizedBox(width: 8),
                _avatar(true),
              ]
            : [
                _avatar(false),
                const SizedBox(width: 8),
                Flexible(child: content),
              ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFE0E0E0),
              child: Icon(Icons.person, color: Color(0xFF1A1A1A)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Mr. Ramesh Kumar',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1A1A1A)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) => _messageBubble(messages[index]),
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
              ),
              child: Row(
                children: [
                  Icon(Icons.attach_file, color: Colors.grey[600], size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Message',
                          hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A1A)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
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
    );
  }
}