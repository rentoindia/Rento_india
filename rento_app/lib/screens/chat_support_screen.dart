// // // import '../widgets/bottom_nav_bar.dart';
// // // import '../widgets/nav_helper.dart';
// // // import 'package:flutter/material.dart';

// // // class ChatSupportScreen extends StatefulWidget {
// // //   const ChatSupportScreen({super.key});

// // //   @override
// // //   State<ChatSupportScreen> createState() => _ChatSupportScreenState();
// // // }

// // // class _ChatSupportScreenState extends State<ChatSupportScreen> {
// // //   final _messageController = TextEditingController();
// // //   final List<Map<String, dynamic>> _messages = [
// // //     {
// // //       'fromBot': true,
// // //       'text': 'Hello! 👋\nI\'m here to help you. What can I assist you with today?',
// // //     },
// // //   ];

// // //   void _sendMessage() {
// // //     final text = _messageController.text.trim();
// // //     if (text.isEmpty) return;
// // //     setState(() {
// // //       _messages.add({'fromBot': false, 'text': text});
// // //       _messages.add({
// // //         'fromBot': true,
// // //         'text': 'Thanks for reaching out! Our support team will get back to you shortly.',
// // //       });
// // //     });
// // //     _messageController.clear();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _messageController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Chat Support'),
// // //         // FIX: this is a main bottom-nav tab, not a pushed sub-page —
// // //         // it shouldn't show a back arrow.
// // //         automaticallyImplyLeading: false,
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Expanded(
// // //             child: ListView.builder(
// // //               padding: const EdgeInsets.all(16),
// // //               itemCount: _messages.length,
// // //               itemBuilder: (context, i) {
// // //                 final msg = _messages[i];
// // //                 final fromBot = msg['fromBot'] as bool;
// // //                 return Align(
// // //                   alignment: fromBot ? Alignment.centerLeft : Alignment.centerRight,
// // //                   child: Container(
// // //                     margin: const EdgeInsets.only(bottom: 10),
// // //                     padding: const EdgeInsets.all(12),
// // //                     constraints: BoxConstraints(
// // //                         maxWidth: MediaQuery.of(context).size.width * 0.75),
// // //                     decoration: BoxDecoration(
// // //                       color: fromBot ? const Color(0xFFF3F4F6) : Colors.black,
// // //                       borderRadius: BorderRadius.circular(14),
// // //                     ),
// // //                     child: Text(
// // //                       msg['text'] as String,
// // //                       style: TextStyle(
// // //                         color: fromBot ? Colors.black87 : Colors.white,
// // //                         fontSize: 13,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //           SafeArea(
// // //             top: false,
// // //             child: Padding(
// // //               padding: const EdgeInsets.all(12),
// // //               child: Row(
// // //                 children: [
// // //                   Expanded(
// // //                     child: TextField(
// // //                       controller: _messageController,
// // //                       decoration: InputDecoration(
// // //                         hintText: 'Type a message...',
// // //                         filled: true,
// // //                         fillColor: const Color(0xFFF3F4F6),
// // //                         contentPadding:
// // //                             const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //                         border: OutlineInputBorder(
// // //                           borderRadius: BorderRadius.circular(30),
// // //                           borderSide: BorderSide.none,
// // //                         ),
// // //                       ),
// // //                       onSubmitted: (_) => _sendMessage(),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(width: 8),
// // //                   CircleAvatar(
// // //                     backgroundColor: Colors.black,
// // //                     child: IconButton(
// // //                       icon: const Icon(Icons.send, color: Colors.white, size: 18),
// // //                       onPressed: _sendMessage,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       bottomNavigationBar: RentoBottomNavBar(
// // //         currentIndex: 3,
// // //         onTap: (i) => navigateToTab(context, i),
// // //       ),
// // //     );
// // //   }
// // // }

























// // import 'package:flutter/material.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // import '../widgets/bottom_nav_bar.dart';
// // import '../widgets/nav_helper.dart';

// // class ChatSupportScreen extends StatefulWidget {
// //   const ChatSupportScreen({super.key});

// //   @override
// //   State<ChatSupportScreen> createState() => _ChatSupportScreenState();
// // }

// // class _ChatSupportScreenState extends State<ChatSupportScreen> {
// //   final _messageController = TextEditingController();
// //   final _scrollController = ScrollController();
// //   final stt.SpeechToText _speech = stt.SpeechToText();

// //   bool _speechAvailable = false;
// //   bool _isListening = false;

// //   final List<Map<String, dynamic>> _messages = [
// //     {
// //       'fromBot': true,
// //       'text': 'Hello! 👋\nI\'m RentoBot, your AI assistant. Ask me about orders, '
// //           'payments, rentals, or listing your own products — I\'m here to help.',
// //     },
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initSpeech();
// //   }

// //   Future<void> _initSpeech() async {
// //     _speechAvailable = await _speech.initialize(
// //       onStatus: (status) {
// //         if (status == 'done' || status == 'notListening') {
// //           if (mounted) setState(() => _isListening = false);
// //         }
// //       },
// //       onError: (error) {
// //         if (mounted) setState(() => _isListening = false);
// //       },
// //     );
// //     if (mounted) setState(() {});
// //   }

// //   Future<void> _toggleListening() async {
// //     if (!_speechAvailable) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Speech recognition isn\'t available on this device')),
// //       );
// //       return;
// //     }

// //     if (_isListening) {
// //       await _speech.stop();
// //       setState(() => _isListening = false);
// //       return;
// //     }

// //     setState(() => _isListening = true);
// //     await _speech.listen(
// //       onResult: (result) {
// //         setState(() {
// //           _messageController.text = result.recognizedWords;
// //           _messageController.selection = TextSelection.fromPosition(
// //             TextPosition(offset: _messageController.text.length),
// //           );
// //         });
// //         // Auto-send once the recognizer considers the phrase final.
// //         if (result.finalResult && result.recognizedWords.trim().isNotEmpty) {
// //           _sendMessage();
// //         }
// //       },
// //       listenFor: const Duration(seconds: 30),
// //       pauseFor: const Duration(seconds: 3),
// //     );
// //   }

// //   void _sendMessage() {
// //     final text = _messageController.text.trim();
// //     if (text.isEmpty) return;

// //     setState(() {
// //       _messages.add({'fromBot': false, 'text': text});
// //       _messages.add({'fromBot': true, 'text': _generateBotReply(text)});
// //     });
// //     _messageController.clear();

// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       if (_scrollController.hasClients) {
// //         _scrollController.animateTo(
// //           _scrollController.position.maxScrollExtent,
// //           duration: const Duration(milliseconds: 250),
// //           curve: Curves.easeOut,
// //         );
// //       }
// //     });
// //   }

// //   // A lightweight, rule-based reply generator — RentoBot recognizes a
// //   // handful of common intents and responds accordingly, instead of
// //   // always giving the exact same canned line regardless of what was
// //   // asked. This still isn't a real language model; wire this up to an
// //   // actual AI API (e.g. Anthropic's Messages API) if you want genuinely
// //   // open-ended understanding instead of keyword matching.
// //   String _generateBotReply(String userText) {
// //     final text = userText.toLowerCase();

// //     if (text.contains('order') || text.contains('track')) {
// //       return 'You can track all your orders anytime from the Orders tab. '
// //           'Want me to open it for you?';
// //     }
// //     if (text.contains('refund') || text.contains('deposit')) {
// //       return 'Security deposits are refunded to your Rento Wallet within '
// //           '2–3 business days after the product is returned and inspected.';
// //     }
// //     if (text.contains('payment') || text.contains('pay')) {
// //       return 'We accept UPI, cards, net banking, and Rento Wallet balance. '
// //           'Payments are processed securely via Razorpay.';
// //     }
// //     if (text.contains('cancel')) {
// //       return 'You can cancel an order from the Orders tab before it\'s '
// //           'out for delivery. After that, please contact us and we\'ll help '
// //           'sort it out.';
// //     }
// //     if (text.contains('list') || text.contains('rent out') || text.contains('sell')) {
// //       return 'Want to earn by lending your own products? Head to the '
// //           '"Post" tab to verify your identity and list your first item.';
// //     }
// //     if (text.contains('delivery') || text.contains('rider')) {
// //       return 'Once your order is confirmed, a rider is assigned automatically '
// //           'and you can track them live on the map from your order details.';
// //     }
// //     if (text.contains('hello') || text.contains('hi') || text.contains('hey')) {
// //       return 'Hey there! What would you like help with today?';
// //     }
// //     if (text.contains('thank')) {
// //       return 'You\'re welcome! Let me know if anything else comes up. 😊';
// //     }

// //     return 'Got it — thanks for reaching out! For anything I can\'t answer '
// //         'directly, our support team will follow up with you shortly.';
// //   }

// //   @override
// //   void dispose() {
// //     _messageController.dispose();
// //     _scrollController.dispose();
// //     _speech.stop();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('RentoBot'),
// //         automaticallyImplyLeading: false,
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: ListView.builder(
// //               controller: _scrollController,
// //               padding: const EdgeInsets.all(16),
// //               itemCount: _messages.length,
// //               itemBuilder: (context, i) {
// //                 final msg = _messages[i];
// //                 final fromBot = msg['fromBot'] as bool;
// //                 return Align(
// //                   alignment: fromBot ? Alignment.centerLeft : Alignment.centerRight,
// //                   child: Container(
// //                     margin: const EdgeInsets.only(bottom: 10),
// //                     padding: const EdgeInsets.all(12),
// //                     constraints: BoxConstraints(
// //                         maxWidth: MediaQuery.of(context).size.width * 0.75),
// //                     decoration: BoxDecoration(
// //                       color: fromBot ? const Color(0xFFF3F4F6) : Colors.black,
// //                       borderRadius: BorderRadius.circular(14),
// //                     ),
// //                     child: Text(
// //                       msg['text'] as String,
// //                       style: TextStyle(
// //                         color: fromBot ? Colors.black87 : Colors.white,
// //                         fontSize: 13,
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),

// //           // Shows a live "Listening..." strip while the mic is active.
// //           if (_isListening)
// //             Container(
// //               width: double.infinity,
// //               padding: const EdgeInsets.symmetric(vertical: 6),
// //               color: const Color(0xFFFFF3E0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   const Icon(Icons.mic, size: 14, color: Colors.deepOrange),
// //                   const SizedBox(width: 6),
// //                   Text('Listening...',
// //                       style: TextStyle(color: Colors.deepOrange.shade700, fontSize: 12)),
// //                 ],
// //               ),
// //             ),

// //           SafeArea(
// //             top: false,
// //             child: Padding(
// //               padding: const EdgeInsets.all(12),
// //               child: Row(
// //                 children: [
// //                   // Mic button — tap to start/stop voice input.
// //                   GestureDetector(
// //                     onTap: _toggleListening,
// //                     child: CircleAvatar(
// //                       backgroundColor:
// //                           _isListening ? Colors.redAccent : const Color(0xFFF3F4F6),
// //                       child: Icon(
// //                         _isListening ? Icons.mic : Icons.mic_none,
// //                         color: _isListening ? Colors.white : Colors.black87,
// //                         size: 20,
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 8),
// //                   Expanded(
// //                     child: TextField(
// //                       controller: _messageController,
// //                       decoration: InputDecoration(
// //                         hintText: _isListening ? 'Listening...' : 'Type a message...',
// //                         filled: true,
// //                         fillColor: const Color(0xFFF3F4F6),
// //                         contentPadding:
// //                             const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(30),
// //                           borderSide: BorderSide.none,
// //                         ),
// //                       ),
// //                       onSubmitted: (_) => _sendMessage(),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 8),
// //                   CircleAvatar(
// //                     backgroundColor: Colors.black,
// //                     child: IconButton(
// //                       icon: const Icon(Icons.send, color: Colors.white, size: 18),
// //                       onPressed: _sendMessage,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       bottomNavigationBar: RentoBottomNavBar(
// //         currentIndex: 3,
// //         onTap: (i) => navigateToTab(context, i),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import '../widgets/bottom_nav_bar.dart';
// import '../widgets/nav_helper.dart';

// class ChatSupportScreen extends StatefulWidget {
//   const ChatSupportScreen({super.key});

//   @override
//   State<ChatSupportScreen> createState() => _ChatSupportScreenState();
// }

// class _ChatSupportScreenState extends State<ChatSupportScreen> {
//   final _messageController = TextEditingController();
//   final _scrollController = ScrollController();
//   final stt.SpeechToText _speech = stt.SpeechToText();

//   bool _speechAvailable = false;
//   bool _isListening = false;

//   final List<Map<String, dynamic>> _messages = [
//     {
//       'fromBot': true,
//       'text': 'Hello! 👋\nI\'m RentoBot, your AI assistant. Ask me about orders, '
//           'payments, rentals, or listing your own products — I\'m here to help.',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//   }

//   Future<void> _initSpeech() async {
//     _speechAvailable = await _speech.initialize(
//       onStatus: (status) {
//         if (status == 'done' || status == 'notListening') {
//           if (mounted) setState(() => _isListening = false);
//         }
//       },
//       onError: (error) {
//         if (mounted) setState(() => _isListening = false);
//       },
//     );
//     if (mounted) setState(() {});
//   }

//   Future<void> _toggleListening() async {
//     if (!_speechAvailable) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Speech recognition isn\'t available on this device')),
//       );
//       return;
//     }

//     if (_isListening) {
//       await _speech.stop();
//       setState(() => _isListening = false);
//       return;
//     }

//     setState(() => _isListening = true);
//     await _speech.listen(
//       onResult: (result) {
//         setState(() {
//           _messageController.text = result.recognizedWords;
//           _messageController.selection = TextSelection.fromPosition(
//             TextPosition(offset: _messageController.text.length),
//           );
//         });
//         // Auto-send once the recognizer considers the phrase final.
//         if (result.finalResult && result.recognizedWords.trim().isNotEmpty) {
//           _sendMessage();
//         }
//       },
//       listenFor: const Duration(seconds: 30),
//       pauseFor: const Duration(seconds: 3),
//     );
//   }

//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     setState(() {
//       _messages.add({'fromBot': false, 'text': text});
//       _messages.add({'fromBot': true, 'text': _generateBotReply(text)});
//     });
//     _messageController.clear();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 250),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   // A lightweight, rule-based reply generator — RentoBot recognizes a
//   // handful of common intents and responds accordingly, instead of
//   // always giving the exact same canned line regardless of what was
//   // asked. This still isn't a real language model; wire this up to an
//   // actual AI API (e.g. Anthropic's Messages API) if you want genuinely
//   // open-ended understanding instead of keyword matching.
//   String _generateBotReply(String userText) {
//     final text = userText.toLowerCase();

//     if (text.contains('order') || text.contains('track')) {
//       return 'You can track all your orders anytime from the Orders tab. '
//           'Want me to open it for you?';
//     }
//     if (text.contains('refund') || text.contains('deposit')) {
//       return 'Security deposits are refunded to your Rento Wallet within '
//           '2–3 business days after the product is returned and inspected.';
//     }
//     if (text.contains('payment') || text.contains('pay')) {
//       return 'We accept UPI, cards, net banking, and Rento Wallet balance. '
//           'Payments are processed securely via Razorpay.';
//     }
//     if (text.contains('cancel')) {
//       return 'You can cancel an order from the Orders tab before it\'s '
//           'out for delivery. After that, please contact us and we\'ll help '
//           'sort it out.';
//     }
//     if (text.contains('list') || text.contains('rent out') || text.contains('sell')) {
//       return 'Want to earn by lending your own products? Head to the '
//           '"Post" tab to verify your identity and list your first item.';
//     }
//     if (text.contains('delivery') || text.contains('rider')) {
//       return 'Once your order is confirmed, a rider is assigned automatically '
//           'and you can track them live on the map from your order details.';
//     }
//     if (text.contains('hello') || text.contains('hi') || text.contains('hey')) {
//       return 'Hey there! What would you like help with today?';
//     }
//     if (text.contains('thank')) {
//       return 'You\'re welcome! Let me know if anything else comes up. 😊';
//     }

//     return 'Got it — thanks for reaching out! For anything I can\'t answer '
//         'directly, our support team will follow up with you shortly.';
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _scrollController.dispose();
//     _speech.stop();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('RentoBot'),
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               controller: _scrollController,
//               padding: const EdgeInsets.all(16),
//               itemCount: _messages.length,
//               itemBuilder: (context, i) {
//                 final msg = _messages[i];
//                 final fromBot = msg['fromBot'] as bool;
//                 return Align(
//                   alignment: fromBot ? Alignment.centerLeft : Alignment.centerRight,
//                   child: Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     padding: const EdgeInsets.all(12),
//                     constraints: BoxConstraints(
//                         maxWidth: MediaQuery.of(context).size.width * 0.75),
//                     decoration: BoxDecoration(
//                       color: fromBot ? const Color(0xFFF3F4F6) : Colors.black,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Text(
//                       msg['text'] as String,
//                       style: TextStyle(
//                         color: fromBot ? Colors.black87 : Colors.white,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Shows a live "Listening..." strip while the mic is active.
//           if (_isListening)
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 6),
//               color: const Color(0xFFFFF3E0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.mic, size: 14, color: Colors.deepOrange),
//                   const SizedBox(width: 6),
//                   Text('Listening...',
//                       style: TextStyle(color: Colors.deepOrange.shade700, fontSize: 12)),
//                 ],
//               ),
//             ),

//           SafeArea(
//             top: false,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 children: [
//                   // Mic button — tap to start/stop voice input.
//                   GestureDetector(
//                     onTap: _toggleListening,
//                     child: CircleAvatar(
//                       backgroundColor:
//                           _isListening ? Colors.redAccent : const Color(0xFFF3F4F6),
//                       child: Icon(
//                         _isListening ? Icons.mic : Icons.mic_none,
//                         color: _isListening ? Colors.white : Colors.black87,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         hintText: _isListening ? 'Listening...' : 'Type a message...',
//                         filled: true,
//                         fillColor: const Color(0xFFF3F4F6),
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       onSubmitted: (_) => _sendMessage(),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   CircleAvatar(
//                     backgroundColor: Colors.black,
//                     child: IconButton(
//                       icon: const Icon(Icons.send, color: Colors.white, size: 18),
//                       onPressed: _sendMessage,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: RentoBottomNavBar(
//         currentIndex: 3,
//         onTap: (i) => navigateToTab(context, i),
//       ),
//     );
//   }
// }


// import '../widgets/bottom_nav_bar.dart';
// import '../widgets/nav_helper.dart';
// import 'package:flutter/material.dart';

// class ChatSupportScreen extends StatefulWidget {
//   const ChatSupportScreen({super.key});

//   @override
//   State<ChatSupportScreen> createState() => _ChatSupportScreenState();
// }

// class _ChatSupportScreenState extends State<ChatSupportScreen> {
//   final _messageController = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [
//     {
//       'fromBot': true,
//       'text': 'Hello! 👋\nI\'m here to help you. What can I assist you with today?',
//     },
//   ];

//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;
//     setState(() {
//       _messages.add({'fromBot': false, 'text': text});
//       _messages.add({
//         'fromBot': true,
//         'text': 'Thanks for reaching out! Our support team will get back to you shortly.',
//       });
//     });
//     _messageController.clear();
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat Support'),
//         // FIX: this is a main bottom-nav tab, not a pushed sub-page —
//         // it shouldn't show a back arrow.
//         automaticallyImplyLeading: false,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: _messages.length,
//               itemBuilder: (context, i) {
//                 final msg = _messages[i];
//                 final fromBot = msg['fromBot'] as bool;
//                 return Align(
//                   alignment: fromBot ? Alignment.centerLeft : Alignment.centerRight,
//                   child: Container(
//                     margin: const EdgeInsets.only(bottom: 10),
//                     padding: const EdgeInsets.all(12),
//                     constraints: BoxConstraints(
//                         maxWidth: MediaQuery.of(context).size.width * 0.75),
//                     decoration: BoxDecoration(
//                       color: fromBot ? const Color(0xFFF3F4F6) : Colors.black,
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Text(
//                       msg['text'] as String,
//                       style: TextStyle(
//                         color: fromBot ? Colors.black87 : Colors.white,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SafeArea(
//             top: false,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message...',
//                         filled: true,
//                         fillColor: const Color(0xFFF3F4F6),
//                         contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       onSubmitted: (_) => _sendMessage(),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   CircleAvatar(
//                     backgroundColor: Colors.black,
//                     child: IconButton(
//                       icon: const Icon(Icons.send, color: Colors.white, size: 18),
//                       onPressed: _sendMessage,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: RentoBottomNavBar(
//         currentIndex: 3,
//         onTap: (i) => navigateToTab(context, i),
//       ),
//     );
//   }
// }

























import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../widgets/bottom_nav_bar.dart';
import '../widgets/nav_helper.dart';

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({super.key});

  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool _speechAvailable = false;
  bool _isListening = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'fromBot': true,
      'text': 'Hello! 👋\nI\'m RentoBot, your AI assistant. Ask me about orders, '
          'payments, rentals, or listing your own products — I\'m here to help.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          if (mounted) setState(() => _isListening = false);
        }
      },
      onError: (error) {
        if (mounted) setState(() => _isListening = false);
      },
    );
    if (mounted) setState(() {});
  }

  Future<void> _toggleListening() async {
    if (!_speechAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Speech recognition isn\'t available on this device')),
      );
      return;
    }

    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      return;
    }

    setState(() => _isListening = true);
    await _speech.listen(
      onResult: (result) {
        setState(() {
          _messageController.text = result.recognizedWords;
          _messageController.selection = TextSelection.fromPosition(
            TextPosition(offset: _messageController.text.length),
          );
        });
        // Auto-send once the recognizer considers the phrase final.
        if (result.finalResult && result.recognizedWords.trim().isNotEmpty) {
          _sendMessage();
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'fromBot': false, 'text': text});
      _messages.add({'fromBot': true, 'text': _generateBotReply(text)});
    });
    _messageController.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // A lightweight, rule-based reply generator — RentoBot recognizes a
  // handful of common intents and responds accordingly, instead of
  // always giving the exact same canned line regardless of what was
  // asked. This still isn't a real language model; wire this up to an
  // actual AI API (e.g. Anthropic's Messages API) if you want genuinely
  // open-ended understanding instead of keyword matching.
  String _generateBotReply(String userText) {
    final text = userText.toLowerCase();

    if (text.contains('order') || text.contains('track')) {
      return 'You can track all your orders anytime from the Orders tab. '
          'Want me to open it for you?';
    }
    if (text.contains('refund') || text.contains('deposit')) {
      return 'Security deposits are refunded to your Rento Wallet within '
          '2–3 business days after the product is returned and inspected.';
    }
    if (text.contains('payment') || text.contains('pay')) {
      return 'We accept UPI, cards, net banking, and Rento Wallet balance. '
          'Payments are processed securely via Razorpay.';
    }
    if (text.contains('cancel')) {
      return 'You can cancel an order from the Orders tab before it\'s '
          'out for delivery. After that, please contact us and we\'ll help '
          'sort it out.';
    }
    if (text.contains('list') || text.contains('rent out') || text.contains('sell')) {
      return 'Want to earn by lending your own products? Head to the '
          '"Post" tab to verify your identity and list your first item.';
    }
    if (text.contains('delivery') || text.contains('rider')) {
      return 'Once your order is confirmed, a rider is assigned automatically '
          'and you can track them live on the map from your order details.';
    }
    if (text.contains('hello') || text.contains('hi') || text.contains('hey')) {
      return 'Hey there! What would you like help with today?';
    }
    if (text.contains('thank')) {
      return 'You\'re welcome! Let me know if anything else comes up. 😊';
    }

    return 'Got it — thanks for reaching out! For anything I can\'t answer '
        'directly, our support team will follow up with you shortly.';
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RentoBot'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final msg = _messages[i];
                final fromBot = msg['fromBot'] as bool;
                return Align(
                  alignment: fromBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: fromBot ? const Color(0xFFF3F4F6) : Colors.black,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      msg['text'] as String,
                      style: TextStyle(
                        color: fromBot ? Colors.black87 : Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Shows a live "Listening..." strip while the mic is active.
          if (_isListening)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: const Color(0xFFFFF3E0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mic, size: 14, color: Colors.deepOrange),
                  const SizedBox(width: 6),
                  Text('Listening...',
                      style: TextStyle(color: Colors.deepOrange.shade700, fontSize: 12)),
                ],
              ),
            ),

          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Mic button — tap to start/stop voice input.
                  GestureDetector(
                    onTap: _toggleListening,
                    child: CircleAvatar(
                      backgroundColor:
                          _isListening ? Colors.redAccent : const Color(0xFFF3F4F6),
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: _isListening ? Colors.white : Colors.black87,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: _isListening ? 'Listening...' : 'Type a message...',
                        filled: true,
                        fillColor: const Color(0xFFF3F4F6),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: RentoBottomNavBar(
        currentIndex: 1,
        onTap: (i) => navigateToTab(context, i),
      ),
    );
  }
}