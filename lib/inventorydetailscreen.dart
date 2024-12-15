import 'package:flutter/material.dart';
import 'package:stockit/EditProduct.dart';
import 'package:stockit/homepage.dart';

class InventoryDetailScreen extends StatelessWidget {
  final String productName = "Buku";
  final String sku = "01";
  final String barcode = "0000001";
  final String unitOfMeasure = "Pieces (pcs)";
  final String availableQuantity = "5 pcs";
  final String reorderQuantity = "10 pcs";
  final String sellingPrice = "Rp6,000.00";
  final String costPrice = "Rp5,000.00";
  final String category = "ATK"; // Kategori produk

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory Details"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _buildInventoryItem(
              context,
              productName: productName,
              sku: sku,
              barcode: barcode,
              unitOfMeasure: unitOfMeasure,
              availableQuantity: availableQuantity,
              reorderQuantity: reorderQuantity,
              sellingPrice: sellingPrice,
              costPrice: costPrice,
              category: category,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStockButton(
                  context,
                  "Stock In",
                  Colors.green,
                  true,  // true for Stock In
                ),
                _buildStockButton(
                  context,
                  "Stock Out",
                  Colors.red,
                  false, // false for Stock Out
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryItem(
    BuildContext context, {
    required String productName,
    required String sku,
    required String barcode,
    required String unitOfMeasure,
    required String availableQuantity,
    required String reorderQuantity,
    required String sellingPrice,
    required String costPrice,
    required String category,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildDivider(),
            _buildDetailItem("SKU", sku),
            _buildDivider(),
            _buildDetailItem("Barcode", barcode),
            _buildDivider(),
            _buildDetailItem("Unit of Measure", unitOfMeasure),
            _buildDivider(),
            _buildDetailItem("Available Quantity", availableQuantity),
            _buildDivider(),
            _buildDetailItem("Reorder Quantity", reorderQuantity),
            _buildDivider(),
            _buildDetailItem("Selling Price", sellingPrice),
            _buildDivider(),
            _buildDetailItem("Cost Price", costPrice),
            _buildDivider(),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProduct(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 175, vertical: 16),
                ),
                child: const Text("Edit Product"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 0.5,
      color: Colors.grey,
    );
  }

  Widget _buildStockButton(
    BuildContext context,
    String label,
    Color borderColor,
    bool isStockIn,
  ) {
    return ElevatedButton(
      onPressed: () {
        // Trigger popup based on whether it's Stock In or Stock Out
        if (isStockIn) {
          _showStockPopup(context, true); // Show Stock In popup
        } else {
          _showStockPopup(context, false); // Show Stock Out popup
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: borderColor,
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 18),
      ),
      child: Text(label),
    );
  }

  void _showStockPopup(BuildContext context, bool isStockIn) {
    int productCount = 0; // Menyimpan jumlah produk

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () {
                          Navigator.pop(context); // Close the popup
                        },
                      ),
                    ),
                    Text(
                      isStockIn ? "Stock In" : "Stock Out",
                      style: TextStyle(
                        fontSize: 20,
                        color: isStockIn ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isStockIn
                          ? "Enter the number of products to add to stock."
                          : "Enter the number of products to be removed from stock.",
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Number of products",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 1.5),
                        borderRadius: BorderRadius.circular(22.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (productCount > 0) productCount--;
                              });
                            },
                            icon: const Icon(Icons.remove, color: Colors.grey),
                          ),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(text: productCount.toString()),
                              onChanged: (value) {
                                setState(() {
                                  productCount = int.tryParse(value) ?? 0;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                productCount++;
                              });
                            },
                            icon: const Icon(Icons.add, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Success Popup
                        Navigator.pop(context);
                        _showSuccessDialog(context, isStockIn, productCount);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        backgroundColor: isStockIn ? Colors.green : Colors.red,
                      ),
                      child: Text(isStockIn ? "Add to Stock" : "Remove from Stock"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, bool isStockIn, int productCount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(
            isStockIn
                ? "Successfully added $productCount products to stock."
                : "Successfully removed $productCount products from stock.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
