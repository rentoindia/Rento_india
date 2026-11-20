import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import 'package:rento_india/my_house/screens/my_house_home_screen.dart';
import '../screens/rento_screen.dart';
import '../screens/chat_support_screen.dart';
import '../screens/profile_screen.dart';

/// Switches to the tab at [index], replacing the current screen instead
/// of stacking on top of it — this keeps the bottom nav behaving like
/// real tabs no matter which page you're currently on.
///
/// Order now matches the new bottom nav: Home, My House, Post (was
/// Rento, index 2), RentoBot (was Chat, index 3), Profile.
void navigateToTab(BuildContext context, int index) {
  final screens = [
    const HomeScreen(),
    const ChatSupportScreen(),
    const RentoScreen(),
    const myhousehomescreen(),
    const ProfileScreen(),
  ];
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => screens[index]),
  );
}