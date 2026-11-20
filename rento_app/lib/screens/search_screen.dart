// // import 'package:flutter/material.dart';

// // class SearchScreen extends StatefulWidget {
// //   const SearchScreen({super.key});

// //   @override
// //   State<SearchScreen> createState() => _SearchScreenState();
// // }

// // class _SearchScreenState extends State<SearchScreen> {
// //   final _controller = TextEditingController();
// //   final List<String> _recentSearches = ['Camera', 'Sofa', 'Bike', 'Washing Machine'];
// //   List<String> _results = [];

// //   final List<String> _allProducts = [
// //     'Canon DSLR 1200D', 'Nordic 3-Seater Sofa', 'Honda Activa 6G',
// //     'Samsung Washing Machine', 'MacBook Pro', 'Mountain Bike',
// //     'Air Conditioner', 'Gaming Chair', 'Refrigerator',
// //   ];

// //   void _search(String query) {
// //     setState(() {
// //       _results = query.isEmpty
// //           ? []
// //           : _allProducts
// //               .where((p) => p.toLowerCase().contains(query.toLowerCase()))
// //               .toList();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: TextField(
// //           controller: _controller,
// //           autofocus: true,
// //           onChanged: _search,
// //           decoration: const InputDecoration(
// //             hintText: 'Search cameras, bikes, furniture...',
// //             border: InputBorder.none,
// //           ),
// //         ),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: _controller.text.isEmpty
// //             ? Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Text('Recent Searches',
// //                       style: TextStyle(fontWeight: FontWeight.w700)),
// //                   const SizedBox(height: 10),
// //                   Wrap(
// //                     spacing: 8,
// //                     runSpacing: 8,
// //                     children: _recentSearches
// //                         .map((s) => Chip(label: Text(s)))
// //                         .toList(),
// //                   ),
// //                 ],
// //               )
// //             : ListView.builder(
// //                 itemCount: _results.length,
// //                 itemBuilder: (context, i) => ListTile(
// //                   leading: const Icon(Icons.search),
// //                   title: Text(_results[i]),
// //                   onTap: () {},
// //                 ),
// //               ),
// //       ),
// //     );
// //   }
// // }



























// import 'package:flutter/material.dart';
// import 'package:rento/delivery/core/constants/app_colors.dart';//import '../constants/app_colors.dart';
// import '../constants/app_text_styles.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final _controller = TextEditingController();
//   final List<String> _recentSearches = ['Camera', 'Sofa', 'Bike', 'Washing Machine'];
//   List<String> _results = [];

//   final List<String> _allProducts = [
//     'Canon DSLR 1200D', 'Nordic 3-Seater Sofa', 'Honda Activa 6G',
//     'Samsung Washing Machine', 'MacBook Pro', 'Mountain Bike',
//     'Air Conditioner', 'Gaming Chair', 'Refrigerator',
//   ];

//   void _search(String query) {
//     setState(() {
//       _results = query.isEmpty
//           ? []
//           : _allProducts
//               .where((p) => p.toLowerCase().contains(query.toLowerCase()))
//               .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//           controller: _controller,
//           autofocus: true,
//           onChanged: _search,
//           style: AppText.bodyLg,
//           decoration: InputDecoration(
//             hintText: 'Search cameras, bikes, furniture...',
//             hintStyle: AppText.bodyLg.copyWith(color: AppColors.textHint),
//             border: InputBorder.none,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: _controller.text.isEmpty
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Recent Searches', style: AppText.titleLg.copyWith(fontSize: 14)),
//                   const SizedBox(height: 10),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: _recentSearches
//                         .map((s) => Chip(label: Text(s, style: AppText.bodyMd)))
//                         .toList(),
//                   ),
//                 ],
//               )
//             : ListView.builder(
//                 itemCount: _results.length,
//                 itemBuilder: (context, i) => ListTile(
//                   leading: const Icon(Icons.search, color: AppColors.textSecondary),
//                   title: Text(_results[i], style: AppText.bodyLg),
//                   onTap: () {},
//                 ),
//               ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final List<String> _recentSearches = ['Camera', 'Sofa', 'Bike', 'Washing Machine'];
  List<String> _results = [];

  final List<String> _allProducts = [
    'Canon DSLR 1200D', 'Nordic 3-Seater Sofa', 'Honda Activa 6G',
    'Samsung Washing Machine', 'MacBook Pro', 'Mountain Bike',
    'Air Conditioner', 'Gaming Chair', 'Refrigerator',
  ];

  void _search(String query) {
    setState(() {
      _results = query.isEmpty
          ? []
          : _allProducts
              .where((p) => p.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _search,
          style: AppText.bodyLg,
          decoration: InputDecoration(
            hintText: 'Search cameras, bikes, furniture...',
            hintStyle: AppText.bodyLg.copyWith(color: AppColors.textHint),
            border: InputBorder.none,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _controller.text.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Searches', style: AppText.titleLg.copyWith(fontSize: 14)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _recentSearches
                        .map((s) => Chip(label: Text(s, style: AppText.bodyMd)))
                        .toList(),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, i) => ListTile(
                  leading: const Icon(Icons.search, color: AppColors.textSecondary),
                  title: Text(_results[i], style: AppText.bodyLg),
                  onTap: () {},
                ),
              ),
      ),
    );
  }
}