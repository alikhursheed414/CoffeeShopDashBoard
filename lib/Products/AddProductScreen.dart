import 'package:flutter/material.dart';
import '../main.dart'; // for kPrimaryGreen, kLightGreen colors

class AddProductScreen extends StatefulWidget {
  final VoidCallback? onCancel;

  const AddProductScreen({super.key, this.onCancel});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Dropdown values
  String? _selectedCategory;
  String? _selectedAvailable;
  String? _selectedSize;

  // Lists from your screenshot
  final List<String> categories = [
    "Simple Latte",
    "Iced Latte",
    "Cappuccino",
    "Signature Coffee",
    "Americano",
    "Espresso",
    "Flat White",
    "Macchiato",
    "Mocha",
    "Affogato",
    "Drinks"
  ];

  final List<String> availableIn = ["Hot", "Iced"];
  final List<String> sizes = ["Small", "Medium", "Large"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Title
          const Text(
            "Add New Product",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 20),

          // Scrollable area
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // PRODUCT NAME + CATEGORY
                    Row(
                      children: [
                        Expanded(
                          child: _textField(
                            label: "Product Name",
                            hint: "Enter coffee name",
                          ),
                        ),
                        const SizedBox(width: 22),
                        Expanded(
                          child: _dropdown(
                            label: "Product Category",
                            value: _selectedCategory,
                            items: categories,
                            onChanged: (v) => setState(() => _selectedCategory = v),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // PRICE + SIZE
                    Row(
                      children: [
                        Expanded(
                          child: _textField(
                            label: "Price",
                            hint: "9.50",
                          ),
                        ),
                        const SizedBox(width: 22),
                        Expanded(
                          child: _dropdown(
                            label: "Product Size",
                            value: _selectedSize,
                            items: sizes,
                            onChanged: (v) => setState(() => _selectedSize = v),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // AVAILABLE IN
                    _dropdown(
                      label: "Available In",
                      value: _selectedAvailable,
                      items: availableIn,
                      onChanged: (v) => setState(() => _selectedAvailable = v),
                    ),

                    const SizedBox(height: 24),

                    // IMAGE UPLOAD BOX
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E2E2)),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryGreen,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 10),
                              ),
                              child: const Text(
                                "Upload Image",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Drag your image here or upload",
                              style: TextStyle(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 26),

                    // ACTION BUTTONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (widget.onCancel != null) widget.onCancel!();
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        const SizedBox(width: 16),

                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryGreen,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 38, vertical: 12),
                          ),
                          child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // ---------------- COMPONENTS ----------------

  Widget _textField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE2E2E2)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: const Text("Select"),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              onChanged: onChanged,
              items: items
                  .map((e) =>
                  DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
