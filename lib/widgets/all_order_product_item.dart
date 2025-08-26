import 'dart:io';

import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter_app/model/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../providers/auth_services.dart';
import '../providers/dummy_data.dart';
import '../widgets/title_name.dart';

class AllOrderProductItem extends StatefulWidget {
  final String id;
  final String title;
  final int price;
  final String image;
  final String checkDelievery;
  const AllOrderProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.price,
      required this.image,
      required this.checkDelievery});

  @override
  State<AllOrderProductItem> createState() => _AllOrderProductItemState();
}

class _AllOrderProductItemState extends State<AllOrderProductItem> {
  final userComment = TextEditingController();
  final auth = AuthServices();
  void thankUser(BuildContext context, double dHeight, double dWidth) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Column(
            children: [
              Image.asset(
                'assets/images/paymentsuccessful.png',
                height: dHeight * 0.25,
                width: double.infinity,
              ),
              SizedBox(
                height: dHeight * 0.02,
              ),
              const TitleName(title: 'Thank you for Review'),
              SizedBox(
                height: dHeight * 0.02,
              ),
              SizedBox(
                width: dWidth * 0.80,
                child: const Center(
                  child: Text(
                    '“Thank you for taking the time to leave a review. We’re thrilled to hear from you!”',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: dHeight * 0.02,
              ),
              SizedBox(
                width: dWidth * 0.7,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          const Color.fromARGB(255, 33, 68, 243))),
                  child: const Text(
                    'Continue Shopping',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              )
            ],
          );
        });
  }

  void writeAReview(
      BuildContext context,
      double dHeight,
      double dWidth,
      double rating,
      TextEditingController userComment,
      String userName,
      String id,
      Map<String, dynamic> userReview) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: dWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(dHeight * 0.02),
                    child: const Text(
                      'Write A Review',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ),
                  Center(
                    child: RatingBar(
                        initialRating: 5,
                        halfFilledIcon: Icons.star_half,
                        isHalfAllowed: false,
                        halfFilledColor: Colors.yellow,
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        onRatingChanged: (value) =>
                            userReview['rating'] = value),
                  ),
                  SizedBox(
                    height: dHeight * 0.02,
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          width: 1,
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: TextField(
                      maxLines: 3,
                      maxLength: 100,
                      keyboardType: TextInputType.text,
                      controller: userComment,
                    ),
                  ),
                  SizedBox(
                    height: dHeight * 0.02,
                  ),
                  SizedBox(
                    width: dWidth * 0.7,
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<DummyData>(context, listen: false)
                            .findProductAndAddReview(
                                id,
                                RatingReviewModel(
                                    rating: userReview['rating'],
                                    review: userComment.text,
                                    userData: UserData(
                                        userName: userName,
                                        reviewDateTime: DateTime.now())));
                        Navigator.of(context).pop();
                        thankUser(context, dHeight, dWidth);
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 33, 68, 243))),
                      child: const Text(
                        'Submit Review',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    double rating = 5.0;
    final Map<String, dynamic> addReview = {
      'rating': rating,
      'review': userComment
    };
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.002, horizontal: deviceWidth * 0.005),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.all(deviceWidth * 0.008),
                height: deviceHeight * 0.12,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(120, 230, 230, 230),
                    borderRadius: BorderRadius.circular(6)),
                child: ClipRRect(
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    width: deviceWidth * 0.2,
                    height: deviceHeight * 0.14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: deviceWidth * 0.045,
          ),
          SizedBox(
            height: deviceHeight * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: deviceWidth * 0.05),
                ),
                SizedBox(
                  height: deviceHeight * 0.001,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Rs ${((widget.price * 1.2).toInt()).toString()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          'Rs ${widget.price.toString()}',
                          style: TextStyle(
                              color: Colors.green[700],
                              fontSize: deviceHeight * 0.016,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Platform.isAndroid
                          ? deviceWidth * 0.2
                          : deviceWidth * 0.18,
                    ),
                    widget.checkDelievery == 'true'
                        ? Center(
                            child: TextButton(
                                onPressed: () => writeAReview(
                                    context,
                                    deviceHeight,
                                    deviceWidth,
                                    rating,
                                    userComment,
                                    user?.displayName ?? 'User',
                                    widget.id,
                                    addReview),
                                child: const Text('Write A Review',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 33, 68, 243)))),
                          )
                        : const Text('')
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
