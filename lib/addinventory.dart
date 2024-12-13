import 'package:flutter/material.dart';
import 'package:stockit/homepage.dart';
import 'package:stockitInventoryDetailScreen.dart';

class AddInventoryScreen extends StatefulWidget {
  @override
  _AddInventoryScreenState createState() => _AddInventoryScreenState();
}

class _AddInventoryScreenState extends State<AddInventoryScreen> {
  int initialQuantity = 0;
  int reorderQuantity = 0;

  String selectedUnitCategory = "Count / Quantity";
  String selectedUnit = "Pieces (pcs)";
  String selectedCurrency = "IDR";
  String selectedCategory = "Add New Category";

  final Map<String, List<String>> unitOptions = {
    "Count / Quantity": ["Units (units)", "Pieces (pcs)", "Items (items)", "Packs (packs)", "Boxes (boxes)", "Other"],
    "Volume": ["Liters (l)", "Milliliters (ml)", "Fluid Ounces (fl oz)", "Cups (cup)", "Other"],
    "Weight": ["Kilograms (kg)", "Grams (g)", "Ounces (oz)", "Other"],
    "Length": ["Kilometers (km)", "Meters (m)", "Centimeters (cm)", "Inches (in)", "Feet (ft)", "Other"],
  };

  final List<String> categories = ["Add New Category", "Electronics", "Groceries", "Fashion"];
  final List<String> currencies = ["EUR", "USD", "IDR", "JPY", "KRW", "AUD", "None"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text("Add Inventory", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Handle back button
          },
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ..._buildFormFields(),
              const SizedBox(height: 16),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField("Product Name", "Product Name"),
      _buildTextField("SKU/Product Code", "SKU/Product Code"),
      _buildTextField("Enter Barcode", "000000000"),
      _buildDropdown("Select a unit of measure", selectedUnitCategory, unitOptions.keys.toList(), (value) {
        setState(() {
          selectedUnitCategory = value ?? selectedUnitCategory;
          selectedUnit = unitOptions[selectedUnitCategory]?.first ?? "Pieces (pcs)";
        });
      }),
      _buildDropdown("Select Variety", selectedUnit, unitOptions[selectedUnitCategory]!, (value) {
        if (value == "Other") {
          _showInputDialog(context, "Add a new unit for $selectedUnitCategory", (newValue) {
            setState(() {
              unitOptions[selectedUnitCategory]?.add(newValue);
              selectedUnit = newValue;
            });
          });
        } else {
          setState(() {
            selectedUnit = value ?? selectedUnit;
          });
        }
      }),
      _buildQuantityField("Initial Quantity", initialQuantity, (newQuantity) {
        setState(() {
          initialQuantity = newQuantity;
        });
      }),
      _buildQuantityField("Reorder Quantity", reorderQuantity, (newQuantity) {
        setState(() {
          reorderQuantity = newQuantity;
        });
      }),
      _buildTextField("Cost Price", "Cost Price"),
      _buildTextField("Selling Price", "Selling Price"),
      _buildDropdown("Select Currency", selectedCurrency, currencies, (value) {
        setState(() {
          selectedCurrency = value ?? selectedCurrency;
        });
      }),
      _buildDropdown("Select Category", selectedCategory, categories, (value) {
        if (value == "Add New Category") {
          _showInputDialog(context, "Add New Category", (newValue) {
            setState(() {
              categories.add(newValue);
              selectedCategory = newValue;
            });
          });
        } else {
          setState(() {
            selectedCategory = value ?? selectedCategory;
          });
        }
      }),
    ];
  }

  Widget _buildTextField(String label, String hint) {
    return _buildFieldContainer(
      label: label,
      child: TextField(
        decoration: InputDecoration(
 hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: _outlineInputBorder(),
          focusedBorder: _outlineInputBorder(focused: true),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return _buildFieldContainer(
      label: label,
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: _outlineInputBorder(),
          focusedBorder: _outlineInputBorder(focused: true),
        ),
      ),
    );
  }

  Widget _buildQuantityField(String label, int quantity, ValueChanged<int> onChanged) {
    final TextEditingController controller = TextEditingController(text: quantity.toString());

    return _buildFieldContainer(
      label: label,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.0),
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                if (quantity > 0) {
                  onChanged(quantity - 1);
                }
              },
            ),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "0",
                ),
                onChanged: (value) {
                  final int? newQuantity = int.tryParse(value);
                  if (newQuantity != null) {
                    onChanged(newQuantity);
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                onChanged(quantity + 1);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldContainer({required String label, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Icon(Icons.check_circle, size: 40, color: Colors.green),
            content: const Text("Product added successfully"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                    Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => InventoryDetailScreen()),
                          );
                        },
                        child: const Text("See Inventory"),
                        ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF006A67),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.all(16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      child: const Text("Save Inventory"),
    );
  }

  void _showInputDialog(BuildContext context, String title, ValueChanged<String> onSubmitted) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter name"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Submit"),
              onPressed: () {
                onSubmitted(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  OutlineInputBorder _outlineInputBorder({bool focused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(22.0),
      borderSide: BorderSide(
        color: focused ? Color(0xFF006A67) : Colors.grey,
        width: 1.0,
      ),
    );
  }
}
