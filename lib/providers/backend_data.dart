import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/model.dart';

class BackendData extends ChangeNotifier {
  final List<CategoryModel> _backendData = [];

  List<CategoryModel> get backendData => _backendData;

  final List<ProductModel> _allProducts = [];
  List<ProductModel> get allProducts => _allProducts;

  ProductModel? findProductById(String productId) {
    return _allProducts.firstWhere((product) => product.id == productId);
  }

  double totalProductRating(String productId) {
    double averageRating;
    ProductModel addRatingReview = _backendData
        .expand((category) => category.product)
        .firstWhere((product) => product.id == productId);
    List<dynamic> ratingReviews = addRatingReview.ratingReview;
    double totalRating = 0.0;

    for (var review in ratingReviews) {
      totalRating += review.rating as double;
    }

    averageRating = totalRating / ratingReviews.length;

    return averageRating;
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getBackendData() async {
    if (_backendData.isNotEmpty && _allProducts.isNotEmpty) {
      return;
    }

    // Reference to the Firestore collection
    CollectionReference categoriesCollection = FirebaseFirestore.instance
        .collection('categories');

    // Fetch categories
    QuerySnapshot categorySnapshot = await categoriesCollection.get();

    // Clear previous data
    _backendData.clear();
    _allProducts.clear();

    // Iterate through each category
    for (QueryDocumentSnapshot categoryDoc in categorySnapshot.docs) {
      // Check if 'products' exists and is a list
      List<dynamic> productList = categoryDoc['products'] ?? [];

      // Extract products and create ProductModel instances
      List<ProductModel> products = productList.map((product) {
        Map<String, dynamic> productData = product as Map<String, dynamic>;

        return ProductModel(
          id: productData['id'] ?? '',
          category: productData['category'], // Provide fallback for missing ID
          title: productData['title'] ?? '',
          weight: productData['weight'] ?? '',
          image: productData['image'] ?? '',
          price: productData['price'] ?? 0.0,
          description: productData['description'] ?? '',
          ratingReview:
              (productData['ratingReview'] as List<dynamic>?)
                  ?.map(
                    (review) => RatingReviewModel(
                      rating: (review['rating'] as num).toDouble(),
                      review: review['review'] ?? '',
                      userData: UserData(
                        userName: review['userData']['userName'] ?? '',
                        reviewDateTime: DateTime.parse(
                          review['userData']['reviewDateTime'],
                        ),
                      ),
                    ),
                  )
                  .toList() ??
              [],
        );
      }).toList();

      // Create CategoryModel instance
      _backendData.add(
        CategoryModel(
          id: categoryDoc.id,
          title: categoryDoc['title'] ?? '',
          image: categoryDoc['image'] ?? '',
          product: products,
        ),
      );
    }

    // Add products to _allProducts
    for (var category in _backendData) {
      _allProducts.addAll(category.product);
    }

    notifyListeners();
  }

  String findCategoryByProductId(String productId) {
    for (var category in backendData) {
      for (var product in category.product) {
        if (product.id == productId) {
          return category.id;
        }
      }
    }
    return ''; // Return null if no category is found
  }

  Future<void> findProductAndAddReview(
    String productId,
    RatingReviewModel addNewRatingReview,
  ) async {
    // Find category by productId
    String categoryId = findCategoryByProductId(productId);

    if (categoryId.isEmpty) {
      return; // No category found, exit function
    }

    DocumentReference categoryDoc = FirebaseFirestore.instance
        .collection('categories')
        .doc(categoryId);

    // Fetch the category document
    DocumentSnapshot categorySnapshot = await categoryDoc.get();

    if (categorySnapshot.exists) {
      List<dynamic> productList = categorySnapshot['products'];

      // Find the index of the product to update
      int productIndex = productList.indexWhere(
        (product) => product['id'] == productId,
      );

      if (productIndex != -1) {
        // Add new rating review to the existing list
        List<dynamic> updatedReviews = List.from(
          productList[productIndex]['ratingReview'] ?? [],
        );
        updatedReviews.add({
          'rating': addNewRatingReview.rating,
          'review': addNewRatingReview.review,
          'userData': {
            'userName': addNewRatingReview.userData.userName,
            'reviewDateTime': addNewRatingReview.userData.reviewDateTime
                .toIso8601String(),
          },
        });

        // Update the product with the new rating reviews
        productList[productIndex]['ratingReview'] = updatedReviews;

        // Update the entire products array in Firestore
        await categoryDoc.update({'products': productList});

        notifyListeners();
      }
    }
  }
}
