import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';
import '../providers/dummy_data.dart';
import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';
import '../screens/searched_screen.dart';

class SearchingScreen extends StatefulWidget {
  static const routeName = '/SearchingScreen';
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchingScreen> {
  late List<CategoryModel> dummyData;

  List<ProductModel> _foundUsers = [];
  @override
  initState() {
    dummyData = Provider.of<DummyData>(context, listen: false).dummyData;
    _foundUsers = findProducts;
    super.initState();
  }

  List<ProductModel> get dummyProducts {
    List<ProductModel> allProducts = [];
    for (var products in dummyData) {
      for (var product in products.product) {
        allProducts.add(product);
      }
    }
    return allProducts;
  }

  List<ProductModel> get findProducts {
    Set<String> seenNames = {};
    List<ProductModel> findingProducts = [];
    for (var product in dummyProducts) {
      if (seenNames.add(product.title)) {
        findingProducts.add(product); 
      }
    }
    return findingProducts;
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<ProductModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = findProducts;
    } else {
      results = findProducts
          .where((user) =>
              user.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return BackgroundSetup(
        centerWidget: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const TitleName(title: 'Search for grocery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              height: deviceHeight * 0.054,
              width: deviceWidth * 0.91,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                    width: 1, color: const Color.fromARGB(255, 0, 0, 0)),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                onChanged: (value) {
                  _runFilter(value);
                },
                decoration: const InputDecoration(
                  hintText: "Search for grocery",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? Container(
                      width: double.infinity,
                      height: deviceHeight * 0.005,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(220, 255, 255, 255),
                          borderRadius: BorderRadius.circular(5)),
                      child: ListView.builder(
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      SearchedScreen.routeName,
                                      arguments: _foundUsers[index].title);
                                },
                                splashColor: Colors.grey[700],
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: deviceHeight * 0.015,
                                      bottom: deviceHeight * 0.015,
                                      left: deviceWidth * 0.055),
                                  child: Text(
                                    _foundUsers[index].title,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              height: 2,
                              thickness: 2,
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: deviceHeight * 0.07,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(220, 255, 255, 255),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'No results found Please try with diffrent search',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    ));
  }
}
