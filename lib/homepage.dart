import 'package:flutter/material.dart';
import 'package:stockit/addinventory.dart';
import 'package:stockit/newbusiness.dart';
import 'package:stockit/profile.dart';
import 'package:stockit/searchpage.dart';
import 'faqpage.dart';  // Mengimpor FAQPage

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = 'All';
  String searchQuery = '';

  final List<Map<String, dynamic>> inventoryItems = [
    {'name': 'Mouse Gaming', 'id': 'A201', 'quantity': 5, 'category': 'Computer'},
    {'name': 'Pen', 'id': 'F101', 'quantity': 0, 'category': 'Stationery'},
    {'name': 'Notebook A4', 'id': 'G202', 'quantity': 50, 'category': 'Stationery'},
    {'name': 'Keyboard Mechanical', 'id': 'B202', 'quantity': 3, 'category': 'Computer'},
    {'name': 'Laptop Cooling Pad', 'id': 'C303', 'quantity': 0, 'category': 'Computer'},
    {'name': 'USB Cable', 'id': 'D404', 'quantity': 10, 'category': 'Computer'},
    {'name': 'Wireless Mouse', 'id': 'E505', 'quantity': 12, 'category': 'Computer'},
    {'name': 'Stapler', 'id': 'H303', 'quantity': 15, 'category': 'Stationery'},
    {'name': 'Highlighter', 'id': 'I404', 'quantity': 30, 'category': 'Stationery'},
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> items = inventoryItems;

    if (selectedCategory != 'All') {
      items = items.where((item) => item['category'] == selectedCategory).toList();
    }

    if (searchQuery.isNotEmpty) {
      items = items.where((item) => item['name'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return items;
  }

  Map<String, int> getCategoryCounts() {
    // Hitung jumlah produk berdasarkan kategori
    Map<String, int> counts = {'All': inventoryItems.length};

    for (var item in inventoryItems) {
      final category = item['category'];
      if (counts.containsKey(category)) {
        counts[category] = counts[category]! + 1;
      } else {
        counts[category] = 1;
      }
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final categoryCounts = getCategoryCounts();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF006A67),
        title: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => BusinessSelector(),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Toko', style: TextStyle(color: Colors.white)),
              Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(
                  inventoryItems: inventoryItems,
                  onSearch: (query) {
                    setState(() {
                      searchQuery = query;
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  categoryButton('All', 'All (${categoryCounts['All']})'),
                  SizedBox(width: 8),
                  categoryButton('Computer', 'Computer (${categoryCounts['Computer'] ?? 0})'),
                  SizedBox(width: 8),
                  categoryButton('Stationery', 'Stationery (${categoryCounts['Stationery'] ?? 0})'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SummaryCard(
                  title: 'Total Items',
                  count: inventoryItems.length,
                  color: const Color.fromARGB(255, 200, 230, 223),
                  icon: Icons.inventory_2_outlined),
                SummaryCard(
                  title: 'Out of Stock',
                  count: inventoryItems.where((item) => item['quantity'] == 0).length,
                  color: Colors.orange[100]!,
                  icon: Icons.warning_amber_outlined),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: filteredItems.map((item) {
                return InventoryItem(
                  name: item['name'],
                  id: item['id'],
                  quantity: item['quantity'],
                  category: item['category'],
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.help_outline, color: Color(0xFF006A67)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQPage()),
                );
              },
            ),
            SizedBox(width: 32),
            FloatingActionButton(
              backgroundColor: Color(0xFF006A67),
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                showModalBottomSheet(
  context: context,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  ),
  builder: (context) => Container(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.edit, color: Colors.teal),
          title: Text('Add Product Manually'),
          onTap: () {
            Navigator.pop(context); // Tutup bottom sheet
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddInventoryScreen()), // Arahkan ke AddInventoryScreen
            );
          },
        ),
      ],
    ),
  ),
);

              },
            ),
            SizedBox(width: 32),
            IconButton(
            icon: Icon(Icons.person, color: Color(0xFF006A67)),
            onPressed: () {
              // Navigasi ke ProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ],
        ),
      ),
    );
  }

  Widget categoryButton(String category, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedCategory == category
            ? const Color(0xFF006A67)
            : const Color.fromARGB(255, 255, 255, 255),
        shape: StadiumBorder(),
      ),
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Text(
        label,
        style: TextStyle(
          color: selectedCategory == category ? Colors.white : Color(0xFF006A67),
        ),
      ),
    );
  }
}

class BusinessSelector extends StatelessWidget {
  final List<Map<String, String>> businesses = [
    {'name': 'Toko', 'products': '7 Products'},
    // Tambahkan bisnis lain di sini jika diperlukan.
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select a business',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          ...businesses.map((business) {
            return ListTile(
              leading: Icon(Icons.store, color: Colors.orange),
              title: Text(business['name']!),
              subtitle: Text(business['products']!),
              trailing: Radio(
                value: business['name'], // Key bisnis
                groupValue: 'Toko', // Pilihan yang sedang aktif
                onChanged: (value) {
                  // Aksi jika bisnis dipilih
                  Navigator.pop(context); // Tutup modal
                  // Perbarui logika aplikasi sesuai pilihan
                },
              ),
            );
          }).toList(),
          SizedBox(height: 8),
          ElevatedButton(
              onPressed: () {
                // Navigasi ke AddNewBusinessPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNewBusinessPage(),
                  ),
                );
              },
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              backgroundColor: Color(0xFF006A67),
              textStyle: TextStyle(color: Colors.white), // Teks berwarna putih
            ),
            child: Text(
              'Add a new business',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}


class SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;

  const SummaryCard({required this.title, required this.count, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        children: [
          Icon(icon, size: 32),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(count.toString(), style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}

class InventoryItem extends StatelessWidget {
  final String name;
  final String id;
  final int quantity;
  final String category;

  const InventoryItem({required this.name, required this.id, required this.quantity, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text('ID: $id  |  '),
                          Text('Quantity: $quantity pcs'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(6)),
              child: Text(category, style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
            ),
          ),
        ],
      ),
    );
  }
}

