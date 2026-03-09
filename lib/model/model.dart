class UserData {
  final String userName;
  final DateTime reviewDateTime;
  UserData({required this.userName, required this.reviewDateTime});
}

class RatingReviewModel {
  final double rating;
  final String review;
  final UserData userData;
  RatingReviewModel(
      {required this.rating, required this.review, required this.userData});
}

class ProductModel {
  final String id;
  final String category;
  final String title;
  final String weight;
  final String image;
  final int price;
  final String description;
  final List<RatingReviewModel> ratingReview;
  ProductModel(
      {required this.id,
      required this.category,
      required this.title,
      required this.weight,
      required this.image,
      required this.price,
      required this.description,
      required this.ratingReview});
}

class CategoryModel {
  final String id;
  final String title;
  final String image;
  final List<ProductModel> product;
  CategoryModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.product});
}
