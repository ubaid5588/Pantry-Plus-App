import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/internet_connectivity.dart';
import '../providers/dummy_data.dart';
import '../widgets/title_name.dart';
import './searching_screen.dart';
import './product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final dataProvider = Provider.of<DummyData>(context, listen: false);

    List<ProductModel> wholeProducts = dataProvider.allProducts;

    return SizedBox(
      height: deviceHeight * 0.99,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.only(
                  left: 14,
                  top: 9,
                ),
                child: TitleName(title: 'Pantry Plus')),
            InternetConnectivity(futureBuilder: (context) {
              return FutureBuilder(
                  future: dataProvider.getDummyData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: deviceHeight * 0.015,
                                  ),
                                  Container(
                                    height: deviceHeight * 0.06,
                                    width: deviceWidth * 0.85,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.015,
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.8,
                                    child: GridView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: 8,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  2, // 2 products per row
                                              crossAxisSpacing: 5.5,
                                              mainAxisSpacing: 5.5,
                                              childAspectRatio: Platform
                                                      .isAndroid
                                                  ? deviceHeight * 0.0011
                                                  : deviceHeight *
                                                      0.001 // Adjust based on your design
                                              ),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          height: 250.0,
                                          // Placeholder color
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )));
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Something went wrong ${snapshot.error}'),
                      );
                    }
                    return SizedBox(
                        height: deviceHeight * 0.85,
                        child: Column(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(SearchingScreen.routeName);
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    height: deviceHeight * 0.054,
                                    width: deviceWidth * 0.91,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Search for grocery',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Icon(Icons.search)
                                      ],
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: deviceHeight * 0.73,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: Platform.isAndroid
                                            ? deviceHeight * 0.0011
                                            : deviceHeight * 0.001),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        ProductDetailScreen.routeName,
                                        arguments: wholeProducts[index],
                                      );
                                    },
                                    child: ProductItem(
                                      title: wholeProducts[index].title,
                                      price: wholeProducts[index].price,
                                      image: wholeProducts[index].image,
                                      rating: dataProvider.totalProductRating(
                                          wholeProducts[index].id),
                                    ),
                                  );
                                },
                                itemCount: wholeProducts.length,
                              ),
                            ),
                          ],
                        ));
                  });
            })
          ],
        ),
      ),
    );
  }
}
