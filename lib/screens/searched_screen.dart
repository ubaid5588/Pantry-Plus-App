import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';

import '../providers/dummy_data.dart';
import '../widgets/background_setup.dart';
import './searching_screen.dart';
import '../widgets/product_item.dart';
import './product_detail_screen.dart';
import '../widgets/title_name.dart';

class SearchedScreen extends StatelessWidget {
  static const routeName = '/searched-screen';
  const SearchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final dataPrvider = Provider.of<DummyData>(context, listen: false);
    final searchProduct = ModalRoute.of(context)!.settings.arguments as String;
    final dummyData = Provider.of<DummyData>(context).dummyData;

    List<ProductModel> allProducts = [];
    for (var products in dummyData) {
      for (var product in products.product) {
        allProducts.add(product);
      }
    }

    List<ProductModel> findProducts = allProducts.where((product) {
      return product.title == searchProduct;
    }).toList();

    return BackgroundSetup(
      centerWidget: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const TitleName(title: 'Searching'),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SearchingScreen.routeName);
                },
                child: Container(
                
                    padding:
                        EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                    height: deviceHeight * 0.054,
                    width: deviceWidth * 0.91,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(
                          width: 1, color: const Color.fromARGB(255, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                height: deviceHeight * 0.737,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: deviceHeight * 0.0011,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ProductDetailScreen.routeName,
                            arguments: findProducts[index]);
                      },
                      child: ProductItem(
                        title: findProducts[index].title,
                        price: findProducts[index].price,
                        image: findProducts[index].image,
                        rating: dataPrvider
                            .totalProductRating(findProducts[index].id),
                      ),
                    );
                  },
                  itemCount: findProducts.length,
                ))
          ],
        ),
      ),
    );
  }
}
