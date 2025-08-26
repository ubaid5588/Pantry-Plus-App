import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dummy_data.dart';
import '../model/model.dart';
import '../widgets/title_name.dart';
import './widget/edit_product.dart';
import './add_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  Future<void> removeProductById(String categoryId, String productId) async {
    DocumentReference categoryDoc =
        FirebaseFirestore.instance.collection('categories').doc(categoryId);

    // Fetch the category document
    DocumentSnapshot categorySnapshot = await categoryDoc.get();

    if (categorySnapshot.exists) {
      List<dynamic> productList = categorySnapshot['products'];

      // Find the index of the product to remove
      int productIndex =
          productList.indexWhere((product) => product['id'] == productId);

      if (productIndex != -1) {
        // Remove the product from the list
        productList.removeAt(productIndex);

        // Update the document with the modified list
        await categoryDoc.update({
          'products': productList,
        });
      } else {}
    } else {}
  }

  Future<void> editProductById(String categoryId, String productId,
      Map<String, dynamic> updatedProductData) async {
    DocumentReference categoryDoc =
        FirebaseFirestore.instance.collection('categories').doc(categoryId);

    // Fetch the category document
    DocumentSnapshot categorySnapshot = await categoryDoc.get();

    if (categorySnapshot.exists) {
      List<dynamic> productList = categorySnapshot['products'];

      // Find the index of the product to edit
      int productIndex =
          productList.indexWhere((product) => product['id'] == productId);

      if (productIndex != -1) {
        // Update the product with new data
        productList[productIndex] = {
          ...productList[productIndex], // Retain existing data
          ...updatedProductData // Overwrite with updated data
        };

        // Update the document with the modified list
        await categoryDoc.update({
          'products': productList,
        });
      } else {}
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final dataProvider = Provider.of<DummyData>(context, listen: false);

    List<ProductModel> wholeProducts = dataProvider.allProducts;

    String checkingCategory(String category) {
      if (category == 'Fruits') {
        return 'c1';
      } else if (category == 'Vegetables') {
        return 'c2';
      } else if (category == 'Meat & Fish') {
        return 'c3';
      } else if (category == 'Breads') {
        return 'c4';
      } else if (category == 'Oil') {
        return 'c5';
      } else if (category == 'Dairy & Eggs') {
        return 'c6';
      } else if (category == 'Spices') {
        return 'c7';
      } else if (category == 'Softs Drinks') {
        return 'c8';
      } else if (category == 'Pasta & Rice') {
        return 'c9';
      } else if (category == 'Canned Goods') {
        return 'c10';
      } else if (category == 'Snacks') {
        return 'c11';
      } else if (category == 'Condiments') {
        return 'c12';
      } else if (category == 'Grains') {
        return 'c13';
      } else {
        return 'c0';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 14, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleName(title: 'Add Edit Product'),
                IconButton(
                    onPressed: () => Navigator.of(context)
                        .pushNamed(AddEditProduct.routeName, arguments: ''),
                    icon: const Icon(Icons.add))
              ],
            )),
        SizedBox(
          height: deviceHeight * 0.79,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return EditProduct(
                  image: wholeProducts[index].image,
                  title: wholeProducts[index].title,
                  subtitle: wholeProducts[index].price.toString(),
                  onEdit: () => Navigator.of(context).pushNamed(
                      AddEditProduct.routeName,
                      arguments: wholeProducts[index].id),
                  onDelete: () => removeProductById(
                      checkingCategory(wholeProducts[index].category),
                      wholeProducts[index].id));
            },
            itemCount: wholeProducts.length,
          ),
        )
      ],
    );
  }
}
