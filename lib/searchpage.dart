import 'package:flutter/material.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> inventoryItems;
  final Function(String) onSearch;

  ProductSearchDelegate({required this.inventoryItems, required this.onSearch});

  @override
  String get searchFieldLabel => 'Search Product';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = inventoryItems.where((item) {
      return item['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100], 
      body: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final item = suggestions[index];
          return ListTile(
            title: Text(item['name']),
            subtitle: Text('ID: ${item['id']} | Quantity: ${item['quantity']}'),
          );
        },
      ),
    );
  }
}