import 'package:flutter/material.dart';
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

  Widget _buildInventoryItem({
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
                  // Aksi untuk tombol Edit Product
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
          _showStockinPopup(context); // Show Stock In popup
        } else {
          _showStockoutPopup(context); // Show Stock Out popup
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

  void _showStockinPopup(BuildContext context) {
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
                  // Close icon in the top right corner
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context); // Close the popup
                      },
                    ),
                  ),
                  // Judul popup
                  const Text(
                    "Stock In",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter the number of products to add to stock.",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),

                  // Label "Enter number of products"
                  const Text(
                    "Number of products",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Input jumlah produk dengan tombol + dan -
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        // Tombol -
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (productCount > 0) productCount--;
                            });
                          },
                          icon: const Icon(Icons.remove, color: Colors.grey),
                        ),

                        // TextField untuk angka
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

                        // Tombol +
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

                  // Tombol Save - centered
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        // Simulate saving action
                        Navigator.pop(context); // Close the stock-in popup

                        // Show the success dialog in the center of the screen
                        _showSuccessinDialog(context, "Stock In updated successfully!");
                      },
                      child: const Text("Save"),
                    ),
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

// Function to show a centered success dialog for both Stock In and Stock Out
  void _showSuccessinDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Success!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _showStockoutPopup(BuildContext context) {
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
                  // Close icon in the top right corner
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context); // Close the popup
                      },
                    ),
                  ),
                  // Judul popup
                  const Text(
                    "Stock Out",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter the number of products to be removed from stock.",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),

                  // Label "Enter number of products"
                  const Text(
                    "Number of products",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Input jumlah produk dengan tombol + dan -
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300, width: 1.5),
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        // Tombol -
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (productCount > 0) productCount--;
                            });
                          },
                          icon: const Icon(Icons.remove, color: Colors.grey),
                        ),

                        // TextField untuk angka
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

                        // Tombol +
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

                  // Tombol Save - centered
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: () {
                        // Simulate saving action
                        Navigator.pop(context); // Close the stock-out popup

                        // Show the success dialog in the center of the screen
                        _showSuccessDialog(context);
                      },
                      child: const Text("Save"),
                    ),
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

// Function to show a centered success dialog
void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          "Success!",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        content: const Text(
          "Stock Out has been updated successfully.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the success dialog
            },
          ),
        ],
      );
    },
  );
}
}
