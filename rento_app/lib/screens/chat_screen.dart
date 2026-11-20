// import 'package:flutter/material.dart';
// import '../theme/app_theme.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<Map<String, String>> _messages = [
//     {'from': 'them', 'text': 'Hi! Is the Nordic sofa still available for rent?'},
//     {'from': 'me', 'text': 'Yes! Available from tomorrow, ₹299/day.'},
//     {'from': 'them', 'text': 'Great, I will book it. Thanks!'},
//   ];

//   void _send() {
//     final text = _controller.text.trim();
//     if (text.isEmpty) return;
//     setState(() {
//       _messages.add({'from': 'me', 'text': text});
//       _controller.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F8FA),
//       appBar: AppBar(
//         title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.w700)),
//         backgroundColor: const Color(0xFFF7F8FA),
//         elevation: 0,
//         foregroundColor: AppTheme.black,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: _messages.length,
//               itemBuilder: (context, i) {
//                 final m = _messages[i];
//                 final isMe = m['from'] == 'me';
//                 return Align(
//                   alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.only(bottom: 8),
//                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                     constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
//                     decoration: BoxDecoration(
//                       color: isMe ? Colors.black : Colors.white,
//                       borderRadius: BorderRadius.circular(14),
//                       border: isMe ? null : Border.all(color: const Color(0xFFF0F0F0)),
//                     ),
//                     child: Text(
//                       m['text']!,
//                       style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 13),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message...',
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(24),
//                           borderSide: const BorderSide(color: Color(0xFFEDEDED)),
//                         ),
//                       ),
//                       onSubmitted: (_) => _send(),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   GestureDetector(
//                     onTap: _send,
//                     child: Container(
//                       width: 42,
//                       height: 42,
//                       decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
//                       child: const Icon(Icons.send, color: Colors.white, size: 18),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {'from': 'them', 'text': 'Hi! Is the Nordic sofa still available for rent?'},
    {'from': 'me', 'text': 'Yes! Available from tomorrow, ₹299/day.'},
    {'from': 'them', 'text': 'Great, I will book it. Thanks!'},
  ];

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'from': 'me', 'text': text});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFFF7F8FA),
        elevation: 0,
        foregroundColor: AppTheme.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                final isMe = m['from'] == 'me';
                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: isMe ? null : Border.all(color: const Color(0xFFF0F0F0)),
                    ),
                    child: Text(
                      m['text']!,
                      style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 13),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Color(0xFFEDEDED)),
                        ),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _send,
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                      child: const Icon(Icons.send, color: Colors.white, size: 18),
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