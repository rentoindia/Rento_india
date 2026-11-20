import 'package:flutter/material.dart';
import 'owner_theme.dart';

/// RENTO INDIA — Owner Flow Screen 5: Manage Maintenance Requests
class OwnerMaintenanceScreen extends StatefulWidget {
  const OwnerMaintenanceScreen({super.key});

  @override
  State<OwnerMaintenanceScreen> createState() => _OwnerMaintenanceScreenState();
}

class _OwnerMaintenanceScreenState extends State<OwnerMaintenanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> _newRequests = [
    {
      'title': 'Leaking pipe in bathroom',
      'tenant': 'Karthik Raj',
      'date': '15 May 2025',
    },
  ];
  final List<Map<String, String>> _inProgress = [
    {
      'title': 'AC not cooling',
      'tenant': 'Vignesh Kumar',
      'date': '14 May 2025',
    },
  ];
  final List<Map<String, String>> _resolved = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OwnerTheme.bgGrey,
      appBar: OwnerTheme.appBar(context, 'Maintenance Requests'),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: OwnerTheme.primaryDark,
            unselectedLabelColor: OwnerTheme.textGrey,
            indicatorColor: OwnerTheme.primaryDark,
            tabs: const [
              Tab(text: 'New'),
              Tab(text: 'In Progress'),
              Tab(text: 'Resolved'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _list(_newRequests, 'New'),
                _list(_inProgress, 'In Progress'),
                _list(_resolved, 'Resolved'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(List<Map<String, String>> items, String stage) {
    if (items.isEmpty) {
      return Center(child: Text('No requests here', style: OwnerTheme.subText));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: OwnerTheme.card,
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: OwnerTheme.borderGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.build_outlined,
                    color: OwnerTheme.primaryDark, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['title']!, style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: OwnerTheme.primaryDark,
                        fontSize: 14)),
                    const SizedBox(height: 3),
                    Text('${item['tenant']} • ${item['date']}',
                        style: OwnerTheme.subText),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: OwnerTheme.textGrey),
                onSelected: (value) {
                  // TODO: handle Assign Worker / Mark Resolved actions
                },
                itemBuilder: (context) => [
                  if (stage == 'New')
                    const PopupMenuItem(
                        value: 'assign', child: Text('Assign Worker')),
                  if (stage == 'In Progress')
                    const PopupMenuItem(
                        value: 'resolve', child: Text('Mark Resolved')),
                  const PopupMenuItem(value: 'view', child: Text('View Details')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}