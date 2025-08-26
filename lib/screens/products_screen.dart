import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/dummy_data.dart';
import '../model/model.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/background_setup.dart';
import '../widgets/product_item.dart';

class ProductsScren extends StatelessWidget {
  static const routeName = '/Products-screen';
  const ProductsScren({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final categoryName = args['categoryName'] as String;
    final productsData = args['productsData'] as List<ProductModel>;
    final dataPrvider = Provider.of<DummyData>(context, listen: false);
    final deviceHeight = MediaQuery.of(context).size.height;
    return BackgroundSetup(
        centerWidget: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(categoryName,
            style: GoogleFonts.getFont(
              'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 22,
            )),
      ),
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: deviceHeight * 0.88,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: deviceHeight * 0.00105,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ProductDetailScreen.routeName,
                            arguments: productsData[index]);
                      },
                      child: productsData.isEmpty
                          ? const Text('No product found')
                          : ProductItem(
                              title: productsData[index].title,
                              price: productsData[index].price,
                              image: productsData[index].image,
                              rating: dataPrvider
                                  .totalProductRating(productsData[index].id),
                            ));
                },
                itemCount: productsData.length,
              ))
        ],
      ),
    ));
  }
}