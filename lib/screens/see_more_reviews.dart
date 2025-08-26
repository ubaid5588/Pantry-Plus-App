import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';
import '../providers/dummy_data.dart';
import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';
import '../widgets/all_rating_review.dart';

class SeeMoreReviews extends StatelessWidget {
  static const routeName = '/see-more-reviewss';
  const SeeMoreReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final productDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<RatingReviewModel> productUsersRatingReview =
        productDetails['ratingReview'];
    final productRatingReview = Provider.of<DummyData>(context, listen: false);
    final totalRating =
        productRatingReview.totalProductRating(productDetails['id']);
    return BackgroundSetup(
        centerWidget: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const TitleName(title: 'Rating and Reviews'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: deviceWidth * 0.98,
        height: deviceHeight * 0.99,
        decoration: BoxDecoration(
            color: const Color.fromARGB(180, 255, 255, 255),
            borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(deviceWidth * 0.008),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.readOnly(
                  alignment: Alignment.topRight,
                  initialRating: totalRating,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  size: deviceHeight * 0.028,
                ),
                SizedBox(
                  width: deviceWidth * 0.02,
                ),
                Text(
                  totalRating.toStringAsFixed(1),
                  style: TextStyle(fontSize: deviceHeight * 0.022),
                )
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(99, 19, 18, 18),
            thickness: 1,
          ),
          SizedBox(
            height: deviceHeight * 0.8,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return AllRatingReview(
                    name: productUsersRatingReview[index].userData.userName,
                    reviewDate:
                        productUsersRatingReview[index].userData.reviewDateTime,
                    rating: productUsersRatingReview[index].rating,
                    review: productUsersRatingReview[index].review);
              },
              itemCount: productUsersRatingReview.length,
            ),
          )
        ]),
      ),
    ));
  }
}
