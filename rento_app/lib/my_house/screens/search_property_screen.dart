import '../../core/api_client.dart';
import '../core/my_house_api.dart';

import 'package:flutter/material.dart';

import 'property_details_screen.dart';

class SearchPropertyScreen extends StatefulWidget {
  const SearchPropertyScreen({super.key});

  @override
  State<SearchPropertyScreen> createState() => _SearchPropertyScreenState();
}

class _SearchPropertyScreenState extends State<SearchPropertyScreen> {
  String selectedCity = 'Chennai';
  String selectedLocality = 'Anna Nagar';
  String selectedBudget = '₹5,000 - ₹15,000';
  String selectedBHK = '1 BHK';
  String selectedFurnishing = 'Furnished';
  String selectedFor = 'Family';
  String selectedFacility = '';

  final List<String> cities = [
    'Chennai',
    'Bangalore',
    'Mumbai',
    'Hyderabad',
    'Delhi',
    'Puducherry',
  ];
  final List<String> localities = [
    'Anna Nagar',
    'T Nagar',
    'Adyar',
    'Velachery',
    'Porur',
  ];
  final List<String> budgetRanges = [
    '₹5,000 - ₹15,000',
    '₹15,000 - ₹25,000',
    '₹25,000 - ₹35,000',
    '₹35,000 - ₹50,000',
  ];

  final List<String> bhkTypes = ['1 BHK', '2 BHK', '3 BHK', 'Studio'];
  final List<String> furnishingTypes = [
    'Furnished',
    'Semi-Furnished',
    'Unfurnished',
  ];
  final List<String> forTypes = ['Family', 'Bachelor', 'Girls Only'];

  static const Color primaryDark = Color(0xFF1A1A1A);
  static const Color bgLight = Color(0xFFF7F7F7);
  static const double cardRadius = 20;
  static const double chipRadius = 16;
  static const double buttonRadius = 18;

  // loaded from the server (approved listings only)
  List<Map<String, String>> allProperties = [];
  bool _loadingProperties = true;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    try {
      final list = await MyHouseApi.instance.searchProperties();
      if (!mounted) return;
      setState(() {
        allProperties = list;
        _loadingProperties = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _loadingProperties = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  List<Map<String, String>> get _filteredProperties {
    final matches = allProperties
        .where((p) => p['bhk'] == selectedBHK && p['city'] == selectedCity)
        .toList();
    matches.sort((a, b) {
      final aSame = a['locality'] == selectedLocality ? 0 : 1;
      final bSame = b['locality'] == selectedLocality ? 0 : 1;
      return aSame.compareTo(bSame);
    });
    return matches;
  }

  Widget _propertyImage(String path, {required double height}) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: height,
          color: const Color(0xFFF0F0F0),
          child: const Icon(Icons.home, color: Colors.grey, size: 28),
        ),
      );
    }
    return Image.network(
      path,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        height: height,
        color: const Color(0xFFF0F0F0),
        child: const Icon(Icons.home, color: Colors.grey, size: 28),
      ),
    );
  }

  Widget _chip(String label, String groupValue, ValueChanged<String> onTap) {
    final bool selected = label == groupValue;
    return GestureDetector(
      onTap: () => onTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? primaryDark : Colors.white,
          border: Border.all(
            color: selected ? primaryDark : const Color(0xFFE0E0E0),
          ),
          borderRadius: BorderRadius.circular(chipRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(selected ? 0.18 : 0.05),
              blurRadius: selected ? 12 : 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF2D2D2D),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _nearbyIcon(
    IconData icon,
    String label,
    Color bgColor,
    Color iconColor,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, size: 24, color: iconColor),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: primaryDark,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _glowCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _dropdownField({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return _glowCard(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            borderRadius: BorderRadius.circular(cardRadius),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: primaryDark,
            ),
            style: const TextStyle(
              color: primaryDark,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            items: items
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Row(
                      children: [
                        Icon(icon, size: 16, color: primaryDark),
                        const SizedBox(width: 8),
                        Text(item),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _resultCard(Map<String, String> data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(data: data),
          ),
        );
      },
      child: Container(
        width: 190,
        margin: const EdgeInsets.only(right: 14, bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(cardRadius),
                  ),
                  child: _propertyImage(data['image']!, height: 120),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      data['bhk']!,
                      style: const TextStyle(
                        color: primaryDark,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          '${data['locality']}, $selectedCity',
                          style: const TextStyle(
                            fontSize: 11.5,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data['price']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7F7EE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data['available']!,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1FAE6B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final results = _filteredProperties;

    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: bgLight,
        elevation: 0,
        title: const Text(
          'Search Property',
          style: TextStyle(
            color: primaryDark,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: primaryDark),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.tune_rounded, color: primaryDark),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('City'),
            _dropdownField(
              value: selectedCity,
              items: cities,
              icon: Icons.location_city_rounded,
              onChanged: (val) => setState(() => selectedCity = val!),
            ),

            _sectionTitle('Locality'),
            _dropdownField(
              value: selectedLocality,
              items: localities,
              icon: Icons.map_rounded,
              onChanged: (val) => setState(() => selectedLocality = val!),
            ),

            _sectionTitle('Budget Range'),
            _dropdownField(
              value: selectedBudget,
              items: budgetRanges,
              icon: Icons.currency_rupee_rounded,
              onChanged: (val) => setState(() => selectedBudget = val!),
            ),

            _sectionTitle('BHK Type'),
            Wrap(
              children: bhkTypes
                  .map(
                    (e) => _chip(
                      e,
                      selectedBHK,
                      (val) => setState(() => selectedBHK = val),
                    ),
                  )
                  .toList(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$selectedBHK near $selectedLocality',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: primaryDark,
                  ),
                ),
                Text(
                  '${results.length} results',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),
            results.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'No $selectedBHK properties found nearby yet.',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  )
                : SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: results.length,
                      itemBuilder: (context, index) =>
                          _resultCard(results[index]),
                    ),
                  ),

            _sectionTitle('Furnishing'),
            Wrap(
              children: furnishingTypes
                  .map(
                    (e) => _chip(
                      e,
                      selectedFurnishing,
                      (val) => setState(() => selectedFurnishing = val),
                    ),
                  )
                  .toList(),
            ),

            _sectionTitle('For'),
            Wrap(
              children: forTypes
                  .map(
                    (e) => _chip(
                      e,
                      selectedFor,
                      (val) => setState(() => selectedFor = val),
                    ),
                  )
                  .toList(),
            ),

            _sectionTitle('Nearby Facilities'),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _nearbyIcon(
                    Icons.directions_subway_rounded,
                    'Metro',
                    const Color(0xFFD6DEFC),
                    const Color(0xFF4361EE),
                  ),
                  _nearbyIcon(
                    Icons.school_rounded,
                    'School',
                    const Color(0xFFFFE7C2),
                    const Color(0xFFFF9F1C),
                  ),
                  _nearbyIcon(
                    Icons.local_hospital_rounded,
                    'Hospital',
                    const Color(0xFFFAD4E6),
                    const Color(0xFFE71D8A),
                  ),
                  _nearbyIcon(
                    Icons.storefront_rounded,
                    'Market',
                    const Color(0xFFC9F0E8),
                    const Color(0xFF2EC4B6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(buttonRadius),
                color: primaryDark,
                boxShadow: [
                  BoxShadow(
                    color: primaryDark.withOpacity(0.30),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(buttonRadius),
                  onTap: () {
                    if (results.isEmpty && allProperties.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _loadingProperties
                                ? 'Loading properties...'
                                : 'No properties are listed yet',
                          ),
                        ),
                      );
                      return;
                    }
                    final Map<String, String> chosen = results.isNotEmpty
                        ? results.first
                        : allProperties.first;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PropertyDetailsScreen(data: chosen),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Search Properties',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}
