import 'package:flutter/material.dart';
import 'owner_theme.dart';
import 'owner_register_property_screen.dart';
import 'owner_property_details_screen.dart';
import 'owner_maintenance_screen.dart';
import 'owner_my_tenants_screen.dart';
import 'owner_notifications_screen.dart';
import 'owner_profile_screen.dart';
import 'package:rento_india/my_house/screens/my_house_home_screen.dart';

/// RENTO INDIA — Owner Dashboard (main landing screen for Owner Flow)
/// Wraps Property List + Bottom Navigation to other owner sections.
/// NOTE: "Requests" (Visit Requests) tab removed per product decision —
/// only Properties, Maintenance, Tenants, Profile remain.
class OwnerDashboardScreen extends StatefulWidget {
  const OwnerDashboardScreen({super.key});

  @override
  State<OwnerDashboardScreen> createState() => _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState extends State<OwnerDashboardScreen> {
  int _selectedIndex = 0;

  // Tabs shown via bottom navigation
  final List<Widget> _tabs = const [
    OwnerPropertyListScreen(),
    OwnerMaintenanceScreen(),
    OwnerMyTenantsScreen(),
    OwnerProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: OwnerTheme.primaryDark,
        unselectedItemColor: OwnerTheme.textGrey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Properties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build_outlined),
            activeIcon: Icon(Icons.build),
            label: 'Maintenance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Tenants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// RENTO INDIA — Owner Flow Screen 6: Property List
/// (Tab 1 inside OwnerDashboardScreen)
class OwnerPropertyListScreen extends StatelessWidget {
  const OwnerPropertyListScreen({super.key});

  // ---------------------------------------------------------------------
  // Each property now carries an 'image' (local asset path) plus the
  // extra detail fields (status, bhk, bathroom, floor, tenant, moveIn)
  // that OwnerPropertyDetailsScreen needs so every property shows its
  // OWN correct photo + details, not a hardcoded one.
  //
  // Put these 3 photos in:  assets/images/
  //   assets/images/property_anna_nagar.jpg
  //   assets/images/property_nungambakkam.jpg
  //   assets/images/property_tnagar.jpg
  // ---------------------------------------------------------------------
  static final List<Map<String, String>> properties = [
    {
      'title': '2 BHK Apartment',
      'location': 'Anna Nagar, Chennai',
      'rent': '₹12,000 / month',
      'image': 'assets/images/my_house/property_anna_nagar.jpg',
      'status': 'Occupied',
      'bhk': '2 BHK',
      'bathroom': '2 Bathroom',
      'floor': '3rd Floor',
      'tenant': 'Karthik Raj',
      'moveIn': 'Move-in: 15 May 2025',
    },
    {
      'title': '1 BHK Apartment',
      'location': 'Nungambakkam, Chennai',
      'rent': '₹9,000 / month',
      'image': 'assets/images/my_house/property_nungambakkam.jpg',
      'status': 'Vacant',
      'bhk': '1 BHK',
      'bathroom': '1 Bathroom',
      'floor': '2nd Floor',
      'tenant': '',
      'moveIn': '',
    },
    {
      'title': '3 BHK Apartment',
      'location': 'T. Nagar, Chennai',
      'rent': '₹14,000 / month',
      'image': 'assets/images/my_house/property_tnagar.jpg',
      'status': 'Occupied',
      'bhk': '3 BHK',
      'bathroom': '3 Bathroom',
      'floor': '1st Floor',
      'tenant': 'Priya Sharma',
      'moveIn': 'Move-in: 02 Feb 2025',
    },
  ];

  /// Leaves the Owner flow entirely and lands back on the tenant Home
  /// screen. Pops back if HomeScreen is still on the stack (the common
  /// case — Owner Dashboard was pushed on top of it); otherwise pushes a
  /// fresh HomeScreen and clears the stack so there's no dead-end.
  void _goToTenantHome(BuildContext context) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.popUntil((route) => route.isFirst);
    } else {
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const myhousehomescreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: AppBar(
        backgroundColor: OwnerTheme.bgGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.home_outlined, color: OwnerTheme.primaryDark),
          tooltip: 'Back to Home',
          onPressed: () => _goToTenantHome(context),
        ),
        title: const Text(
          'My Properties',
          style: TextStyle(
            color: OwnerTheme.primaryDark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: OwnerTheme.primaryDark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OwnerNotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: properties.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final p = properties[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OwnerPropertyDetailsScreen(data: p),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: OwnerTheme.card,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            p['image']!,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 64,
                              height: 64,
                              color: OwnerTheme.borderGrey,
                              child: const Icon(Icons.apartment,
                                  color: OwnerTheme.primaryDark),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p['title']!, style: OwnerTheme.heading),
                              const SizedBox(height: 4),
                              Text(p['location']!, style: OwnerTheme.subText),
                              const SizedBox(height: 4),
                              Text(p['rent']!, style: const TextStyle(
                                  color: OwnerTheme.primaryDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: OwnerTheme.textGrey),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OwnerRegisterPropertyScreen(),
                    ),
                  );
                },
                style: OwnerTheme.primaryButton,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Add New Property',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}