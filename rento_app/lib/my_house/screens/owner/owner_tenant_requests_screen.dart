import 'package:flutter/material.dart';
import 'owner_theme.dart';
import 'owner_approve_tenant_screen.dart';

/// RENTO INDIA — Owner Flow Screen 2: Manage Tenant Requests
class OwnerTenantRequestsScreen extends StatefulWidget {
  const OwnerTenantRequestsScreen({super.key});

  @override
  State<OwnerTenantRequestsScreen> createState() =>
      _OwnerTenantRequestsScreenState();
}

class _OwnerTenantRequestsScreenState extends State<OwnerTenantRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> _pending = [
    {
      'name': 'Karthik Raj',
      'property': '2 BHK Apartment',
      'location': 'Anna Nagar, Chennai',
      'date': '15 May 2025, 10:00 AM',
    },
    {
      'name': 'Vignesh Kumar',
      'property': '1 BHK Apartment',
      'location': 'Nungambakkam, Chennai',
      'date': '14 May 2025, 04:00 PM',
    },
  ];

  final List<Map<String, String>> _accepted = [];
  final List<Map<String, String>> _completed = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _accept(int index) {
    setState(() {
      final item = _pending.removeAt(index);
      _accepted.add(item);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Visit request accepted')));
  }

  void _suggestTime(int index) {
    // TODO: open reschedule visit screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Suggest a different date/time')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'Visit Requests'),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: OwnerTheme.primaryDark,
            unselectedLabelColor: OwnerTheme.textGrey,
            indicatorColor: OwnerTheme.primaryDark,
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
              Tab(text: 'Completed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _requestList(_pending, showActions: true),
                _requestList(_accepted, showActions: false),
                _requestList(_completed, showActions: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestList(List<Map<String, String>> items, {required bool showActions}) {
    if (items.isEmpty) {
      return Center(
        child: Text('No requests here', style: OwnerTheme.subText),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OwnerApproveTenantScreen(),
              ),
            );
          },
          child: Container(
          padding: const EdgeInsets.all(16),
          decoration: OwnerTheme.card,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: OwnerTheme.borderGrey,
                    child: Icon(Icons.person, color: OwnerTheme.primaryDark),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'] ?? '', style: OwnerTheme.heading),
                        const SizedBox(height: 2),
                        Text('Request for ${item['property']}',
                            style: OwnerTheme.subText),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text('${item['location']} • ${item['date']}',
                  style: OwnerTheme.subText),
              if (showActions) ...[
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _suggestTime(index),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: OwnerTheme.borderGrey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Suggest Time',
                            style: TextStyle(color: OwnerTheme.primaryDark)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _accept(index),
                        style: OwnerTheme.primaryButton,
                        child: const Text('Accept',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          ),
        );
      },
    );
  }
}