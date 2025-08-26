import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/category_item.dart';
import '../providers/dummy_data.dart';
import './products_screen.dart';
import '../widgets/title_name.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final dummyData = Provider.of<DummyData>(context).dummyData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 14, top: 9, bottom: 9),
            child: TitleName(title: 'Category')),
        SizedBox(
            height: deviceHeight * 0.80,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: Platform.isAndroid
                    ? deviceHeight * 0.0011
                    : deviceHeight * 0.001,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProductsScren.routeName,
                        arguments: {
                          'categoryName': dummyData[index].title,
                          'productsData': dummyData[index].product
                        });
                  },
                  child: CategoryItem(
                      title: dummyData[index].title,
                      image: dummyData[index].image),
                );
              },
              itemCount: dummyData.length,
            ))
      ],
    );
  }
}
