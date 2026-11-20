// // // // // import 'package:flutter/material.dart';

// // // // // class RentoBottomNavBar extends StatelessWidget {
// // // // //   final int currentIndex;
// // // // //   final ValueChanged<int> onTap;

// // // // //   const RentoBottomNavBar({
// // // // //     super.key,
// // // // //     required this.currentIndex,
// // // // //     required this.onTap,
// // // // //   });

// // // // //   // One distinct color per tab — used only when that tab is active.
// // // // //   // static const List<Color> _activeColors = [
// // // // //   //   Color(0xFF2563EB), // Home — blue
// // // // //   //   Color(0xFF9333EA), // Ask SaNa — purple
// // // // //   //   Color(0xFFFF6B35), // Post — orange
// // // // //   //   Color(0xFF16A34A), // My House — green
// // // // //   //   Color(0xFFDB2777), // Profile — pink
// // // // //   // ];

// // // // // static const List<Color> _activeColors = [
// // // // //   Color(0xFF2563EB), // Home — blue
// // // // //   Color(0xFF2563EB), // Ask SaNa — blue
// // // // //   Color.fromARGB(255, 212, 21, 230), // Post — soft green
// // // // //   Color(0xFF2563EB), // My House — blue
// // // // //   Color(0xFF2563EB), // Profile — blue
// // // // // ];

// // // // //   static const List<IconData> _outlineIcons = [
// // // // //     Icons.home_outlined,
// // // // //     Icons.support_agent_outlined,
// // // // //     Icons.add_circle_outline,
// // // // //     Icons.villa_outlined,
// // // // //     Icons.person_outline,
// // // // //   ];

// // // // //   static const List<IconData> _filledIcons = [
// // // // //     Icons.home,
// // // // //     Icons.support_agent,
// // // // //     Icons.add_circle,
// // // // //     Icons.villa,
// // // // //     Icons.person,
// // // // //   ];

// // // // //   static const List<String> _labels = [
// // // // //     'Home',
// // // // //     'Ask SaNa',
// // // // //     'Post',
// // // // //     'My House',
// // // // //     'Profile',
// // // // //   ];

// // // // // // Widget _askSanaIcon(bool isActive) {
// // // // // //   if (isActive) {
// // // // // //     return Image.asset(
// // // // // //       'assets/images/ask_sana_icon.png',
// // // // // //       width: 30,
// // // // // //       height: 30,
// // // // // //       fit: BoxFit.contain,
// // // // // //     );
// // // // // //   }

// // // // // //   return ColorFiltered(
// // // // // //   colorFilter: ColorFilter.mode(
// // // // // //     Colors.grey.shade500,
// // // // // //     BlendMode.srcIn,
// // // // // //   ),
// // // // // //   child: Image.asset(
// // // // // //     'assets/images/ask_sana_icon.png',
// // // // // //     width: 30,
// // // // // //     height: 30,
// // // // // //     fit: BoxFit.contain,
// // // // // //   ),
// // // // // // );
// // // // // // }

// // // // // // Widget _askSanaIcon(bool isActive) {
// // // // // //   return ColorFiltered(
// // // // // //     colorFilter: isActive
// // // // // //         ? const ColorFilter.mode(
// // // // // //             Colors.white,
// // // // // //             BlendMode.dst,
// // // // // //           )
// // // // // //         : const ColorFilter.mode(
// // // // // //             Colors.grey,
// // // // // //             BlendMode.saturation,
// // // // // //           ),
// // // // // //     child: Image.asset(
// // // // // //       'assets/images/ask_sana_icon.png',
// // // // // //       width: 30,
// // // // // //       height: 30,
// // // // // //       fit: BoxFit.contain,
// // // // // //     ),
// // // // // //   );
// // // // // // }

// // // // // Widget _askSanaIcon(bool isActive) {
// // // // //   return Image.asset(
// // // // //     isActive
// // // // //         ? 'assets/images/rental/ask_sana_icon.png'
// // // // //         : 'assets/images/rental/ask_sana_icon_grey.png',
// // // // //     width: 30,
// // // // //     height: 30,
// // // // //     fit: BoxFit.contain,
// // // // //   );
// // // // // }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return BottomNavigationBar(
// // // // //       currentIndex: currentIndex,
// // // // //       onTap: onTap,
// // // // //       type: BottomNavigationBarType.fixed,
// // // // //       selectedItemColor: _activeColors[currentIndex],
// // // // //       unselectedItemColor: Colors.grey.shade500,
// // // // //       showUnselectedLabels: true,
// // // // //       selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
// // // // //       unselectedLabelStyle: const TextStyle(fontSize: 11),
// // // // //       items: List.generate(_labels.length, (i) {
// // // // //         final isActive = i == currentIndex;
// // // // //         return BottomNavigationBarItem(
// // // // //           // icon: Icon(
// // // // //           //   isActive ? _filledIcons[i] : _outlineIcons[i],
// // // // //           //   color: isActive ? _activeColors[i] : Colors.grey.shade500,
// // // // //           // ),
// // // // //           icon: i == 1
// // // // //     ? _askSanaIcon(isActive)
// // // // //     : Icon(
// // // // //         isActive ? _filledIcons[i] : _outlineIcons[i],
// // // // //         color: isActive
// // // // //             ? _activeColors[i]
// // // // //             : Colors.grey.shade500,
// // // // //       ),
// // // // //           label: _labels[i],
// // // // //         );
// // // // //       }),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';

// // // // class RentoBottomNavBar extends StatelessWidget {
// // // //   final int currentIndex;
// // // //   final ValueChanged<int> onTap;

// // // //   const RentoBottomNavBar({
// // // //     super.key,
// // // //     required this.currentIndex,
// // // //     required this.onTap,
// // // //   });

// // // //   // One distinct color per tab — used only when that tab is active.
// // // //   static const List<Color> _activeColors = [
// // // //     Color(0xFF2563EB), // Home — blue
// // // //     Color(0xFF2563EB), // Ask SaNa — blue
// // // //     Color.fromARGB(255, 212, 21, 230), // Post — soft green
// // // //     Color(0xFF2563EB), // My House — blue
// // // //     Color(0xFF2563EB), // Profile — blue
// // // //   ];

// // // //   static const List<IconData> _outlineIcons = [
// // // //     Icons.home_outlined,
// // // //     Icons.support_agent_outlined,
// // // //     Icons.add_circle_outline,
// // // //     Icons.villa_outlined,
// // // //     Icons.person_outline,
// // // //   ];

// // // //   static const List<IconData> _filledIcons = [
// // // //     Icons.home,
// // // //     Icons.support_agent,
// // // //     Icons.add_circle,
// // // //     Icons.villa,
// // // //     Icons.person,
// // // //   ];

// // // //   static const List<String> _labels = [
// // // //     'Home',
// // // //     'Ask SaNa',
// // // //     'Post',
// // // //     'My House',
// // // //     'Profile',
// // // //   ];

// // // //   Widget _askSanaIcon(bool isActive) {
// // // //     return Image.asset(
// // // //       isActive
// // // //           ? 'assets/images/rental/ask_sana_icon.png'
// // // //           : 'assets/images/rental/ask_sana_icon_grey.png',
// // // //       width: 26,
// // // //       height: 26,
// // // //       fit: BoxFit.contain,
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Container(
// // // //       // ---- Floating rounded card instead of a flat, edge-to-edge bar ----
// // // //       margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
// // // //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.white,
// // // //         borderRadius: BorderRadius.circular(28),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //             color: Colors.black.withOpacity(0.10),
// // // //             blurRadius: 20,
// // // //             offset: const Offset(0, 8),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       child: SafeArea(
// // // //         top: false,
// // // //         child: Row(
// // // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //           children: List.generate(_labels.length, (i) {
// // // //             final isActive = i == currentIndex;
// // // //             final activeColor = _activeColors[i];

// // // //             return Expanded(
// // // //               child: GestureDetector(
// // // //                 behavior: HitTestBehavior.opaque,
// // // //                 onTap: () => onTap(i),
// // // //                 child: AnimatedContainer(
// // // //                   duration: const Duration(milliseconds: 220),
// // // //                   curve: Curves.easeOut,
// // // //                   margin: const EdgeInsets.symmetric(horizontal: 3),
// // // //                   padding: const EdgeInsets.symmetric(vertical: 8),
// // // //                   decoration: BoxDecoration(
// // // //                     // ---- Soft pill highlight behind the active tab ----
// // // //                     color: isActive
// // // //                         ? activeColor.withOpacity(0.10)
// // // //                         : Colors.transparent,
// // // //                     borderRadius: BorderRadius.circular(20),
// // // //                   ),
// // // //                   child: Column(
// // // //                     mainAxisSize: MainAxisSize.min,
// // // //                     children: [
// // // //                       i == 1
// // // //                           ? _askSanaIcon(isActive)
// // // //                           : Icon(
// // // //                               isActive ? _filledIcons[i] : _outlineIcons[i],
// // // //                               size: 24,
// // // //                               color: isActive
// // // //                                   ? activeColor
// // // //                                   : Colors.grey.shade500,
// // // //                             ),
// // // //                       const SizedBox(height: 4),
// // // //                       AnimatedDefaultTextStyle(
// // // //                         duration: const Duration(milliseconds: 220),
// // // //                         style: TextStyle(
// // // //                           fontSize: 10.5,
// // // //                           fontWeight: isActive
// // // //                               ? FontWeight.w700
// // // //                               : FontWeight.w500,
// // // //                           color: isActive ? activeColor : Colors.grey.shade500,
// // // //                         ),
// // // //                         child: Text(_labels[i]),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           }),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }


// // // import 'package:flutter/material.dart';

// // // class RentoBottomNavBar extends StatelessWidget {
// // //   final int currentIndex;
// // //   final ValueChanged<int> onTap;

// // //   const RentoBottomNavBar({
// // //     super.key,
// // //     required this.currentIndex,
// // //     required this.onTap,
// // //   });

// // //   // One distinct color per tab — used only when that tab is active.
// // //   static const List<Color> _activeColors = [
// // //     Color(0xFF2563EB), // Home — blue
// // //     Color(0xFF2563EB), // Ask SaNa — blue
// // //     Color.fromARGB(255, 212, 21, 230), // Post — soft green
// // //     Color(0xFF2563EB), // My House — blue
// // //     Color(0xFF2563EB), // Profile — blue
// // //   ];

// // //   static const List<IconData> _outlineIcons = [
// // //     Icons.home_outlined,
// // //     Icons.support_agent_outlined,
// // //     Icons.add_circle_outline,
// // //     Icons.villa_outlined,
// // //     Icons.person_outline,
// // //   ];

// // //   static const List<IconData> _filledIcons = [
// // //     Icons.home,
// // //     Icons.support_agent,
// // //     Icons.add_circle,
// // //     Icons.villa,
// // //     Icons.person,
// // //   ];

// // //   static const List<String> _labels = [
// // //     'Home',
// // //     'Ask SaNa',
// // //     'Post',
// // //     'My House',
// // //     'Profile',
// // //   ];

// // //   static const double _barHeight = 64;
// // //   static const double _bubbleSize = 56;

// // //   Widget _askSanaIcon(bool isActive, {double size = 26, Key? key}) {
// // //     return Image.asset(
// // //       isActive
// // //           ? 'assets/images/rental/ask_sana_icon.png'
// // //           : 'assets/images/rental/ask_sana_icon_grey.png',
// // //       key: key,
// // //       width: size,
// // //       height: size,
// // //       fit: BoxFit.contain,
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Container(
// // //       margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
// // //       child: LayoutBuilder(
// // //         builder: (context, constraints) {
// // //           final barWidth = constraints.maxWidth;
// // //           final itemWidth = barWidth / _labels.length;
// // //           final bubbleLeft =
// // //               (currentIndex * itemWidth) + (itemWidth - _bubbleSize) / 2;
// // //           final activeColor = _activeColors[currentIndex];

// // //           return SafeArea(
// // //             top: false,
// // //             child: SizedBox(
// // //               // Extra height on top so the bubble has room to float above the bar.
// // //               height: _barHeight + (_bubbleSize / 2) + 6,
// // //               child: Stack(
// // //                 clipBehavior: Clip.none,
// // //                 children: [
// // //                   // ---- Base rounded bar ----
// // //                   Positioned(
// // //                     left: 0,
// // //                     right: 0,
// // //                     bottom: 0,
// // //                     child: Container(
// // //                       height: _barHeight,
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.white,
// // //                         borderRadius: BorderRadius.circular(26),
// // //                         boxShadow: [
// // //                           BoxShadow(
// // //                             color: Colors.black.withOpacity(0.10),
// // //                             blurRadius: 18,
// // //                             offset: const Offset(0, 8),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       child: Row(
// // //                         children: List.generate(_labels.length, (i) {
// // //                           final isActive = i == currentIndex;
// // //                           return Expanded(
// // //                             child: GestureDetector(
// // //                               behavior: HitTestBehavior.opaque,
// // //                               onTap: () => onTap(i),
// // //                               child: Column(
// // //                                 mainAxisAlignment: MainAxisAlignment.end,
// // //                                 children: [
// // //                                   // Reserve the icon's normal slot so layout
// // //                                   // doesn't jump — the active tab's icon is
// // //                                   // hidden here since it's shown in the
// // //                                   // floating bubble instead.
// // //                                   SizedBox(
// // //                                     height: 24,
// // //                                     child: isActive
// // //                                         ? null
// // //                                         : Center(
// // //                                             child: i == 1
// // //                                                 ? _askSanaIcon(false, size: 22)
// // //                                                 : Icon(
// // //                                                     _outlineIcons[i],
// // //                                                     size: 22,
// // //                                                     color: Colors.grey.shade500,
// // //                                                   ),
// // //                                           ),
// // //                                   ),
// // //                                   const SizedBox(height: 4),
// // //                                   AnimatedDefaultTextStyle(
// // //                                     duration: const Duration(milliseconds: 220),
// // //                                     style: TextStyle(
// // //                                       fontSize: 10.5,
// // //                                       fontWeight: isActive
// // //                                           ? FontWeight.w700
// // //                                           : FontWeight.w500,
// // //                                       color: isActive
// // //                                           ? activeColor
// // //                                           : Colors.grey.shade500,
// // //                                     ),
// // //                                     child: Text(_labels[i]),
// // //                                   ),
// // //                                   const SizedBox(height: 10),
// // //                                 ],
// // //                               ),
// // //                             ),
// // //                           );
// // //                         }),
// // //                       ),
// // //                     ),
// // //                   ),

// // //                   // ---- Floating animated bubble for the active tab ----
// // //                   AnimatedPositioned(
// // //                     duration: const Duration(milliseconds: 320),
// // //                     curve: Curves.easeOutCubic,
// // //                     left: bubbleLeft,
// // //                     bottom: _barHeight - (_bubbleSize / 2) - 2,
// // //                     child: GestureDetector(
// // //                       onTap: () => onTap(currentIndex),
// // //                       child: Container(
// // //                         width: _bubbleSize,
// // //                         height: _bubbleSize,
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.white,
// // //                           shape: BoxShape.circle,
// // //                           border: Border.all(color: activeColor, width: 2.4),
// // //                           boxShadow: [
// // //                             BoxShadow(
// // //                               color: activeColor.withOpacity(0.35),
// // //                               blurRadius: 14,
// // //                               offset: const Offset(0, 6),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         child: Center(
// // //                           // AnimatedSwitcher gives a pop/scale-in effect
// // //                           // whenever the active icon changes.
// // //                           child: AnimatedSwitcher(
// // //                             duration: const Duration(milliseconds: 260),
// // //                             transitionBuilder: (child, animation) =>
// // //                                 ScaleTransition(
// // //                               scale: CurvedAnimation(
// // //                                 parent: animation,
// // //                                 curve: Curves.easeOutBack,
// // //                               ),
// // //                               child: FadeTransition(
// // //                                 opacity: animation,
// // //                                 child: child,
// // //                               ),
// // //                             ),
// // //                             child: currentIndex == 1
// // //                                 ? _askSanaIcon(true,
// // //                                     key: const ValueKey('askSanaActive'))
// // //                                 : Icon(
// // //                                     _filledIcons[currentIndex],
// // //                                     key: ValueKey(currentIndex),
// // //                                     size: 26,
// // //                                     color: activeColor,
// // //                                   ),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';

// // class RentoBottomNavBar extends StatelessWidget {
// //   final int currentIndex;
// //   final ValueChanged<int> onTap;

// //   const RentoBottomNavBar({
// //     super.key,
// //     required this.currentIndex,
// //     required this.onTap,
// //   });

// //   // One distinct color per tab — used only when that tab is active.
// //   static const List<Color> _activeColors = [
// //     Color(0xFF2563EB), // Home — blue
// //     Color(0xFF2563EB), // Ask SaNa — blue
// //     Color.fromARGB(255, 212, 21, 230), // Post — soft green
// //     Color(0xFF2563EB), // My House — blue
// //     Color(0xFF2563EB), // Profile — blue
// //   ];

// //   static const List<IconData> _outlineIcons = [
// //     Icons.home_outlined,
// //     Icons.support_agent_outlined,
// //     Icons.add_circle_outline,
// //     Icons.villa_outlined,
// //     Icons.person_outline,
// //   ];

// //   static const List<IconData> _filledIcons = [
// //     Icons.home,
// //     Icons.support_agent,
// //     Icons.add_circle,
// //     Icons.villa,
// //     Icons.person,
// //   ];

// //   static const List<String> _labels = [
// //     'Home',
// //     'Ask SaNa',
// //     'Post',
// //     'My House',
// //     'Profile',
// //   ];

// //   static const double _barHeight = 64;
// //   static const double _bubbleSize = 56;

// //   Widget _askSanaIcon(bool isActive, {double size = 26, Key? key}) {
// //     return Image.asset(
// //       isActive
// //           ? 'assets/images/rental/ask_sana_icon.png'
// //           : 'assets/images/rental/ask_sana_icon_grey.png',
// //       key: key,
// //       width: size,
// //       height: size,
// //       fit: BoxFit.contain,
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // Wrapping in a transparent Material stops Scaffold from painting an
// //     // opaque white rectangle behind the bar — only the rounded pill itself
// //     // (painted below) should be visible, so scrolled content shows through
// //     // the margin/gap around it instead of a solid white block.
// //     return Material(
// //       type: MaterialType.transparency,
// //       child: Container(
// //       margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
// //       color: Colors.transparent,
// //       child: LayoutBuilder(
// //         builder: (context, constraints) {
// //           final barWidth = constraints.maxWidth;
// //           final itemWidth = barWidth / _labels.length;
// //           final bubbleLeft =
// //               (currentIndex * itemWidth) + (itemWidth - _bubbleSize) / 2;
// //           final activeColor = _activeColors[currentIndex];

// //           return SafeArea(
// //             top: false,
// //             child: SizedBox(
// //               // Extra height on top so the bubble has room to float above the bar.
// //               height: _barHeight + (_bubbleSize / 2) + 6,
// //               child: Stack(
// //                 clipBehavior: Clip.none,
// //                 children: [
// //                   // ---- Base rounded bar ----
// //                   Positioned(
// //                     left: 0,
// //                     right: 0,
// //                     bottom: 0,
// //                     child: Container(
// //                       height: _barHeight,
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         borderRadius: BorderRadius.circular(26),
// //                         boxShadow: [
// //                           BoxShadow(
// //                             color: Colors.black.withOpacity(0.10),
// //                             blurRadius: 18,
// //                             offset: const Offset(0, 8),
// //                           ),
// //                         ],
// //                       ),
// //                       child: Row(
// //                         children: List.generate(_labels.length, (i) {
// //                           final isActive = i == currentIndex;
// //                           return Expanded(
// //                             child: GestureDetector(
// //                               behavior: HitTestBehavior.opaque,
// //                               onTap: () => onTap(i),
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.end,
// //                                 children: [
// //                                   // Reserve the icon's normal slot so layout
// //                                   // doesn't jump — the active tab's icon is
// //                                   // hidden here since it's shown in the
// //                                   // floating bubble instead.
// //                                   SizedBox(
// //                                     height: 24,
// //                                     child: isActive
// //                                         ? null
// //                                         : Center(
// //                                             child: i == 1
// //                                                 ? _askSanaIcon(false, size: 22)
// //                                                 : Icon(
// //                                                     _outlineIcons[i],
// //                                                     size: 22,
// //                                                     color: Colors.grey.shade500,
// //                                                   ),
// //                                           ),
// //                                   ),
// //                                   const SizedBox(height: 4),
// //                                   AnimatedDefaultTextStyle(
// //                                     duration: const Duration(milliseconds: 220),
// //                                     style: TextStyle(
// //                                       fontSize: 10.5,
// //                                       fontWeight: isActive
// //                                           ? FontWeight.w700
// //                                           : FontWeight.w500,
// //                                       color: isActive
// //                                           ? activeColor
// //                                           : Colors.grey.shade500,
// //                                     ),
// //                                     child: Text(_labels[i]),
// //                                   ),
// //                                   const SizedBox(height: 10),
// //                                 ],
// //                               ),
// //                             ),
// //                           );
// //                         }),
// //                       ),
// //                     ),
// //                   ),

// //                   // ---- Floating animated bubble for the active tab ----
// //                   AnimatedPositioned(
// //                     duration: const Duration(milliseconds: 320),
// //                     curve: Curves.easeOutCubic,
// //                     left: bubbleLeft,
// //                     bottom: _barHeight - (_bubbleSize / 2) - 2,
// //                     child: GestureDetector(
// //                       onTap: () => onTap(currentIndex),
// //                       child: Container(
// //                         width: _bubbleSize,
// //                         height: _bubbleSize,
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           shape: BoxShape.circle,
// //                           border: Border.all(color: activeColor, width: 2.4),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: activeColor.withOpacity(0.35),
// //                               blurRadius: 14,
// //                               offset: const Offset(0, 6),
// //                             ),
// //                           ],
// //                         ),
// //                         child: Center(
// //                           // AnimatedSwitcher gives a pop/scale-in effect
// //                           // whenever the active icon changes.
// //                           child: AnimatedSwitcher(
// //                             duration: const Duration(milliseconds: 260),
// //                             transitionBuilder: (child, animation) =>
// //                                 ScaleTransition(
// //                               scale: CurvedAnimation(
// //                                 parent: animation,
// //                                 curve: Curves.easeOutBack,
// //                               ),
// //                               child: FadeTransition(
// //                                 opacity: animation,
// //                                 child: child,
// //                               ),
// //                             ),
// //                             child: currentIndex == 1
// //                                 ? _askSanaIcon(true,
// //                                     key: const ValueKey('askSanaActive'))
// //                                 : Icon(
// //                                     _filledIcons[currentIndex],
// //                                     key: ValueKey(currentIndex),
// //                                     size: 26,
// //                                     color: activeColor,
// //                                   ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //       ),
// //     );
// //   }
// // }
 



// import 'package:flutter/material.dart';

// class RentoBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;

//   const RentoBottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   // One distinct color per tab — used only when that tab is active.
//   // static const List<Color> _activeColors = [
//   //   Color(0xFF2563EB), // Home — blue
//   //   Color(0xFF9333EA), // Ask SaNa — purple
//   //   Color(0xFFFF6B35), // Post — orange
//   //   Color(0xFF16A34A), // My House — green
//   //   Color(0xFFDB2777), // Profile — pink
//   // ];





// static const List<Color> _activeColors = [
//   Color(0xFF2563EB), // Home — blue
//   Color(0xFF2563EB), // Ask SaNa — blue
//   Color.fromARGB(255, 212, 21, 230), // Post — soft green
//   Color(0xFF2563EB), // My House — blue
//   Color(0xFF2563EB), // Profile — blue
// ];

//   static const List<IconData> _outlineIcons = [
//     Icons.home_outlined,
//     Icons.support_agent_outlined,
//     Icons.add_circle_outline,
//     Icons.villa_outlined,
//     Icons.person_outline,
//   ];

//   static const List<IconData> _filledIcons = [
//     Icons.home,
//     Icons.support_agent,
//     Icons.add_circle,
//     Icons.villa,
//     Icons.person,
//   ];

//   static const List<String> _labels = [
//     'Home',
//     'Ask SaNa',
//     'Post',
//     'My House',
//     'Profile',
//   ];


// // Widget _askSanaIcon(bool isActive) {
// //   if (isActive) {
// //     return Image.asset(
// //       'assets/images/ask_sana_icon.png',
// //       width: 30,
// //       height: 30,
// //       fit: BoxFit.contain,
// //     );
// //   }

// //   return ColorFiltered(
// //   colorFilter: ColorFilter.mode(
// //     Colors.grey.shade500,
// //     BlendMode.srcIn,
// //   ),
// //   child: Image.asset(
// //     'assets/images/ask_sana_icon.png',
// //     width: 30,
// //     height: 30,
// //     fit: BoxFit.contain,
// //   ),
// // );
// // }


// // Widget _askSanaIcon(bool isActive) {
// //   return ColorFiltered(
// //     colorFilter: isActive
// //         ? const ColorFilter.mode(
// //             Colors.white,
// //             BlendMode.dst,
// //           )
// //         : const ColorFilter.mode(
// //             Colors.grey,
// //             BlendMode.saturation,
// //           ),
// //     child: Image.asset(
// //       'assets/images/ask_sana_icon.png',
// //       width: 30,
// //       height: 30,
// //       fit: BoxFit.contain,
// //     ),
// //   );
// // }



// Widget _askSanaIcon(bool isActive) {
//   return Image.asset(
//     isActive
//         ? 'assets/images/rental/ask_sana_icon.png'
//         : 'assets/images/rental/ask_sana_icon_grey.png',
//     width: 30,
//     height: 30,
//     fit: BoxFit.contain,
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: _activeColors[currentIndex],
//       unselectedItemColor: Colors.grey.shade500,
//       showUnselectedLabels: true,
//       selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
//       unselectedLabelStyle: const TextStyle(fontSize: 11),
//       items: List.generate(_labels.length, (i) {
//         final isActive = i == currentIndex;
//         return BottomNavigationBarItem(
//           // icon: Icon(
//           //   isActive ? _filledIcons[i] : _outlineIcons[i],
//           //   color: isActive ? _activeColors[i] : Colors.grey.shade500,
//           // ),
//           icon: i == 1
//     ? _askSanaIcon(isActive)
//     : Icon(
//         isActive ? _filledIcons[i] : _outlineIcons[i],
//         color: isActive
//             ? _activeColors[i]
//             : Colors.grey.shade500,
//       ),
//           label: _labels[i],
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';

class RentoBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const RentoBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  // One distinct color per tab — used only when that tab is active.
  static const List<Color> _activeColors = [
    Color(0xFF2563EB), // Home — blue
    Color(0xFF2563EB), // Ask SaNa — blue
    Color.fromARGB(255, 212, 21, 230), // Post — soft green
    Color(0xFF2563EB), // My House — blue
    Color(0xFF2563EB), // Profile — blue
  ];

  static const List<IconData> _outlineIcons = [
    Icons.home_outlined,
    Icons.support_agent_outlined,
    Icons.add_circle_outline,
    Icons.villa_outlined,
    Icons.person_outline,
  ];

  static const List<IconData> _filledIcons = [
    Icons.home,
    Icons.support_agent,
    Icons.add_circle,
    Icons.villa,
    Icons.person,
  ];

  static const List<String> _labels = [
    'Home',
    'Ask SaNa',
    'Post',
    'My House',
    'Profile',
  ];

  Widget _askSanaIcon(bool isActive) {
    return Image.asset(
      isActive
          ? 'assets/images/rental/ask_sana_icon.png'
          : 'assets/images/rental/ask_sana_icon_grey.png',
      width: 30,
      height: 30,
      fit: BoxFit.contain,
    );
  }

  // NEW: "My House" now uses your custom my_house_icon.png instead of
  // Icons.villa_outlined / Icons.villa. Only one image file exists (no
  // separate grey version), so it's tinted with ColorFiltered — grey
  // when inactive, the tab's active color when selected — matching the
  // same solid-color behavior as every other icon in this bar.
  Widget _myHouseIcon(bool isActive, Color activeColor) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isActive ? activeColor : Colors.grey.shade500,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        'assets/images/rental/my_house_icon.png',
        width: 26,
        height: 26,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: _activeColors[currentIndex],
      unselectedItemColor: Colors.grey.shade500,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      items: List.generate(_labels.length, (i) {
        final isActive = i == currentIndex;
        return BottomNavigationBarItem(
          icon: i == 1
              ? _askSanaIcon(isActive)
              : i == 3
                  ? _myHouseIcon(isActive, _activeColors[i])
                  : Icon(
                      isActive ? _filledIcons[i] : _outlineIcons[i],
                      color: isActive
                          ? _activeColors[i]
                          : Colors.grey.shade500,
                    ),
          label: _labels[i],
        );
      }),
    );
  }
}