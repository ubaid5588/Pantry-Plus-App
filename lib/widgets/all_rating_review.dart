import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:intl/intl.dart';

class AllRatingReview extends StatelessWidget {
  final String name;
  final double rating;
  final String review;
  final DateTime reviewDate;
  const AllRatingReview(
      {super.key,
      required this.name,
      required this.rating,
      required this.reviewDate,
      required this.review});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(140, 250, 249, 249),
          border: Border.all(
              width: 1, color: const Color.fromARGB(50, 235, 161, 161)),
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(deviceWidth * 0.033),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: deviceWidth * 0.06,
                      backgroundColor: Colors.red[200],
                      child: Center(
                          child: Text(
                        name[0],
                        style: TextStyle(fontSize: deviceWidth * 0.044),
                        textAlign: TextAlign.center,
                      ))),
                  SizedBox(width: deviceWidth * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: deviceWidth * 0.044,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        DateFormat('dd, MMM, yyyy').format(reviewDate),
                        style: TextStyle(
                            fontSize: deviceWidth * 0.036,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              RatingBar.readOnly(
                alignment: Alignment.centerRight,
                initialRating: rating,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                size: deviceHeight * 0.024,
              ),
            ],
          ),
          SizedBox(
            height: deviceHeight * 0.01,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: deviceWidth * 0.76,
              child: Text(
                review,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    );
  }
}
