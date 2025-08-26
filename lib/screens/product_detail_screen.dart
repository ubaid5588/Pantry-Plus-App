import 'package:flutter/material.dart';
import '../model/model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

import '../providers/dummy_data.dart';
import '../widgets/background_setup.dart';
import '../widgets/product_item_2.dart';
import '../providers/user_data_provider.dart';
import '../widgets/all_rating_review.dart';
import './see_more_reviews.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/ProductsDetailScreen';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final orderItem = Provider.of<UserDataProvider>(context);
    final dataProvider = Provider.of<DummyData>(context, listen: false);
    final dummyData = dataProvider.dummyData;

    List<ProductModel> allProducts = [];
    for (var products in dummyData) {
      for (var product in products.product) {
        allProducts.add(product);
      }
    }

    final args = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return BackgroundSetup(
        centerWidget: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: (AppBar(
        backgroundColor: const Color.fromARGB(50, 255, 255, 255),
        title: Text(args.title,
            style: GoogleFonts.getFont(
              'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 22,
            )),
      )),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: deviceWidth * 0.92,
                height: deviceHeight * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(210, 255, 250, 250),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.network(
                      // change to network //
                      args.image,
                      fit: BoxFit.contain,
                    )),
              ),
              SizedBox(
                height: deviceHeight * 0.015,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(210, 255, 250, 250),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(args.title,
                            style: GoogleFonts.getFont(
                              'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            )),
                        args.ratingReview.isNotEmpty
                            ? RatingBar.readOnly(
                                initialRating:
                                    dataProvider.totalProductRating(args.id),
                                alignment: Alignment.center,
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                                size: deviceHeight * 0.024,
                              )
                            : const Text('')
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          args.weight,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rs ${(args.price * 1.2)}',
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Rs ${args.price}',
                              style: TextStyle(
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      args.description,
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 17,
                      ),
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Text(
                      'Rating and Reviews',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    args.ratingReview.isNotEmpty
                        ? RatingBar.readOnly(
                            initialRating:
                                dataProvider.totalProductRating(args.id),
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            size: deviceHeight * 0.024,
                          )
                        : const Text(''),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.016),
                          child: args.ratingReview.isNotEmpty
                              ? AllRatingReview(
                                  name: args.ratingReview[0].userData.userName,
                                  rating: args.ratingReview[0].rating,
                                  reviewDate: args
                                      .ratingReview[0].userData.reviewDateTime,
                                  review: args.ratingReview[0].review)
                              : const Text('No rating and review review',
                                  style: TextStyle(
                                    fontSize: 16,
                                  )),
                        ),
                        Center(
                          child: args.ratingReview.isNotEmpty
                              ? TextButton(
                                  onPressed: () => Navigator.of(context)
                                          .pushNamed(SeeMoreReviews.routeName,
                                              arguments: {
                                            'id': args.id,
                                            'ratingReview': args.ratingReview
                                          }),
                                  child: const Text('See all reviews',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blue)))
                              : const Text(''),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                    ),
                    Text(
                      'you can also check this item',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: allProducts.map((product) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                ProductDetailScreen.routeName,
                                arguments: product);
                          },
                          child: ProductItem2(
                              title: product.title,
                              price: product.price,
                              image: product.image),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        orderItem.isAdmin
            ? const SizedBox()
            : Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Added to bag',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(milliseconds: 2400),
                    ));

                    orderItem.addToBag(args.id.toString(), args.title,
                        args.price, args.weight, args.image);
                    orderItem.addProductToBag();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: deviceHeight * 0.02),
                    width: deviceWidth * 0.7,
                    height: deviceHeight * 0.048,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(216, 47, 245, 54),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 84, 185, 87))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          'Add To Bag',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        )),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.shopping_bag_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              )
      ]),
    ));
  }
}
