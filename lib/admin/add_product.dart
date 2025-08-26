import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:image_picker/image_picker.dart';
import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/dummy_data.dart';
import '../model/model.dart';

class AddEditProduct extends StatefulWidget {
  static const routeName = '/Add-edit-product';
  const AddEditProduct({super.key});

  @override
  State<AddEditProduct> createState() => _MyAdreesState();
}

const List<String> list = <String>[
  '   Select Category',
  'Fruits',
  'Vegetables',
  'Meat & Fish',
  'Breads',
  'Oil',
  'Dairy & Eggs',
  'Spices',
  'Softs Drinks',
  'Pasta & Rice',
  'Canned Goods',
  'Snacks',
  'Condiments',
  'Grains',
  'others'
];

class _MyAdreesState extends State<AddEditProduct> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = list.first;

  final Map<String, dynamic> productData = {
    'title': '',
    'weight': '',
    'price': 0,
    'description': '',
    'category': '',
    'imageUrl': ''
  };

  File? _selectedImage;
  bool isLoading = false;

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
    final imageUrl = await _uploadImage(_selectedImage!);
    productData['imageUrl'] = imageUrl;
  }

  bool uploadingImage = false;
  bool uploadingProduct = false;

  // Function to upload image to Firebase Storage and return the image URL
  Future<String> _uploadImage(File image) async {
    setState(() {
      uploadingImage = true;
    });
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('product_images/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = await storageRef.putFile(image);
    String url = await uploadTask.ref.getDownloadURL();
    setState(() {
      uploadingImage = false;
    });

    return url;
  }

  String checkingCategory(String categoryId) {
    if (categoryId == 'Fruits') {
      return 'c1';
    } else if (categoryId == 'Vegetables') {
      return 'c2';
    } else if (categoryId == 'Meat & Fish') {
      return 'c3';
    } else if (categoryId == 'Breads') {
      return 'c4';
    } else if (categoryId == 'Oil') {
      return 'c5';
    } else if (categoryId == 'Dairy & Eggs') {
      return 'c6';
    } else if (categoryId == 'Spices') {
      return 'c7';
    } else if (categoryId == 'Softs Drinks') {
      return 'c8';
    } else if (categoryId == 'Pasta & Rice') {
      return 'c9';
    } else if (categoryId == 'Canned Goods') {
      return 'c10';
    } else if (categoryId == 'Snacks') {
      return 'c11';
    } else if (categoryId == 'Condiments') {
      return 'c12';
    } else if (categoryId == 'Grains') {
      return 'c13';
    } else {
      return 'c0';
    }
  }

  // Function to add product details to Firestore
  Future<void> _addEditProduct() async {
    setState(() {
      uploadingProduct = true;
    });
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('categories')
          .doc(checkingCategory(productData['category']))
          .update({
        'products': FieldValue.arrayUnion([
          {
            'id': DateTime.now().toIso8601String(),
            'title': productData['title'],
            'price': productData['price'],
            'weight': productData['weight'],
            'description': productData['description'],
            'category': productData['category'],
            'image': productData['imageUrl'],
            'ratingReview': [],
          }
        ])
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
      }
      setState(() {
        uploadingProduct = false;
      });
      productData.clear();

      setState(() {
        _selectedImage = null;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $error')),
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    _addEditProduct();
  }

  Future<void> updateProductDetails(String categoryId, String productId,
      Map<String, dynamic> updatedProductData) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      // Fetch category document
      DocumentSnapshot categorySnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .doc(categoryId)
          .get();

      if (!categorySnapshot.exists) {
        return;
      }
      if (categorySnapshot.exists) {
        List<dynamic> productList = categorySnapshot['products'];

        // Find the product by ID
        Map<String, dynamic>? existingProduct = productList.firstWhere(
          (product) => product['id'] == productId,
          orElse: () => null,
        );

        if (existingProduct != null) {
          // Remove the existing product

          await FirebaseFirestore.instance
              .collection('categories')
              .doc(categoryId)
              .update({
            'products': FieldValue.arrayRemove([existingProduct])
          });

          // Add the updated product back
          Map<String, dynamic> updatedProduct = {
            'id': productId,
            'title': productData['title'],
            'price': productData['price'],
            'weight': productData['weight'],
            'description': productData['description'],
            'category': existingProduct['category'],
            'image': existingProduct['image'],
            'ratingReview': existingProduct['ratingReview'], // Preserve reviews
          };

          await FirebaseFirestore.instance
              .collection('categories')
              .doc('c2')
              .update({
            'products': FieldValue.arrayUnion([updatedProduct])
          });
        } else {}
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final dataProvider = Provider.of<DummyData>(context, listen: false);
    final checkMod = ModalRoute.of(context)?.settings.arguments as String;
    final bool editing = checkMod != '' ? true : false;
    final findingProduct = checkMod != ''
        ? dataProvider.findProductById(checkMod)
        : ProductModel(
            id: '',
            category: '',
            title: '',
            weight: '',
            image: '',
            price: 0,
            description: '',
            ratingReview: [
                RatingReviewModel(
                    rating: 0,
                    review: '',
                    userData:
                        UserData(userName: '', reviewDateTime: DateTime.now()))
              ]);
    final ProductModel editingProduct = findingProduct as ProductModel;

    Future<void> addEditProduct() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      await _addEditProduct();
      if (!context.mounted) return;
      Navigator.of(context).pop();
    }

    return BackgroundSetup(
        centerWidget: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const TitleName(title: 'Add Edit Product'),
            ),
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.center,
                width: deviceWidth * 0.96,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(220, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12)),
                height: deviceHeight * 0.8,
                padding: EdgeInsets.all(deviceWidth * 0.02),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: editing ? editingProduct.title : '',
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            productData['title'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter product title';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: deviceWidth * 0.3,
                              child: TextFormField(
                                initialValue: editing
                                    ? editingProduct.price.toString()
                                    : '',
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  productData['price'] = int.parse(value!);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter product price';
                                  } else if (value.length <= 1) {
                                    return 'product price should be greater then 0';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Price',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: deviceWidth * 0.02,
                            ),
                            SizedBox(
                              width: deviceWidth * 0.6,
                              child: TextFormField(
                                initialValue:
                                    editing ? editingProduct.weight : '',
                                onSaved: (value) {
                                  productData['weight'] = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter product weight';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Weight',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        DropdownButton<String>(
                          value:
                              editing ? editingProduct.category : dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          alignment: Alignment.center,
                          style: const TextStyle(color: Colors.black),
                          onChanged: editing
                              ? null
                              : (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                    productData['category'] = value;
                                  });
                                },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const Divider(
                          color: Colors.black,
                        ),
                        TextFormField(
                          maxLines: 3,
                          initialValue:
                              editing ? editingProduct.description : '',
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            productData['description'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter product description';
                            } else if (value.length < 20) {
                              return 'description must be'; // please correct !
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: editing ? null : _pickImage,
                                child: _selectedImage == null
                                    ? editing
                                        ? Image.network(editingProduct.image,
                                            height: deviceHeight * 0.24,
                                            width: deviceWidth * 0.9,
                                            fit: BoxFit.contain)
                                        : Container(
                                            width: deviceWidth * 0.35,
                                            height: deviceHeight * 0.13,
                                            color: Colors.grey[200],
                                            child: const Icon(Icons.add_a_photo,
                                                size: 50),
                                          )
                                    :
                                    // uploadingImage
                                    // ?
                                    Image.file(_selectedImage!,
                                        height: 150, fit: BoxFit.cover)
                                // :

                                // const CircularProgressIndicator(),
                                ),
                          ],
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        SizedBox(
                          width: deviceWidth * 0.7,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (!editing) {
                                  addEditProduct();
                                } else {
                                  updateProductDetails(
                                      checkingCategory(findingProduct.category),
                                      findingProduct.id,
                                      productData);
                                }
                                Navigator.of(context).pop();
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 33, 68, 243))),
                            child: uploadingProduct
                                ? LoadingAnimationWidget.flickr(
                                    leftDotColor: Colors.red,
                                    rightDotColor: Colors.yellow,
                                    size: deviceHeight * 0.036,
                                  )
                                : Text(
                                    editing ? 'Update Product' : 'Add Product',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                          ),
                        )
                      ],
                    )),
              ),
            )));
  }
}
