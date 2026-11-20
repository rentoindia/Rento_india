











// // Master data source for the CategoryDetailScreen.
// // Each entry maps a category name (as used in CategoryScreen's grid) to
// // its results count, search hint, sidebar/chip subcategories, promo copy,
// // and product list. Add a new category by adding a new entry here —
// // CategoryDetailScreen looks itself up by name automatically.

// class CategoryProduct {
//   final String name;
//   final String price;
//   final String image;
//   final String sub;

//   const CategoryProduct({
//     required this.name,
//     required this.price,
//     required this.image,
//     required this.sub,
//   });
// }

// // class CategoryData {
// //   final String resultsCount;
// //   final String searchHint;
// //   final List<String> subcategories;
// //   final String promoPercent;
// //   final List<CategoryProduct> products;

// //   const CategoryData({
// //     required this.resultsCount,
// //     required this.searchHint,
// //     required this.subcategories,
// //     required this.promoPercent,
// //     required this.products,
// //   });
// // }



// class CategoryData {
//   final String searchHint;
//   final List<String> subcategories;
//   final String promoPercent;
//   final List<CategoryProduct> products;

//   const CategoryData({
//     required this.searchHint,
//     required this.subcategories,
//     required this.promoPercent,
//     required this.products,
//   });

//   // Live count — always matches however many products are actually
//   // listed above, instead of a hardcoded number that can drift out
//   // of sync.
//   int get resultsCount => products.length;
// }

// final Map<String, CategoryData> categoryDataMap = {
//   'Furniture': CategoryData(
//        searchHint: 'Search sofas, beds, tables...',
//     subcategories: const [
//       'All Furniture',
//       'Home Furniture',
//       'Office & Workspace Furniture',
//       'Outdoor & Garden Furniture',
//       'Kids & Baby Furniture',
//       'Event & Party Furniture',
//       'Smart & Tech-Integrated Furniture',
//       'Specialty & Luxury Furniture',
//     ],
//     promoPercent: '30',
//     products: const [
//       CategoryProduct(name: 'Sofa 3 Seater', price: '₹699 / day', image: 'https://picsum.photos/seed/furn1/200/200', sub: 'Home Furniture'),
//       CategoryProduct(name: 'Ergonomic Office Chair', price: '₹249 / day', image: 'https://picsum.photos/seed/furn2/200/200', sub: 'Office & Workspace Furniture'),
//       CategoryProduct(name: 'Garden Bench Set', price: '₹399 / day', image: 'https://picsum.photos/seed/furn3/200/200', sub: 'Outdoor & Garden Furniture'),
//       CategoryProduct(name: 'Kids Bunk Bed', price: '₹349 / day', image: 'https://picsum.photos/seed/furn4/200/200', sub: 'Kids & Baby Furniture'),
//       CategoryProduct(name: 'Party Folding Tables', price: '₹199 / day', image: 'https://picsum.photos/seed/furn5/200/200', sub: 'Event & Party Furniture'),
//     ],
//   ),
//   'Vehicles': CategoryData(
//         searchHint: 'Search bikes, cars, scooters...',
//     subcategories: const [
//       'All Vehicles',
//       'Two-Wheelers',
//       'Three-Wheelers',
//       'Four-Wheelers',
//       'Cycle',
//       'Commercial & Heavy Vehicles',
//       'Rental & Recreational Vehicles',
//     ],
//     promoPercent: '20',
//     products: const [
//       CategoryProduct(name: 'Honda Activa 6G', price: '₹249 / day', image: 'https://picsum.photos/seed/veh1/200/200', sub: 'Two-Wheelers'),
//       CategoryProduct(name: 'Auto Rickshaw', price: '₹399 / day', image: 'https://picsum.photos/seed/veh2/200/200', sub: 'Three-Wheelers'),
//       CategoryProduct(name: 'Hyundai i20', price: '₹1,599 / day', image: 'https://picsum.photos/seed/veh3/200/200', sub: 'Four-Wheelers'),
//       CategoryProduct(name: 'Mountain Bike', price: '₹149 / day', image: 'https://picsum.photos/seed/veh4/200/200', sub: 'Cycle'),
//       CategoryProduct(name: 'Mini Delivery Truck', price: '₹2,199 / day', image: 'https://picsum.photos/seed/veh5/200/200', sub: 'Commercial & Heavy Vehicles'),
//     ],
//   ),
//   'Electronics & Devices': CategoryData(
//         searchHint: 'Search laptops, cameras, audio...',
//     subcategories: const [
//       'All Electronics & Devices',
//       'Personal Electronics',
//       'Computing Devices',
//       'Cameras & Photography Equipment',
//       'Audio & Music Equipment',
//       'Gaming & Accessories',
//       'Home Appliances & Smart Home Devices',
//       'Office & Productivity Electronics',
//       'Kitchen & Cooking Appliances',
//       'Wearable Tech & Health Devices',
//       'Specialized & Industrial Electronics',
//     ],
//     promoPercent: '25',
//     products: const [
//       CategoryProduct(name: 'iPhone 15', price: '₹799 / day', image: 'https://picsum.photos/seed/elec1/200/200', sub: 'Personal Electronics'),
//       CategoryProduct(name: 'MacBook Air M2', price: '₹999 / day', image: 'https://picsum.photos/seed/elec2/200/200', sub: 'Computing Devices'),
//       CategoryProduct(name: 'Canon DSLR 1200D', price: '₹599 / day', image: 'https://picsum.photos/seed/elec3/200/200', sub: 'Cameras & Photography Equipment'),
//       CategoryProduct(name: 'Bluetooth Speaker', price: '₹199 / day', image: 'https://picsum.photos/seed/elec4/200/200', sub: 'Audio & Music Equipment'),
//       CategoryProduct(name: 'PlayStation 5', price: '₹599 / day', image: 'https://picsum.photos/seed/elec5/200/200', sub: 'Gaming & Accessories'),
//     ],
//   ),
//   'Books & Stationery': CategoryData(
//         searchHint: 'Search books, notebooks, pens...',
//     subcategories: const [
//       'All Books & Stationery',
//       'Textbooks & Academic Materials',
//       'Competitive Exams & Professional Prep',
//       'Fiction & Literature',
//       'Non-Fiction & General Knowledge',
//       'Science, Technology, and Medical',
//       'Religious, Spiritual & Mythology',
//       'Children & Teen Books',
//       'Magazines & Periodicals',
//       'Digital & Audio Formats',
//       'Writing Tools',
//       'Paper Products',
//       'Organizers & Filing',
//       'Art & Creative Supplies',
//       'Mathematical & Technical Tools',
//       'School & College Essentials',
//       'Office & Professional Stationery',
//       'Presentation Tools',
//       'Labeling & Personalization',
//       'Calligraphy & Design',
//     ],
//     promoPercent: '30',
//     products: const [
//       CategoryProduct(name: 'Engineering Textbook Set', price: '₹49 / day', image: 'https://picsum.photos/seed/book1/200/200', sub: 'Textbooks & Academic Materials'),
//       CategoryProduct(name: 'The Alchemist', price: '₹29 / day', image: 'https://picsum.photos/seed/book2/200/200', sub: 'Fiction & Literature'),
//       CategoryProduct(name: 'Drafting Tool Kit', price: '₹39 / day', image: 'https://picsum.photos/seed/book3/200/200', sub: 'Mathematical & Technical Tools'),
//       CategoryProduct(name: 'Calligraphy Pen Set', price: '₹59 / day', image: 'https://picsum.photos/seed/book4/200/200', sub: 'Calligraphy & Design'),
//     ],
//   ),
//   'Clothing & Accessories': CategoryData(
//         searchHint: 'Search dresses, suits, footwear...',
//     subcategories: const [
//       'All Clothing & Accessories',
//       "Men's Clothing",
//       "Women's Clothing",
//       "Kid's Clothing",
//       'Seasonal & Specialty Wear',
//       'Wedding & Formal Wear',
//       'Footwear',
//       'Accessories',
//       'Jewelry & Fashion Accessories',
//     ],
//     promoPercent: '25',
//     products: const [
//       CategoryProduct(name: 'Formal Blazer', price: '₹299 / day', image: 'https://picsum.photos/seed/cloth1/200/200', sub: "Men's Clothing"),
//       CategoryProduct(name: 'Designer Saree', price: '₹499 / day', image: 'https://picsum.photos/seed/cloth2/200/200', sub: "Women's Clothing"),
//       CategoryProduct(name: 'Party Shoes', price: '₹199 / day', image: 'https://picsum.photos/seed/cloth3/200/200', sub: 'Footwear'),
//       CategoryProduct(name: 'Statement Necklace', price: '₹149 / day', image: 'https://picsum.photos/seed/cloth4/200/200', sub: 'Jewelry & Fashion Accessories'),
//     ],
//   ),
//   'Machinery & Tools': CategoryData(
//         searchHint: 'Search drills, generators, tools...',
//     subcategories: const [
//       'All Machinery & Tools',
//       'Construction Machinery',
//       'Agricultural Machinery',
//       'Industrial Machinery',
//       'Power Tools',
//       'Hand Tools',
//       'Gardening Tools & Equipment',
//       'Safety & Support Equipment',
//       'Testing & Measuring Tools',
//       'Miscellaneous Tools & Machines',
//     ],
//     promoPercent: '20',
//     products: const [
//       CategoryProduct(name: 'Cordless Drill', price: '₹149 / day', image: 'https://picsum.photos/seed/mach1/200/200', sub: 'Power Tools'),
//       CategoryProduct(name: 'Tractor (Mini)', price: '₹1,999 / day', image: 'https://picsum.photos/seed/mach2/200/200', sub: 'Agricultural Machinery'),
//       CategoryProduct(name: 'Digital Multimeter', price: '₹99 / day', image: 'https://picsum.photos/seed/mach3/200/200', sub: 'Testing & Measuring Tools'),
//     ],
//   ),
//   'Sports Equipment and Gaming': CategoryData(
//         searchHint: 'Search fitness, cricket, gaming gear...',
//     subcategories: const [
//       'All Sports Equipment and Gaming',
//       'Outdoor Sports',
//       'Indoor Sports',
//       'Fitness & Gym Equipment',
//       'Adventure & Outdoor Gear',
//       'Athletics Equipment',
//       'Water Sports Equipment',
//       'Winter Sports Gear',
//       'Martial Arts Equipment',
//       'Cycling Accessories',
//       'Playstation',
//       'Miscellaneous Sports Equipment',
//     ],
//     promoPercent: '30',
//     products: const [
//       CategoryProduct(name: 'Treadmill', price: '₹699 / day', image: 'https://picsum.photos/seed/sport1/200/200', sub: 'Fitness & Gym Equipment'),
//       CategoryProduct(name: 'Cricket Kit', price: '₹299 / day', image: 'https://picsum.photos/seed/sport2/200/200', sub: 'Outdoor Sports'),
//       CategoryProduct(name: 'PlayStation 5', price: '₹599 / day', image: 'https://picsum.photos/seed/sport3/200/200', sub: 'Playstation'),
//       CategoryProduct(name: 'Surfboard', price: '₹499 / day', image: 'https://picsum.photos/seed/sport4/200/200', sub: 'Water Sports Equipment'),
//     ],
//   ),
//   'Toys & Baby Gear': CategoryData(
//         searchHint: 'Search toys, strollers, cribs...',
//     subcategories: const [
//       'All Toys & Baby Gear',
//       'Toys (Infants to Teens)',
//       'Baby Gear',
//       'Outdoor Play Equipment',
//       'Learning & Development Aids',
//       'Party & Celebration Toys',
//     ],
//     promoPercent: '30',
//     products: const [
//       CategoryProduct(name: 'Baby Stroller', price: '₹149 / day', image: 'https://picsum.photos/seed/toy1/200/200', sub: 'Baby Gear'),
//       CategoryProduct(name: 'LEGO Set', price: '₹99 / day', image: 'https://picsum.photos/seed/toy2/200/200', sub: 'Toys (Infants to Teens)'),
//       CategoryProduct(name: 'Kids Trampoline', price: '₹249 / day', image: 'https://picsum.photos/seed/toy3/200/200', sub: 'Outdoor Play Equipment'),
//     ],
//   ),
//   'Cosmetics & Beauty Equipment': CategoryData(
//         searchHint: 'Search salon tools, makeup kits...',
//     subcategories: const [
//       'All Cosmetics & Beauty Equipment',
//       'Salon & Spa Equipment',
//       'Makeup Tools & Kits',
//       'Hair Styling Equipment',
//       'Skincare & Facial Devices',
//       'Nail Care Equipment',
//       'Body Care & Grooming Tools',
//       'Fragrance & Diffusion Tools',
//       'Event & Bridal Makeup Gear',
//     ],
//     promoPercent: '25',
//     products: const [
//       CategoryProduct(name: 'Hair Straightener', price: '₹99 / day', image: 'https://picsum.photos/seed/beauty1/200/200', sub: 'Hair Styling Equipment'),
//       CategoryProduct(name: 'Facial Steamer', price: '₹129 / day', image: 'https://picsum.photos/seed/beauty2/200/200', sub: 'Skincare & Facial Devices'),
//       CategoryProduct(name: 'Bridal Makeup Kit', price: '₹399 / day', image: 'https://picsum.photos/seed/beauty3/200/200', sub: 'Event & Bridal Makeup Gear'),
//     ],
//   ),
//   'Private Rental Jets': CategoryData(
//         searchHint: 'Search jets, helicopters, planes...',
//     subcategories: const ['All Private Rental Jets', 'Jet', 'Helicopters', 'Plane'],
//     promoPercent: '10',
//     products: const [
//       CategoryProduct(name: 'Light Private Jet', price: '₹4,50,000 / day', image: 'https://picsum.photos/seed/jet1/200/200', sub: 'Jet'),
//       CategoryProduct(name: 'Charter Helicopter', price: '₹1,20,000 / day', image: 'https://picsum.photos/seed/jet2/200/200', sub: 'Helicopters'),
//     ],
//   ),
//   'Boats & Yachts': CategoryData(
//         searchHint: 'Search boats, yachts...',
//     subcategories: const ['All Boats & Yachts', 'Boat Types', 'Yacht Types'],
//     promoPercent: '15',
//     products: const [
//       CategoryProduct(name: 'Speed Boat', price: '₹8,999 / day', image: 'https://picsum.photos/seed/boat1/200/200', sub: 'Boat Types'),
//       CategoryProduct(name: 'Luxury Yacht', price: '₹49,999 / day', image: 'https://picsum.photos/seed/boat2/200/200', sub: 'Yacht Types'),
//     ],
//   ),
//   'Musical Instruments': CategoryData(
//         searchHint: 'Search guitars, keyboards, drums...',
//     subcategories: const [
//       'All Musical Instruments',
//       'String Instruments',
//       'Percussion Instruments',
//       'Keyboard Instruments',
//       'Wind Instruments',
//       'Electronic Instruments & Gear',
//       'Traditional & Folk Instruments',
//       'Accessories & Stands',
//     ],
//     promoPercent: '20',
//     products: const [
//       CategoryProduct(name: 'Acoustic Guitar', price: '₹149 / day', image: 'https://picsum.photos/seed/music1/200/200', sub: 'String Instruments'),
//       CategoryProduct(name: 'Electronic Keyboard', price: '₹299 / day', image: 'https://picsum.photos/seed/music2/200/200', sub: 'Keyboard Instruments'),
//       CategoryProduct(name: 'Tabla Set', price: '₹199 / day', image: 'https://picsum.photos/seed/music3/200/200', sub: 'Traditional & Folk Instruments'),
//     ],
//   ),
//   'Home Appliances': CategoryData(
//         searchHint: 'Search fridge, washer, AC...',
//     subcategories: const [
//       'All Home Appliances',
//       'Kitchen Appliances',
//       'Laundry Appliances',
//       'Cleaning Appliances',
//       'Cooling & Heating Devices',
//       'Personal Care Appliances',
//       'Home Utility Devices',
//       'Entertainment & Lifestyle',
//       'Miscellaneous Appliances',
//     ],
//     promoPercent: '30',
//     products: const [
//       CategoryProduct(name: 'LG Double Door Fridge', price: '₹699 / day', image: 'https://picsum.photos/seed/home1/200/200', sub: 'Kitchen Appliances'),
//       CategoryProduct(name: 'Washing Machine', price: '₹249 / day', image: 'https://picsum.photos/seed/home2/200/200', sub: 'Laundry Appliances'),
//       CategoryProduct(name: 'Voltas 1.5 Ton AC', price: '₹699 / day', image: 'https://picsum.photos/seed/home3/200/200', sub: 'Cooling & Heating Devices'),
//     ],
//   ),
//   'Party & Event Supplies': CategoryData(
//         searchHint: 'Search decor, lighting, sound...',
//     subcategories: const [
//       'All Party & Event Supplies',
//       'Furniture & Seating',
//       'Lighting & Decor',
//       'Sound & Music Systems',
//       'Event Essentials',
//       'Catering Equipment',
//       'Thematic Props & Decor',
//       'Event Accessories',
//       'Special Effects',
//       'Kids Party Supplies',
//       'Miscellaneous',
//     ],
//     promoPercent: '30',
//     products: const [
//       CategoryProduct(name: 'LED Party Lights', price: '₹199 / day', image: 'https://picsum.photos/seed/party1/200/200', sub: 'Lighting & Decor'),
//       CategoryProduct(name: 'Sound System', price: '₹599 / day', image: 'https://picsum.photos/seed/party2/200/200', sub: 'Sound & Music Systems'),
//       CategoryProduct(name: 'Event Tent', price: '₹1,099 / day', image: 'https://picsum.photos/seed/party3/200/200', sub: 'Event Essentials'),
//     ],
//   ),
//   'Party Halls': CategoryData(
//         searchHint: 'Search banquet halls, lawns, venues...',
//     subcategories: const [
//       'All Party Halls',
//       'Banquet Halls',
//       'Community Halls',
//       'Rooftop Venues',
//       'Garden Party Lawns',
//       'Open-Air Venues',
//       'Farmhouse',
//       'Co-working Event Spaces',
//       'Private Villas',
//       'Indoor Ballrooms',
//       'Hotel Conference Rooms',
//       'Heritage Venue',
//       'Clubhouses',
//     ],
//     promoPercent: '15',
//     products: const [
//       CategoryProduct(name: 'Grand Banquet Hall', price: '₹49,999 / day', image: 'https://picsum.photos/seed/hall1/200/200', sub: 'Banquet Halls'),
//       CategoryProduct(name: 'Rooftop Venue', price: '₹19,999 / day', image: 'https://picsum.photos/seed/hall2/200/200', sub: 'Rooftop Venues'),
//       CategoryProduct(name: 'Garden Farmhouse', price: '₹29,999 / day', image: 'https://picsum.photos/seed/hall3/200/200', sub: 'Farmhouse'),
//     ],
//   ),
//   'Rental House & Apartments': CategoryData(
//         searchHint: 'Search apartments, villas, PGs...',
//     subcategories: const [
//       'All Rental House & Apartments',
//       'Studio Apartments',
//       '1BHK',
//       '2BHK',
//       '3BHK +',
//       'Villas',
//       'Duplexes',
//       'Independent Houses',
//       'Penthouse Apartments',
//       'Service Apartments',
//       'Farmhouses',
//       'PGs (Paying Guests)',
//       'Hostels (Male/Female)',
//       'Shared Rooms',
//       'Guest Houses',
//     ],
//     promoPercent: '10',
//     products: const [
//       CategoryProduct(name: '2BHK Apartment', price: '₹2,499 / day', image: 'https://picsum.photos/seed/house1/200/200', sub: '2BHK'),
//       CategoryProduct(name: 'Luxury Villa', price: '₹9,999 / day', image: 'https://picsum.photos/seed/house2/200/200', sub: 'Villas'),
//       CategoryProduct(name: 'PG Room', price: '₹499 / day', image: 'https://picsum.photos/seed/house3/200/200', sub: 'PGs (Paying Guests)'),
//     ],
//   ),
//   'Medical Equipment': CategoryData(
//         searchHint: 'Search wheelchairs, monitors, aids...',
//     subcategories: const [
//       'All Medical Equipment',
//       'Home Care Equipment',
//       'Respiratory Devices',
//       'Monitoring Equipment',
//       'Mobility Aids',
//       'Post-Surgical & Recovery Aids',
//       'Diagnostic Tools',
//       'Mother & Baby Care',
//       'Physiotherapy Devices',
//       'Sanitization & Safety',
//       'Specialty Equipment',
//     ],
//     promoPercent: '20',
//     products: const [
//       CategoryProduct(name: 'Wheelchair', price: '₹99 / day', image: 'https://picsum.photos/seed/med1/200/200', sub: 'Mobility Aids'),
//       CategoryProduct(name: 'Oxygen Concentrator', price: '₹299 / day', image: 'https://picsum.photos/seed/med2/200/200', sub: 'Respiratory Devices'),
//       CategoryProduct(name: 'BP Monitor', price: '₹49 / day', image: 'https://picsum.photos/seed/med3/200/200', sub: 'Monitoring Equipment'),
//     ],
//   ),
//   'Camping & Outdoor Gear': CategoryData(
//         searchHint: 'Search tents, backpacks, gear...',
//     subcategories: const [
//       'All Camping & Outdoor Gear',
//       'Shelter & Sleeping Gear',
//       'Cooking & Food Storage',
//       'Lighting & Power',
//       'Backpacks & Carriers',
//       'Navigation & Safety',
//       'Furniture & Comfort',
//       'Clothing & Accessories',
//       'Outdoor Activity Gear',
//       'Water Gear & Hydration',
//       'Kids & Family Camping',
//       'Eco-Friendly Supplies',
//     ],
//     promoPercent: '30',
//     products: const [
//       CategoryProduct(name: 'Camping Tent (4-Person)', price: '₹299 / day', image: 'https://picsum.photos/seed/camp1/200/200', sub: 'Shelter & Sleeping Gear'),
//       CategoryProduct(name: 'Portable Camping Stove', price: '₹149 / day', image: 'https://picsum.photos/seed/camp2/200/200', sub: 'Cooking & Food Storage'),
//       CategoryProduct(name: 'Hiking Backpack', price: '₹99 / day', image: 'https://picsum.photos/seed/camp3/200/200', sub: 'Backpacks & Carriers'),
//     ],
//   ),
//   'Construction Equipment': CategoryData(
//         searchHint: 'Search excavators, scaffolding...',
//     subcategories: const [
//       'All Construction Equipment',
//       'Earthmoving Equipment',
//       'Material Handling Equipment',
//       'Concrete & Cement Equipment',
//       'Compaction Equipment',
//       'Road Construction Machinery',
//       'Lifting & Access Equipment',
//       'Demolition Equipment',
//       'Power Tools & Generators',
//       'Surveying & Measurement Tools',
//       'Scaffolding & Support',
//       'Safety Gear & Accessories',
//       'Site Infrastructure',
//     ],
//     promoPercent: '15',
//     products: const [
//       CategoryProduct(name: 'Mini Excavator', price: '₹3,999 / day', image: 'https://picsum.photos/seed/const1/200/200', sub: 'Earthmoving Equipment'),
//       CategoryProduct(name: 'Concrete Mixer', price: '₹599 / day', image: 'https://picsum.photos/seed/const2/200/200', sub: 'Concrete & Cement Equipment'),
//       CategoryProduct(name: 'Scaffolding Set', price: '₹399 / day', image: 'https://picsum.photos/seed/const3/200/200', sub: 'Scaffolding & Support'),
//     ],
//   ),
//   'Wedding & Formal Wear': CategoryData(
//         searchHint: 'Search sherwanis, gowns, lehengas...',
//     subcategories: const [
//       'All Wedding & Formal Wear',
//       "Men's Formal Wear",
//       "Women's Wedding Wear",
//       "Kids' Occasion Wear",
//       'Footwear',
//       'Accessories',
//       'Bridal & Groom Sets',
//       'Special Occasion Categories',
//       'Luxury Designer Wear',
//       'Seasonal Wear',
//     ],
//     promoPercent: '25',
//     products: const [
//       CategoryProduct(name: 'Designer Sherwani', price: '₹999 / day', image: 'https://picsum.photos/seed/wed1/200/200', sub: "Men's Formal Wear"),
//       CategoryProduct(name: 'Bridal Lehenga', price: '₹2,499 / day', image: 'https://picsum.photos/seed/wed2/200/200', sub: "Women's Wedding Wear"),
//       CategoryProduct(name: 'Bridal & Groom Combo Set', price: '₹3,999 / day', image: 'https://picsum.photos/seed/wed3/200/200', sub: 'Bridal & Groom Sets'),
//     ],
//   ),
//   'Gardening Tools & Equipment': CategoryData(
//         searchHint: 'Search mowers, hand tools...',
//     subcategories: const [
//       'All Gardening Tools & Equipment',
//       'Hand Tools',
//       'Power Tools',
//       'Watering Equipment',
//       'Planting & Soil Equipment',
//       'Protective & Utility Gear',
//       'Containers & Support',
//       'Garden Maintenance',
//       'Specialty Tools',
//       'Kids Gardening Tools',
//     ],
//     promoPercent: '20',
//     products: const [
//       CategoryProduct(name: 'Lawn Mower', price: '₹299 / day', image: 'https://picsum.photos/seed/garden1/200/200', sub: 'Power Tools'),
//       CategoryProduct(name: 'Garden Hand Tool Set', price: '₹99 / day', image: 'https://picsum.photos/seed/garden2/200/200', sub: 'Hand Tools'),
//       CategoryProduct(name: 'Watering Hose Kit', price: '₹79 / day', image: 'https://picsum.photos/seed/garden3/200/200', sub: 'Watering Equipment'),
//     ],
//   ),
//   'Office Equipment (Printers, Projectors, Desks)': CategoryData(
//         searchHint: 'Search printers, projectors, desks...',
//     subcategories: const [
//       'All Office Equipment',
//       'Printing & Scanning Devices',
//       'Presentation Equipment',
//       'Desks & Workstations',
//       'Seating',
//       'Computing Accessories',
//       'Storage & Organization',
//       'Networking & Connectivity Devices',
//       'Communication Tools',
//       'Office Lighting & Ambience',
//       'Office Décor & Supplies',
//       'Specialty Office Equipment',
//     ],
//     promoPercent: '20',
//     products: const [
//       CategoryProduct(name: 'Laser Printer', price: '₹149 / day', image: 'https://picsum.photos/seed/office1/200/200', sub: 'Printing & Scanning Devices'),
//       CategoryProduct(name: 'HD Projector', price: '₹299 / day', image: 'https://picsum.photos/seed/office2/200/200', sub: 'Presentation Equipment'),
//       CategoryProduct(name: 'Standing Desk', price: '₹199 / day', image: 'https://picsum.photos/seed/office3/200/200', sub: 'Desks & Workstations'),
//     ],
//   ),
//   'Photography & Videography Equipment': CategoryData(
//         searchHint: 'Search cameras, lenses, lighting...',
//     subcategories: const [
//       'All Photography & Videography Equipment',
//       'Cameras',
//       'Lenses & Optics',
//       'Lighting Equipment',
//       'Tripods & Stabilizers',
//       'Audio Gear',
//       'Video Production Equipment',
//       'Backdrops & Sets',
//       'Storage & Power',
//       'Accessories & Mounts',
//       'Drones & Aerial Gear',
//       'Post-Production Tools',
//     ],
//     promoPercent: '20',
//     products: const [
//       CategoryProduct(name: 'Canon EOS R6', price: '₹899 / day', image: 'https://picsum.photos/seed/photo1/200/200', sub: 'Cameras'),
//       CategoryProduct(name: 'Studio Lighting Kit', price: '₹399 / day', image: 'https://picsum.photos/seed/photo2/200/200', sub: 'Lighting Equipment'),
//       CategoryProduct(name: 'DJI Mini 4 Drone', price: '₹1,199 / day', image: 'https://picsum.photos/seed/photo3/200/200', sub: 'Drones & Aerial Gear'),
//     ],
//   ),
//   'Luxury Cars & Supercars': CategoryData(
//         searchHint: 'Search luxury sedans, supercars...',
//     subcategories: const [
//       'All Luxury Cars & Supercars',
//       'Luxury Sedans',
//       'Luxury SUVs',
//       'Sports Cars',
//       'Supercars & Hypercars',
//       'Convertibles',
//       'Coupes & Grand Tourers',
//       'Electric Luxury Cars',
//       'Chauffeur Services Add-on',
//       'Event & Wedding Packages',
//       'Special Editions',
//     ],
//     promoPercent: '10',
//     products: const [
//       CategoryProduct(name: 'Mercedes S-Class', price: '₹24,999 / day', image: 'https://picsum.photos/seed/luxcar1/200/200', sub: 'Luxury Sedans'),
//       CategoryProduct(name: 'Lamborghini Huracán', price: '₹99,999 / day', image: 'https://picsum.photos/seed/luxcar2/200/200', sub: 'Supercars & Hypercars'),
//       CategoryProduct(name: 'Range Rover Vogue', price: '₹19,999 / day', image: 'https://picsum.photos/seed/luxcar3/200/200', sub: 'Luxury SUVs'),
//     ],
//   ),
//   'Pet Accessories & Supplies': CategoryData(
//         searchHint: 'Search pet carriers, toys, gear...',
//     subcategories: const [
//       'All Pet Accessories & Supplies',
//       'Pet Furniture',
//       'Pet Apparel',
//       'Feeding Supplies',
//       'Pet Carriers & Travel Gear',
//       'Leashes, Collars & Harnesses',
//       'Toys & Enrichment',
//       'Grooming Equipment',
//       'Training Aids',
//       'Health & Wellness Supplies',
//       'Aquatic & Reptile Supplies',
//       'Pet Cameras & Monitors',
//       'Cleaning & Maintenance',
//       'Event & Costume Rentals',
//       'Pet Play Equipment',
//     ],
//     promoPercent: '25',
//     products: const [
//       CategoryProduct(name: 'Pet Travel Carrier', price: '₹99 / day', image: 'https://picsum.photos/seed/pet1/200/200', sub: 'Pet Carriers & Travel Gear'),
//       CategoryProduct(name: 'Pet Grooming Kit', price: '₹129 / day', image: 'https://picsum.photos/seed/pet2/200/200', sub: 'Grooming Equipment'),
//       CategoryProduct(name: 'Pet Camera Monitor', price: '₹149 / day', image: 'https://picsum.photos/seed/pet3/200/200', sub: 'Pet Cameras & Monitors'),
//     ],
//   ),
//   'Hotels and Resorts': CategoryData(
//         searchHint: 'Search hotels, resorts, villas...',
//     subcategories: const [
//       'All Hotels and Resorts',
//       'Budget Hotels',
//       'Luxury Hotels',
//       'Resorts',
//       'Boutique Hotels',
//       'Business Hotels',
//       'Extended Stay Hotels',
//       'Heritage Hotels',
//       'Eco-Stays & Sustainable Resorts',
//       'Pet-Friendly Stays',
//       'Family Resorts',
//       'Couples Retreats',
//       'Wellness & Spa Retreats',
//       'Adventure Resorts',
//       'Themed Stays',
//       'Private Villas & Bungalows',
//     ],
//     promoPercent: '15',
//     products: const [
//       CategoryProduct(name: 'Budget Hotel Room', price: '₹1,499 / night', image: 'https://picsum.photos/seed/hotel1/200/200', sub: 'Budget Hotels'),
//       CategoryProduct(name: 'Beach Resort Suite', price: '₹8,999 / night', image: 'https://picsum.photos/seed/hotel2/200/200', sub: 'Resorts'),
//       CategoryProduct(name: 'Private Villa', price: '₹14,999 / night', image: 'https://picsum.photos/seed/hotel3/200/200', sub: 'Private Villas & Bungalows'),
//     ],
//   ),
// };

// // Fallback used if a category name isn't found in the map above,
// // so navigation never crashes even if new categories are added later
// // without their data yet.
// CategoryData getCategoryData(String categoryName) {
//   return categoryDataMap[categoryName] ??
//       CategoryData(
//             searchHint: 'Search $categoryName...',
//         subcategories: ['All $categoryName'],
//         promoPercent: '20',
//         products: const [],
//       );
// }

// // Master list of all category names + item counts, used by
// // category_screen.dart's grid. Kept as a plain list here (rather than
// // deriving it from categoryDataMap.keys) so you control the exact
// // tile order and can add a thumbnail image per category.
// final List<Map<String, dynamic>> allCategoriesList = [
//   {'name': 'Furniture', 'image': 'https://picsum.photos/seed/furnituregrid/400/300'},
//   {'name': 'Vehicles', 'image': 'https://picsum.photos/seed/vehiclesgrid/400/300'},
//   {'name': 'Electronics & Devices', 'image': 'https://picsum.photos/seed/electronicsgrid/400/300'},
//   {'name': 'Books & Stationery', 'image': 'https://picsum.photos/seed/booksgrid/400/300'},
//   {'name': 'Clothing & Accessories', 'image': 'https://picsum.photos/seed/clothinggrid/400/300'},
//   {'name': 'Machinery & Tools', 'image': 'https://picsum.photos/seed/machinerygrid/400/300'},
//   {'name': 'Sports Equipment and Gaming', 'image': 'https://picsum.photos/seed/sportsgrid/400/300'},
//   {'name': 'Toys & Baby Gear', 'image': 'https://picsum.photos/seed/toysgrid/400/300'},
//   {'name': 'Cosmetics & Beauty Equipment', 'image': 'https://picsum.photos/seed/beautygrid/400/300'},
//   {'name': 'Private Rental Jets', 'image': 'https://picsum.photos/seed/jetgrid/400/300'},
//   {'name': 'Boats & Yachts', 'image': 'https://picsum.photos/seed/boatgrid/400/300'},
//   {'name': 'Musical Instruments', 'image': 'https://picsum.photos/seed/musicgrid/400/300'},
//   {'name': 'Home Appliances', 'image': 'https://picsum.photos/seed/homeappgrid/400/300'},
//   {'name': 'Party & Event Supplies', 'image': 'https://picsum.photos/seed/partysupgrid/400/300'},
//   {'name': 'Party Halls', 'image': 'https://picsum.photos/seed/hallgrid/400/300'},
//   {'name': 'Rental House & Apartments', 'image': 'https://picsum.photos/seed/housegrid/400/300'},
//   {'name': 'Medical Equipment', 'image': 'https://picsum.photos/seed/medgrid/400/300'},
//   {'name': 'Camping & Outdoor Gear', 'image': 'https://picsum.photos/seed/campgrid/400/300'},
//   {'name': 'Construction Equipment', 'image': 'https://picsum.photos/seed/constgrid/400/300'},
//   {'name': 'Wedding & Formal Wear', 'image': 'https://picsum.photos/seed/weddinggrid/400/300'},
//   {'name': 'Gardening Tools & Equipment', 'image': 'https://picsum.photos/seed/gardengrid/400/300'},
//   {'name': 'Office Equipment (Printers, Projectors, Desks)', 'image': 'https://picsum.photos/seed/officegrid/400/300'},
//   {'name': 'Photography & Videography Equipment', 'image': 'https://picsum.photos/seed/photogrid/400/300'},
//   {'name': 'Luxury Cars & Supercars', 'image': 'https://picsum.photos/seed/luxcargrid/400/300'},
//   {'name': 'Pet Accessories & Supplies', 'image': 'https://picsum.photos/seed/petgrid/400/300'},
//   {'name': 'Hotels and Resorts', 'image': 'https://picsum.photos/seed/hotelgrid/400/300'},
// ];



// Master data source for the CategoryDetailScreen.
// Each entry maps a category name (as used in CategoryScreen's grid) to
// its results count, search hint, sidebar/chip subcategories, promo copy,
// and product list. Add a new category by adding a new entry here —
// CategoryDetailScreen looks itself up by name automatically.
import 'package:flutter/material.dart';

/// Renders either a local asset path or a network URL, so `image`
/// fields in allCategoriesList can be either without breaking.
Widget categoryImage(
  String path, {
  required double width,
  required double height,
  BoxFit fit = BoxFit.cover,
}) {
  final isNetwork = path.startsWith('http');
  final errorBuilder = (BuildContext context, Object error, StackTrace? stackTrace) => Container(
        width: width,
        height: height,
        color: const Color(0xFFF3F4F6),
        child: const Icon(Icons.image_outlined, color: Colors.grey),
      );

  return isNetwork
      ? Image.network(path, width: width, height: height, fit: fit, errorBuilder: errorBuilder)
      : Image.asset(path, width: width, height: height, fit: fit, errorBuilder: errorBuilder);
}

class CategoryProduct {
  final String name;
  final String price;
  final String image;
  final String sub;

  const CategoryProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.sub,
  });
}

class CategoryData {
  final String searchHint;
  final List<String> subcategories;
  final String promoPercent;
  final List<CategoryProduct> products;

  // FIX: new flag. True for categories where the item is booked for a
  // fixed occasion/stay rather than day-to-day rented (jets, boats,
  // party halls, hotels) — ProductDetailsScreen reads this to show
  // "BOOK NOW" instead of "RENT NOW" for products in these categories.
  final bool isBookingCategory;

  const CategoryData({
    required this.searchHint,
    required this.subcategories,
    required this.promoPercent,
    required this.products,
    this.isBookingCategory = false,
  });

  // Live count — always matches however many products are actually
  // listed above, instead of a hardcoded number that can drift out
  // of sync.
  int get resultsCount => products.length;
}

final Map<String, CategoryData> categoryDataMap = {
  'Furniture': CategoryData(
       searchHint: 'Search sofas, beds, tables...',
    subcategories: const [
      'All Furniture',
      'Home Furniture',
      'Office & Workspace Furniture',
      'Outdoor & Garden Furniture',
      'Kids & Baby Furniture',
      'Event & Party Furniture',
      'Smart & Tech-Integrated Furniture',
      'Specialty & Luxury Furniture',
    ],
    promoPercent: '30',
    products: const [
      CategoryProduct(name: 'Sofa 3 Seater', price: '₹699 / day', image: 'https://picsum.photos/seed/furn1/200/200', sub: 'Home Furniture'),
      CategoryProduct(name: 'Ergonomic Office Chair', price: '₹249 / day', image: 'https://picsum.photos/seed/furn2/200/200', sub: 'Office & Workspace Furniture'),
      CategoryProduct(name: 'Garden Bench Set', price: '₹399 / day', image: 'https://picsum.photos/seed/furn3/200/200', sub: 'Outdoor & Garden Furniture'),
      CategoryProduct(name: 'Kids Bunk Bed', price: '₹349 / day', image: 'https://picsum.photos/seed/furn4/200/200', sub: 'Kids & Baby Furniture'),
      CategoryProduct(name: 'Party Folding Tables', price: '₹199 / day', image: 'https://picsum.photos/seed/furn5/200/200', sub: 'Event & Party Furniture'),
    ],
  ),
  'Vehicles': CategoryData(
        searchHint: 'Search bikes, cars, scooters...',
    subcategories: const [
      'All Vehicles',
      'Two-Wheelers',
      'Three-Wheelers',
      'Four-Wheelers',
      'Cycle',
      'Commercial & Heavy Vehicles',
      'Rental & Recreational Vehicles',
    ],
    promoPercent: '20',
    products: const [
      CategoryProduct(name: 'Honda Activa 6G', price: '₹249 / day', image: 'https://picsum.photos/seed/veh1/200/200', sub: 'Two-Wheelers'),
      CategoryProduct(name: 'Auto Rickshaw', price: '₹399 / day', image: 'https://picsum.photos/seed/veh2/200/200', sub: 'Three-Wheelers'),
      CategoryProduct(name: 'Hyundai i20', price: '₹1,599 / day', image: 'https://picsum.photos/seed/veh3/200/200', sub: 'Four-Wheelers'),
      CategoryProduct(name: 'Mountain Bike', price: '₹149 / day', image: 'https://picsum.photos/seed/veh4/200/200', sub: 'Cycle'),
      CategoryProduct(name: 'Mini Delivery Truck', price: '₹2,199 / day', image: 'https://picsum.photos/seed/veh5/200/200', sub: 'Commercial & Heavy Vehicles'),
    ],
  ),
  'Electronics & Devices': CategoryData(
        searchHint: 'Search laptops, cameras, audio...',
    subcategories: const [
      'All Electronics & Devices',
      'Personal Electronics',
      'Computing Devices',
      'Cameras & Photography Equipment',
      'Audio & Music Equipment',
      'Gaming & Accessories',
      'Home Appliances & Smart Home Devices',
      'Office & Productivity Electronics',
      'Kitchen & Cooking Appliances',
      'Wearable Tech & Health Devices',
      'Specialized & Industrial Electronics',
    ],
    promoPercent: '25',
    products: const [
      CategoryProduct(name: 'iPhone 15', price: '₹799 / day', image: 'https://picsum.photos/seed/elec1/200/200', sub: 'Personal Electronics'),
      CategoryProduct(name: 'MacBook Air M2', price: '₹999 / day', image: 'https://picsum.photos/seed/elec2/200/200', sub: 'Computing Devices'),
      CategoryProduct(name: 'Canon DSLR 1200D', price: '₹599 / day', image: 'https://picsum.photos/seed/elec3/200/200', sub: 'Cameras & Photography Equipment'),
      CategoryProduct(name: 'Bluetooth Speaker', price: '₹199 / day', image: 'https://picsum.photos/seed/elec4/200/200', sub: 'Audio & Music Equipment'),
      CategoryProduct(name: 'PlayStation 5', price: '₹599 / day', image: 'https://picsum.photos/seed/elec5/200/200', sub: 'Gaming & Accessories'),
    ],
  ),
  'Books & Stationery': CategoryData(
        searchHint: 'Search books, notebooks, pens...',
    subcategories: const [
      'All Books & Stationery',
      'Textbooks & Academic Materials',
      'Competitive Exams & Professional Prep',
      'Fiction & Literature',
      'Non-Fiction & General Knowledge',
      'Science, Technology, and Medical',
      'Religious, Spiritual & Mythology',
      'Children & Teen Books',
      'Magazines & Periodicals',
      'Digital & Audio Formats',
      'Writing Tools',
      'Paper Products',
      'Organizers & Filing',
      'Art & Creative Supplies',
      'Mathematical & Technical Tools',
      'School & College Essentials',
      'Office & Professional Stationery',
      'Presentation Tools',
      'Labeling & Personalization',
      'Calligraphy & Design',
    ],
    promoPercent: '30',
    products: const [
      CategoryProduct(name: 'Engineering Textbook Set', price: '₹49 / day', image: 'https://picsum.photos/seed/book1/200/200', sub: 'Textbooks & Academic Materials'),
      CategoryProduct(name: 'The Alchemist', price: '₹29 / day', image: 'https://picsum.photos/seed/book2/200/200', sub: 'Fiction & Literature'),
      CategoryProduct(name: 'Drafting Tool Kit', price: '₹39 / day', image: 'https://picsum.photos/seed/book3/200/200', sub: 'Mathematical & Technical Tools'),
      CategoryProduct(name: 'Calligraphy Pen Set', price: '₹59 / day', image: 'https://picsum.photos/seed/book4/200/200', sub: 'Calligraphy & Design'),
    ],
  ),
  'Clothing & Accessories': CategoryData(
        searchHint: 'Search dresses, suits, footwear...',
    subcategories: const [
      'All Clothing & Accessories',
      "Men's Clothing",
      "Women's Clothing",
      "Kid's Clothing",
      'Seasonal & Specialty Wear',
      'Wedding & Formal Wear',
      'Footwear',
      'Accessories',
      'Jewelry & Fashion Accessories',
    ],
    promoPercent: '25',
    products: const [
      CategoryProduct(name: 'Formal Blazer', price: '₹299 / day', image: 'https://picsum.photos/seed/cloth1/200/200', sub: "Men's Clothing"),
      CategoryProduct(name: 'Designer Saree', price: '₹499 / day', image: 'https://picsum.photos/seed/cloth2/200/200', sub: "Women's Clothing"),
      CategoryProduct(name: 'Party Shoes', price: '₹199 / day', image: 'https://picsum.photos/seed/cloth3/200/200', sub: 'Footwear'),
      CategoryProduct(name: 'Statement Necklace', price: '₹149 / day', image: 'https://picsum.photos/seed/cloth4/200/200', sub: 'Jewelry & Fashion Accessories'),
    ],
  ),
  'Machinery & Tools': CategoryData(
        searchHint: 'Search drills, generators, tools...',
    subcategories: const [
      'All Machinery & Tools',
      'Construction Machinery',
      'Agricultural Machinery',
      'Industrial Machinery',
      'Power Tools',
      'Hand Tools',
      'Gardening Tools & Equipment',
      'Safety & Support Equipment',
      'Testing & Measuring Tools',
      'Miscellaneous Tools & Machines',
    ],
    promoPercent: '20',
    products: const [
      CategoryProduct(name: 'Cordless Drill', price: '₹149 / day', image: 'https://picsum.photos/seed/mach1/200/200', sub: 'Power Tools'),
      CategoryProduct(name: 'Tractor (Mini)', price: '₹1,999 / day', image: 'https://picsum.photos/seed/mach2/200/200', sub: 'Agricultural Machinery'),
      CategoryProduct(name: 'Digital Multimeter', price: '₹99 / day', image: 'https://picsum.photos/seed/mach3/200/200', sub: 'Testing & Measuring Tools'),
    ],
  ),
  'Sports Equipment and Gaming': CategoryData(
        searchHint: 'Search fitness, cricket, gaming gear...',
    subcategories: const [
      'All Sports Equipment and Gaming',
      'Outdoor Sports',
      'Indoor Sports',
      'Fitness & Gym Equipment',
      'Adventure & Outdoor Gear',
      'Athletics Equipment',
      'Water Sports Equipment',
      'Winter Sports Gear',
      'Martial Arts Equipment',
      'Cycling Accessories',
      'Playstation',
      'Miscellaneous Sports Equipment',
    ],
    promoPercent: '30',
    products: const [
      CategoryProduct(name: 'Treadmill', price: '₹699 / day', image: 'https://picsum.photos/seed/sport1/200/200', sub: 'Fitness & Gym Equipment'),
      CategoryProduct(name: 'Cricket Kit', price: '₹299 / day', image: 'https://picsum.photos/seed/sport2/200/200', sub: 'Outdoor Sports'),
      CategoryProduct(name: 'PlayStation 5', price: '₹599 / day', image: 'https://picsum.photos/seed/sport3/200/200', sub: 'Playstation'),
      CategoryProduct(name: 'Surfboard', price: '₹499 / day', image: 'https://picsum.photos/seed/sport4/200/200', sub: 'Water Sports Equipment'),
    ],
  ),
  'Toys & Baby Gear': CategoryData(
        searchHint: 'Search toys, strollers, cribs...',
    subcategories: const [
      'All Toys & Baby Gear',
      'Toys (Infants to Teens)',
      'Baby Gear',
      'Outdoor Play Equipment',
      'Learning & Development Aids',
      'Party & Celebration Toys',
    ],
    promoPercent: '30',
    products: const [
      CategoryProduct(name: 'Baby Stroller', price: '₹149 / day', image: 'https://picsum.photos/seed/toy1/200/200', sub: 'Baby Gear'),
      CategoryProduct(name: 'LEGO Set', price: '₹99 / day', image: 'https://picsum.photos/seed/toy2/200/200', sub: 'Toys (Infants to Teens)'),
      CategoryProduct(name: 'Kids Trampoline', price: '₹249 / day', image: 'https://picsum.photos/seed/toy3/200/200', sub: 'Outdoor Play Equipment'),
    ],
  ),
  'Cosmetics & Beauty Equipment': CategoryData(
        searchHint: 'Search salon tools, makeup kits...',
    subcategories: const [
      'All Cosmetics & Beauty Equipment',
      'Salon & Spa Equipment',
      'Makeup Tools & Kits',
      'Hair Styling Equipment',
      'Skincare & Facial Devices',
      'Nail Care Equipment',
      'Body Care & Grooming Tools',
      'Fragrance & Diffusion Tools',
      'Event & Bridal Makeup Gear',
    ],
    promoPercent: '25',
    products: const [
      CategoryProduct(name: 'Hair Straightener', price: '₹99 / day', image: 'https://picsum.photos/seed/beauty1/200/200', sub: 'Hair Styling Equipment'),
      CategoryProduct(name: 'Facial Steamer', price: '₹129 / day', image: 'https://picsum.photos/seed/beauty2/200/200', sub: 'Skincare & Facial Devices'),
      CategoryProduct(name: 'Bridal Makeup Kit', price: '₹399 / day', image: 'https://picsum.photos/seed/beauty3/200/200', sub: 'Event & Bridal Makeup Gear'),
    ],
  ),
  // ---- BOOKING-STYLE CATEGORIES (isBookingCategory: true) ----
  'Private Rental Jets': CategoryData(
        searchHint: 'Search jets, helicopters, planes...',
    subcategories: const ['All Private Rental Jets', 'Jet', 'Helicopters', 'Plane'],
    promoPercent: '10',
    isBookingCategory: true,
    products: const [
      CategoryProduct(name: 'Light Private Jet', price: '₹4,50,000 / day', image: 'https://picsum.photos/seed/jet1/200/200', sub: 'Jet'),
      CategoryProduct(name: 'Charter Helicopter', price: '₹1,20,000 / day', image: 'https://picsum.photos/seed/jet2/200/200', sub: 'Helicopters'),
    ],
  ),
  'Boats & Yachts': CategoryData(
        searchHint: 'Search boats, yachts...',
    subcategories: const ['All Boats & Yachts', 'Boat Types', 'Yacht Types'],
    promoPercent: '15',
    isBookingCategory: true,
    products: const [
      CategoryProduct(name: 'Speed Boat', price: '₹8,999 / day', image: 'https://picsum.photos/seed/boat1/200/200', sub: 'Boat Types'),
      CategoryProduct(name: 'Luxury Yacht', price: '₹49,999 / day', image: 'https://picsum.photos/seed/boat2/200/200', sub: 'Yacht Types'),
    ],
  ),
  'Musical Instruments': CategoryData(
        searchHint: 'Search guitars, keyboards, drums...',
    subcategories: const [
      'All Musical Instruments',
      'String Instruments',
      'Percussion Instruments',
      'Keyboard Instruments',
      'Wind Instruments',
      'Electronic Instruments & Gear',
      'Traditional & Folk Instruments',
      'Accessories & Stands',
    ],
    promoPercent: '20',
    products: const [
      CategoryProduct(name: 'Acoustic Guitar', price: '₹149 / day', image: 'https://picsum.photos/seed/music1/200/200', sub: 'String Instruments'),
      CategoryProduct(name: 'Electronic Keyboard', price: '₹299 / day', image: 'https://picsum.photos/seed/music2/200/200', sub: 'Keyboard Instruments'),
      CategoryProduct(name: 'Tabla Set', price: '₹199 / day', image: 'https://picsum.photos/seed/music3/200/200', sub: 'Traditional & Folk Instruments'),
    ],
  ),
  'Home Appliances': CategoryData(
        searchHint: 'Search fridge, washer, AC...',
    subcategories: const [
      'All Home Appliances',
      'Kitchen Appliances',
      'Laundry Appliances',
      'Cleaning Appliances',
      'Cooling & Heating Devices',
      'Personal Care Appliances',
      'Home Utility Devices',
      'Entertainment & Lifestyle',
      'Miscellaneous Appliances',
    ],
    promoPercent: '30',
    products: const [
      CategoryProduct(name: 'LG Double Door Fridge', price: '₹699 / day', image: 'https://picsum.photos/seed/home1/200/200', sub: 'Kitchen Appliances'),
      CategoryProduct(name: 'Washing Machine', price: '₹249 / day', image: 'https://picsum.photos/seed/home2/200/200', sub: 'Laundry Appliances'),
      CategoryProduct(name: 'Voltas 1.5 Ton AC', price: '₹699 / day', image: 'https://picsum.photos/seed/home3/200/200', sub: 'Cooling & Heating Devices'),
    ],
  ),
  'Party & Event Supplies': CategoryData(
        searchHint: 'Search decor, lighting, sound...',
    subcategories: const [
      'All Party & Event Supplies',
      'Furniture & Seating',
      'Lighting & Decor',
      'Sound & Music Systems',
      'Event Essentials',
      'Catering Equipment',
      'Thematic Props & Decor',
      'Event Accessories',
      'Special Effects',
      'Kids Party Supplies',
      'Miscellaneous',
    ],
    promoPercent: '30',
    products: const [
      CategoryProduct(name: 'LED Party Lights', price: '₹199 / day', image: 'https://picsum.photos/seed/party1/200/200', sub: 'Lighting & Decor'),
      CategoryProduct(name: 'Sound System', price: '₹599 / day', image: 'https://picsum.photos/seed/party2/200/200', sub: 'Sound & Music Systems'),
      CategoryProduct(name: 'Event Tent', price: '₹1,099 / day', image: 'https://picsum.photos/seed/party3/200/200', sub: 'Event Essentials'),
    ],
  ),
  'Party Halls': CategoryData(
        searchHint: 'Search banquet halls, lawns, venues...',
    subcategories: const [
      'All Party Halls',
      'Banquet Halls',
      'Community Halls',
      'Rooftop Venues',
      'Garden Party Lawns',
      'Open-Air Venues',
      'Farmhouse',
      'Co-working Event Spaces',
      'Private Villas',
      'Indoor Ballrooms',
      'Hotel Conference Rooms',
      'Heritage Venue',
      'Clubhouses',
    ],
    promoPercent: '15',
    isBookingCategory: true,
    products: const [
      CategoryProduct(name: 'Grand Banquet Hall', price: '₹49,999 / day', image: 'https://picsum.photos/seed/hall1/200/200', sub: 'Banquet Halls'),
      CategoryProduct(name: 'Rooftop Venue', price: '₹19,999 / day', image: 'https://picsum.photos/seed/hall2/200/200', sub: 'Rooftop Venues'),
      CategoryProduct(name: 'Garden Farmhouse', price: '₹29,999 / day', image: 'https://picsum.photos/seed/hall3/200/200', sub: 'Farmhouse'),
    ],
  ),
  // 'Rental House & Apartments': CategoryData(
  //       searchHint: 'Search apartments, villas, PGs...',
  //   subcategories: const [
  //     'All Rental House & Apartments',
  //     'Studio Apartments',
  //     '1BHK',
  //     '2BHK',
  //     '3BHK +',
  //     'Villas',
  //     'Duplexes',
  //     'Independent Houses',
  //     'Penthouse Apartments',
  //     'Service Apartments',
  //     'Farmhouses',
  //     'PGs (Paying Guests)',
  //     'Hostels (Male/Female)',
  //     'Shared Rooms',
  //     'Guest Houses',
  //   ],
  //   promoPercent: '10',
  //   products: const [
  //     CategoryProduct(name: '2BHK Apartment', price: '₹2,499 / day', image: 'https://picsum.photos/seed/house1/200/200', sub: '2BHK'),
  //     CategoryProduct(name: 'Luxury Villa', price: '₹9,999 / day', image: 'https://picsum.photos/seed/house2/200/200', sub: 'Villas'),
  //     CategoryProduct(name: 'PG Room', price: '₹499 / day', image: 'https://picsum.photos/seed/house3/200/200', sub: 'PGs (Paying Guests)'),
  //   ],
  // ),
  'Medical Equipment': CategoryData(
        searchHint: 'Search wheelchairs, monitors, aids...',
    subcategories: const [
      'All Medical Equipment',
      'Home Care Equipment',
      'Respiratory Devices',
      'Monitoring Equipment',
      'Mobility Aids',
      'Post-Surgical & Recovery Aids',
      'Diagnostic Tools',
      'Mother & Baby Care',
      'Physiotherapy Devices',
      'Sanitization & Safety',
      'Specialty Equipment',
    ],
    promoPercent: '20',
    products: const [
      CategoryProduct(name: 'Wheelchair', price: '₹99 / day', image: 'https://picsum.photos/seed/med1/200/200', sub: 'Mobility Aids'),
      CategoryProduct(name: 'Oxygen Concentrator', price: '₹299 / day', image: 'https://picsum.photos/seed/med2/200/200', sub: 'Respiratory Devices'),
      CategoryProduct(name: 'BP Monitor', price: '₹49 / day', image: 'https://picsum.photos/seed/med3/200/200', sub: 'Monitoring Equipment'),
    ],
  ),
  'Camping & Outdoor Gear': CategoryData(
        searchHint: 'Search tents, backpacks, gear...',
    subcategories: const [
      'All Camping & Outdoor Gear',
      'Shelter & Sleeping Gear',
      'Cooking & Food Storage',
      'Lighting & Power',
      'Backpacks & Carriers',
      'Navigation & Safety',
      'Furniture & Comfort',
      'Clothing & Accessories',
      'Outdoor Activity Gear',
      'Water Gear & Hydration',
      'Kids & Family Camping',
      'Eco-Friendly Supplies',
    ],
    promoPercent: '30',
    products: const [
      CategoryProduct(name: 'Camping Tent (4-Person)', price: '₹299 / day', image: 'https://picsum.photos/seed/camp1/200/200', sub: 'Shelter & Sleeping Gear'),
      CategoryProduct(name: 'Portable Camping Stove', price: '₹149 / day', image: 'https://picsum.photos/seed/camp2/200/200', sub: 'Cooking & Food Storage'),
      CategoryProduct(name: 'Hiking Backpack', price: '₹99 / day', image: 'https://picsum.photos/seed/camp3/200/200', sub: 'Backpacks & Carriers'),
    ],
  ),
  'Construction Equipment': CategoryData(
        searchHint: 'Search excavators, scaffolding...',
    subcategories: const [
      'All Construction Equipment',
      'Earthmoving Equipment',
      'Material Handling Equipment',
      'Concrete & Cement Equipment',
      'Compaction Equipment',
      'Road Construction Machinery',
      'Lifting & Access Equipment',
      'Demolition Equipment',
      'Power Tools & Generators',
      'Surveying & Measurement Tools',
      'Scaffolding & Support',
      'Safety Gear & Accessories',
      'Site Infrastructure',
    ],
    promoPercent: '15',
    products: const [
      CategoryProduct(name: 'Mini Excavator', price: '₹3,999 / day', image: 'https://picsum.photos/seed/const1/200/200', sub: 'Earthmoving Equipment'),
      CategoryProduct(name: 'Concrete Mixer', price: '₹599 / day', image: 'https://picsum.photos/seed/const2/200/200', sub: 'Concrete & Cement Equipment'),
      CategoryProduct(name: 'Scaffolding Set', price: '₹399 / day', image: 'https://picsum.photos/seed/const3/200/200', sub: 'Scaffolding & Support'),
    ],
  ),
  'Wedding & Formal Wear': CategoryData(
        searchHint: 'Search sherwanis, gowns, lehengas...',
    subcategories: const [
      'All Wedding & Formal Wear',
      "Men's Formal Wear",
      "Women's Wedding Wear",
      "Kids' Occasion Wear",
      'Footwear',
      'Accessories',
      'Bridal & Groom Sets',
      'Special Occasion Categories',
      'Luxury Designer Wear',
      'Seasonal Wear',
    ],
    promoPercent: '25',
    products: const [
      CategoryProduct(name: 'Designer Sherwani', price: '₹999 / day', image: 'https://picsum.photos/seed/wed1/200/200', sub: "Men's Formal Wear"),
      CategoryProduct(name: 'Bridal Lehenga', price: '₹2,499 / day', image: 'https://picsum.photos/seed/wed2/200/200', sub: "Women's Wedding Wear"),
      CategoryProduct(name: 'Bridal & Groom Combo Set', price: '₹3,999 / day', image: 'https://picsum.photos/seed/wed3/200/200', sub: 'Bridal & Groom Sets'),
    ],
  ),
  'Gardening Tools & Equipment': CategoryData(
        searchHint: 'Search mowers, hand tools...',
    subcategories: const [
      'All Gardening Tools & Equipment',
      'Hand Tools',
      'Power Tools',
      'Watering Equipment',
      'Planting & Soil Equipment',
      'Protective & Utility Gear',
      'Containers & Support',
      'Garden Maintenance',
      'Specialty Tools',
      'Kids Gardening Tools',
    ],
    promoPercent: '20',
    products: const [
      CategoryProduct(name: 'Lawn Mower', price: '₹299 / day', image: 'https://picsum.photos/seed/garden1/200/200', sub: 'Power Tools'),
      CategoryProduct(name: 'Garden Hand Tool Set', price: '₹99 / day', image: 'https://picsum.photos/seed/garden2/200/200', sub: 'Hand Tools'),
      CategoryProduct(name: 'Watering Hose Kit', price: '₹79 / day', image: 'https://picsum.photos/seed/garden3/200/200', sub: 'Watering Equipment'),
    ],
  ),
  'Office Equipment (Printers, Projectors, Desks)': CategoryData(
        searchHint: 'Search printers, projectors, desks...',
    subcategories: const [
      'All Office Equipment',
      'Printing & Scanning Devices',
      'Presentation Equipment',
      'Desks & Workstations',
      'Seating',
      'Computing Accessories',
      'Storage & Organization',
      'Networking & Connectivity Devices',
      'Communication Tools',
      'Office Lighting & Ambience',
      'Office Décor & Supplies',
      'Specialty Office Equipment',
    ],
    promoPercent: '20',
    products: const [
      CategoryProduct(name: 'Laser Printer', price: '₹149 / day', image: 'https://picsum.photos/seed/office1/200/200', sub: 'Printing & Scanning Devices'),
      CategoryProduct(name: 'HD Projector', price: '₹299 / day', image: 'https://picsum.photos/seed/office2/200/200', sub: 'Presentation Equipment'),
      CategoryProduct(name: 'Standing Desk', price: '₹199 / day', image: 'https://picsum.photos/seed/office3/200/200', sub: 'Desks & Workstations'),
    ],
  ),
  'Photography & Videography Equipment': CategoryData(
        searchHint: 'Search cameras, lenses, lighting...',
    subcategories: const [
      'All Photography & Videography Equipment',
      'Cameras',
      'Lenses & Optics',
      'Lighting Equipment',
      'Tripods & Stabilizers',
      'Audio Gear',
      'Video Production Equipment',
      'Backdrops & Sets',
      'Storage & Power',
      'Accessories & Mounts',
      'Drones & Aerial Gear',
      'Post-Production Tools',
    ],
    promoPercent: '20',
    products: const [
      CategoryProduct(name: 'Canon EOS R6', price: '₹899 / day', image: 'https://picsum.photos/seed/photo1/200/200', sub: 'Cameras'),
      CategoryProduct(name: 'Studio Lighting Kit', price: '₹399 / day', image: 'https://picsum.photos/seed/photo2/200/200', sub: 'Lighting Equipment'),
      CategoryProduct(name: 'DJI Mini 4 Drone', price: '₹1,199 / day', image: 'https://picsum.photos/seed/photo3/200/200', sub: 'Drones & Aerial Gear'),
    ],
  ),
  'Luxury Cars & Supercars': CategoryData(
        searchHint: 'Search luxury sedans, supercars...',
    subcategories: const [
      'All Luxury Cars & Supercars',
      'Luxury Sedans',
      'Luxury SUVs',
      'Sports Cars',
      'Supercars & Hypercars',
      'Convertibles',
      'Coupes & Grand Tourers',
      'Electric Luxury Cars',
      'Chauffeur Services Add-on',
      'Event & Wedding Packages',
      'Special Editions',
    ],
    promoPercent: '10',
    products: const [
      CategoryProduct(name: 'Mercedes S-Class', price: '₹24,999 / day', image: 'https://picsum.photos/seed/luxcar1/200/200', sub: 'Luxury Sedans'),
      CategoryProduct(name: 'Lamborghini Huracán', price: '₹99,999 / day', image: 'https://picsum.photos/seed/luxcar2/200/200', sub: 'Supercars & Hypercars'),
      CategoryProduct(name: 'Range Rover Vogue', price: '₹19,999 / day', image: 'https://picsum.photos/seed/luxcar3/200/200', sub: 'Luxury SUVs'),
    ],
  ),
  'Pet Accessories & Supplies': CategoryData(
        searchHint: 'Search pet carriers, toys, gear...',
    subcategories: const [
      'All Pet Accessories & Supplies',
      'Pet Furniture',
      'Pet Apparel',
      'Feeding Supplies',
      'Pet Carriers & Travel Gear',
      'Leashes, Collars & Harnesses',
      'Toys & Enrichment',
      'Grooming Equipment',
      'Training Aids',
      'Health & Wellness Supplies',
      'Aquatic & Reptile Supplies',
      'Pet Cameras & Monitors',
      'Cleaning & Maintenance',
      'Event & Costume Rentals',
      'Pet Play Equipment',
    ],
    promoPercent: '25',
    products: const [
      CategoryProduct(name: 'Pet Travel Carrier', price: '₹99 / day', image: 'https://picsum.photos/seed/pet1/200/200', sub: 'Pet Carriers & Travel Gear'),
      CategoryProduct(name: 'Pet Grooming Kit', price: '₹129 / day', image: 'https://picsum.photos/seed/pet2/200/200', sub: 'Grooming Equipment'),
      CategoryProduct(name: 'Pet Camera Monitor', price: '₹149 / day', image: 'https://picsum.photos/seed/pet3/200/200', sub: 'Pet Cameras & Monitors'),
    ],
  ),
  'Hotels and Resorts': CategoryData(
        searchHint: 'Search hotels, resorts, villas...',
    subcategories: const [
      'All Hotels and Resorts',
      'Budget Hotels',
      'Luxury Hotels',
      'Resorts',
      'Boutique Hotels',
      'Business Hotels',
      'Extended Stay Hotels',
      'Heritage Hotels',
      'Eco-Stays & Sustainable Resorts',
      'Pet-Friendly Stays',
      'Family Resorts',
      'Couples Retreats',
      'Wellness & Spa Retreats',
      'Adventure Resorts',
      'Themed Stays',
      'Private Villas & Bungalows',
    ],
    promoPercent: '15',
    isBookingCategory: true,
    products: const [
      CategoryProduct(name: 'Budget Hotel Room', price: '₹1,499 / night', image: 'https://picsum.photos/seed/hotel1/200/200', sub: 'Budget Hotels'),
      CategoryProduct(name: 'Beach Resort Suite', price: '₹8,999 / night', image: 'https://picsum.photos/seed/hotel2/200/200', sub: 'Resorts'),
      CategoryProduct(name: 'Private Villa', price: '₹14,999 / night', image: 'https://picsum.photos/seed/hotel3/200/200', sub: 'Private Villas & Bungalows'),
    ],
  ),
};

// Fallback used if a category name isn't found in the map above,
// so navigation never crashes even if new categories are added later
// without their data yet.
CategoryData getCategoryData(String categoryName) {
  return categoryDataMap[categoryName] ??
      CategoryData(
            searchHint: 'Search $categoryName...',
        subcategories: ['All $categoryName'],
        promoPercent: '20',
        products: const [],
      );
}

// Master list of all category names + item counts, used by
// category_screen.dart's grid. Kept as a plain list here (rather than
// deriving it from categoryDataMap.keys) so you control the exact
// tile order and can add a thumbnail image per category.
final List<Map<String, dynamic>> allCategoriesList = [
  {'name': 'Furniture', 'image': 'assets/images/rental/categories/Furniture.png'},
  {'name': 'Vehicles', 'image': 'assets/images/rental/categories/vehicle.png'},
  {'name': 'Electronics & Devices', 'image': 'assets/images/rental/categories/Electronics & Devices.png'},
  {'name': 'Books & Stationery', 'image': 'assets/images/rental/categories/Books & Stationery.png'},
  {'name': 'Clothing & Accessories', 'image': 'assets/images/rental/categories/clothing and accessories.png'},
  {'name': 'Machinery & Tools', 'image': 'assets/images/rental/categories/machinery & tools.png'},
  {'name': 'Sports Equipment and Gaming', 'image': 'assets/images/rental/categories/sports & gaming.png'},
  {'name': 'Toys & Baby Gear', 'image': 'assets/images/rental/categories/toys and baby gear.png'},
  {'name': 'Cosmetics & Beauty Equipment', 'image': 'assets/images/rental/categories/cosmetics & beauty product.png'},
  {'name': 'Private Rental Jets', 'image': 'assets/images/rental/categories/private jet.png'},
  {'name': 'Boats & Yachts', 'image': 'assets/images/rental/categories/boats & yachts.png'},
  {'name': 'Musical Instruments', 'image': 'assets/images/rental/categories/Musical Instruments.png'},
  {'name': 'Home Appliances', 'image': 'assets/images/rental/categories/Home appliances.png'},
  {'name': 'Party & Event Supplies', 'image': 'assets/images/rental/categories/Party & Event supply.png'},
  {'name': 'Party Halls', 'image': 'assets/images/rental/categories/party Halls.png'},
  //{'name': 'Rental House & Apartments', 'image': 'https://picsum.photos/seed/housegrid/400/300'}, // no file provided for this one yet
  {'name': 'Medical Equipment', 'image': 'assets/images/rental/categories/Medical Equipments.png'},
  {'name': 'Camping & Outdoor Gear', 'image': 'assets/images/rental/categories/camping & outdoor gear.png'},
  {'name': 'Construction Equipment', 'image': 'assets/images/rental/categories/construction equipment.png'},
  {'name': 'Wedding & Formal Wear', 'image': 'assets/images/rental/categories/wedding & formal wear.png'},
  {'name': 'Gardening Tools & Equipment', 'image': 'assets/images/rental/categories/gardening tools & equipment.png'},
  {'name': 'Office Equipment (Printers, Projectors, Desks)', 'image': 'assets/images/rental/categories/office equipments.png'},
  {'name': 'Photography & Videography Equipment', 'image': 'assets/images/rental/categories/photo & video equipment.png'},
  {'name': 'Luxury Cars & Supercars', 'image': 'assets/images/rental/categories/Luxury cars.png'},
  {'name': 'Pet Accessories & Supplies', 'image': 'assets/images/rental/categories/pet accessories & supplies.png'},
  {'name': 'Hotels and Resorts', 'image': 'assets/images/rental/categories/Hotels and Resorts.png'},
];
