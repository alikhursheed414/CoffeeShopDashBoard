import 'package:flutter/material.dart';
import '../main.dart';
import 'AddProductScreen.dart'; // for colors — or copy your colors manually

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool showAddScreen = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height, // give full screen height
      child: showAddScreen
          ? AddProductScreen(
        onCancel: () {
          setState(() => showAddScreen = false);
        },
      )
          : _buildProductList(),
    );

  }

  Widget _buildProductList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TOP BAR
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Products",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),

            Row(
              children: [
                // DROPDOWN FILTER
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  height: 40,
                  decoration: BoxDecoration(
                    color: kLightGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      Text("Simple Latte",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      SizedBox(width: 8),
                      Icon(Icons.keyboard_arrow_down_rounded,
                          color: Colors.black87),
                    ],
                  ),
                ),

                const SizedBox(width: 18),

                // ADD PRODUCT BUTTON — FIXED
                GestureDetector(
                  onTap: () {
                    setState(() => showAddScreen = true);
                  },
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    height: 40,
                    decoration: BoxDecoration(
                      color: kPrimaryGreen,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.add, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "Add new Product",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 26),

        // TABLE HEADER
        _tableHeader(),

        const SizedBox(height: 8),

        // Your product items
        Column(
          children:  [
            ProductRow(
              name: "Macchiato ",
              temp: "Hot",
              imagePath: "assets/images1/coffee.png",
              size: "Medium",
              price: "\$6.50",
              quantity: '1',
            ),
            ProductRow(
              name: "Cafe mocha",
              temp: "Hot",
              imagePath: "assets/images1/coffee.png",
              size: "Medium",
              price: "\$5.50",
              quantity: '4',
            ),
            ProductRow(
              name: "Latte miel",
              temp: "Hot",
              imagePath: "assets/images1/coffee.png",
              size: "Medium",
              price: "\$6.50",
              quantity: '3',
            ),
            ProductRow(
              name: "Latte simple",
              temp: "Hot",
              imagePath: "assets/images1/coffee.png",
              size: "Medium",
              price: "\$5.50",
              quantity: '2',
            ),
          ],
        ),
      ],
    );
  }

  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: const [
          Expanded(flex: 3, child: Text("Product name")),
          Expanded(flex: 2, child: Text("Available in")),
          Expanded(flex: 2, child: Text("Upload image")),
          Expanded(flex: 2, child: Text("Size")),
          Expanded(flex: 2, child: Text("Price")),
          Expanded(flex: 1, child: Text("Action")),
        ],
      ),
    );
  }
}






// class ProductsPage extends StatefulWidget {
//   const ProductsPage({super.key});
//
//   @override
//   State<ProductsPage> createState() => _ProductsPageState();
// }
//
// class _ProductsPageState extends State<ProductsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // TOP BAR
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               "Products",
//               style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
//             ),
//
//             Row(
//               children: [
//                 // SIMPLE LATTE FILTER DROPDOWN
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 14),
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: kLightGreen,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: const [
//                       Text("Simple Latte",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500, fontSize: 14)),
//                       SizedBox(width: 8),
//                       Icon(Icons.keyboard_arrow_down_rounded,
//                           color: Colors.black87),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(width: 18),
//
//                 // ADD NEW PRODUCT BUTTON
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       // Switch dashboard content to AddProductScreen
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const AddProductScreen(),
//                         ),
//                       );
//                     });
//                   },
//                   child: Container(
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: kPrimaryGreen,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Row(
//                       children: const [
//                         Icon(Icons.add, color: Colors.white, size: 18),
//                         SizedBox(width: 8),
//                         Text(
//                           "Add new Product",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 26),
//
//         // TABLE HEADER
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           child: Row(
//             children: const [
//               Expanded(flex: 3, child: Text("Product name")),
//               Expanded(flex: 2, child: Text("Available in")),
//               Expanded(flex: 2, child: Text("Upload image")),
//               Expanded(flex: 2, child: Text("Size")),
//               Expanded(flex: 2, child: Text("Price")),
//               Expanded(flex: 1, child: Text("Action")),
//             ],
//           ),
//         ),
//
//         const SizedBox(height: 8),
//
//         // LIST OF PRODUCTS
//         Column(
//           children: const [
//             ProductRow(
//               name: "Macchiato ",
//               temp: "Hot",
//               imagePath: "assets/images1/coffee.png",
//               size: "Medium",
//               price: "\$6.50",
//               quantity:'1',
//             ),
//             ProductRow(
//               name: "Cafe mocha",
//               temp: "Hot",
//               imagePath: "assets/images1/coffee.png",
//               size: "Medium",
//               price: "\$5.50",
//               quantity:'4',
//             ),
//             ProductRow(
//               name: "Latte miel",
//               temp: "Hot",
//               imagePath: "assets/images1/coffee.png",
//               size: "Medium",
//               price: "\$6.50",
//               quantity:'3',
//             ),
//             ProductRow(
//               name: "Latte simple",
//               temp: "Hot",
//               imagePath: "assets/images1/coffee.png",
//               size: "Medium",
//               price: "\$5.50",
//               quantity:'2',
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//

class ProductRow extends StatelessWidget {
  final String name;
  final String temp;
  final String imagePath;
  final String size;
  final String price;
  final String quantity;

  const ProductRow({
    super.key,
    required this.name,
    required this.temp,
    required this.imagePath,
    required this.size,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE7E7E7))),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    height:30,
                    width:30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kPrimaryGreen.withOpacity(0.2)
                    ),
                    child: Center(child: Text(quantity, style: const TextStyle(fontSize: 15,color: kPrimaryGreen))),
                  ),
                  const SizedBox(width: 10),
                  Text(name, style: const TextStyle(fontSize: 15)),
                ],
              )),
          Expanded(flex: 2, child: Text(temp)),
          Expanded(
              flex: 2,
              child: Image.asset(imagePath, width: 32, height: 32)),
          Expanded(flex: 2, child: Text(size)),
          Expanded(flex: 2, child: Text(price)),
          Expanded(
            flex: 1,
            child: Row(
              children: const [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 12),
                Icon(Icons.delete_outline, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
