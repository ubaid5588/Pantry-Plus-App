import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final User? user = _auth.currentUser;
// final String uid = user!.uid;

class UserId {
  static String? get currentUid {
    return FirebaseAuth.instance.currentUser?.uid;
  }
}

class UserDataProvider extends ChangeNotifier {
  bool isAdmin = false;

  Future<void> checkUserAdmin() async {
    // String userId = _auth.currentUser!.uid;

    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(UserId.currentUid).get();

      documentSnapshot.get('isAdmin');

      isAdmin = true;
    } catch (e) {
      isAdmin = false;
    }
    notifyListeners();
  }

  final List<Map<String, dynamic>> _userAddress = [];

  Future<void> storeUserAddress() async {
    await _firestore.collection('users').doc(UserId.currentUid).set({
      'address': {
        'name': _userAddress[0]['name'],
        'number': _userAddress[0]['number'],
        'city': _userAddress[0]['city'],
        'homeAddress': _userAddress[0]['homeAddress']
      }
    }, SetOptions(merge: true));
  }

  Future<void> getUserAddresses() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(UserId.currentUid).get();
      var addressData = documentSnapshot.get('address');
      _userAddress.add({
        'name': addressData['name'],
        'number': addressData['number'],
        'city': addressData['city'],
        'homeAddress': addressData['homeAddress']
      });
    } catch (_) {}
  }

  Future<void> deleteUserAddress() async {
    // Get the current authenticated user
    await _firestore.collection('users').doc(UserId.currentUid).update({
      'address': FieldValue.delete(),
    });
    _userAddress.clear();
    notifyListeners();
  }

  List<Map> get userAdress {
    return [..._userAddress];
  }

  void addAddress(String name, String number, String city, String homeAddress) {
    _userAddress.isEmpty
        ? _userAddress.add({
            'name': name,
            'number': number,
            'city': city,
            'homeAddress': homeAddress
          })
        : _userAddress[0].addAll({
            'name': name,
            'number': number,
            'city': city,
            'homeAddress': homeAddress
          });
    notifyListeners();
  }

  // void removeAdress() {
  //   _userAddress.clear();
  //   notifyListeners();s
  // }

  // ** User credentional **

  final List<Map<dynamic, dynamic>> _credentional = [
    {
      'cardNumber': '1234123412341234',
      'cardHolderName': 'Muhammad Ubaid',
      'expireyDate': '12:12',
      'cvcCode': '345'
    }
  ];

  List<Map> get credentional {
    return [..._credentional];
  }

  void addCredentional(Map credentionalInfo) {
    _credentional.add(credentionalInfo);
    notifyListeners();
  }

  void removeDebitCard() {
    _credentional.clear();
    notifyListeners();
  }

  // ** User Bag **

  List<Map> _myBag = [];

  List<Map<dynamic, dynamic>> get myBag {
    return [..._myBag];
  }

  Future<void> addProductToBag() async {
    try {
      List<Map<String, dynamic>> bagList =
          _myBag.map((item) => Map<String, dynamic>.from(item)).toList();
      await _firestore.collection('users').doc(UserId.currentUid).set({
        'bag': bagList,
      }, SetOptions(merge: true));
    } catch (_) {}
  }

  Future<void> getProductToBag() async {
    if (_myBag.isNotEmpty) {
      return;
    }
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(UserId.currentUid).get();

      List<dynamic> productsData = documentSnapshot.get('bag');

      for (var product in productsData) {
        _myBag.add({
          'id': product['id'],
          'name': product['name'],
          'quantity': product['quantity'],
          'weight': product['weight'],
          'price': product['price'],
          'image': product['image'],
        });
      }
    } catch (_) {}
  }

  void addToBag(
      String id, String name, int price, String weight, String image) {
    int index = _myBag.indexWhere((item) => item['id'] == id);

    if (index != -1) {
      if (_myBag[index]['quantity'] < 5) {
        _myBag[index] = {
          'id': id,
          'name': name,
          'price': price,
          'weight': weight,
          'quantity': _myBag[index]['quantity'] + 1,
          'image': image,
        };
      }
    } else {
      _myBag.add({
        'id': id,
        'name': name,
        'quantity': 1,
        'weight': weight,
        'price': price,
        'image': image,
      });
    }
    notifyListeners();
  }

  Future<void> _updateBagInFirestore() async {
    try {
      // Ensure _myBag is a List<Map<String, dynamic>> for Firestore
      List<Map<String, dynamic>> bagList =
          _myBag.map((item) => Map<String, dynamic>.from(item)).toList();

      // Update the bag in Firestore
      await _firestore.collection('users').doc(UserId.currentUid).set(
          {
            'bag': bagList,
          },
          SetOptions(
              merge:
                  true)); // Use merge to avoid overwriting the entire document
    } catch (_) {}
  }

  void chQuantityProduct(String id, int chQuantityPro) {
    int index = _myBag.indexWhere((item) => item['id'] == id);
    if (index != -1) {
      _myBag[index]['quantity'] = chQuantityPro;
      if (_myBag[index]['quantity'] < 1) {
        _myBag.removeAt(index);
      }
    }
    _updateBagInFirestore();
    notifyListeners();
  }

  // ** ordered product **

  List<Map> _orderedProducts = [];

  List<Map> get orderedProducts {
    return [..._orderedProducts];
  }

  // for limit time use only
  List<Map> _userOrders = [];

  List<Map> get userOrders {
    return [..._userOrders];
  }

  Future<void> placeOrder(int totalPrice) async {
    DocumentReference userDoc =
        _firestore.collection('users').doc(UserId.currentUid);

    try {
      // Fetch the current 'orders' list from Firestore
      DocumentSnapshot documentSnapshot = await userDoc.get();

      List<dynamic> currentOrders = [];
      if (documentSnapshot.exists) {
        // Cast the data to Map<String, dynamic>
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;
        currentOrders = data?['orders'] ?? [];
      }

      // Prepare new order
      Map<String, dynamic> newOrder = {
        'id': DateTime.now().toString(),
        'deliveryDate':
            DateTime.now().add(const Duration(minutes: 20)).toIso8601String(),
        'totalPrice': totalPrice,
        'deliveryUpdate': false,
        'orderId': UserId.currentUid,
        'userAddress': {
          'name': _userAddress[0]['name'],
          'number': _userAddress[0]['number'],
          'city': _userAddress[0]['city'],
          'homeAddress': _userAddress[0]['homeAddress']
        },
        'orderProducts': myBag
            .map((product) => {
                  'id': product['id'],
                  'name': product['name'],
                  'quantity': product['quantity'],
                  'weight': product['weight'],
                  'price': product['price'],
                  'image': product['image'],
                })
            .toList(),
      };

      // Add new order to the current list of orders
      currentOrders.add(newOrder);

      // Update the 'orders' field in Firestore
      await userDoc.update({'orders': currentOrders});

      await FirebaseFirestore.instance
          .collection('orders')
          .doc('orders')
          .update({
        'orders': FieldValue.arrayUnion([newOrder])
      });

      deletePrdouctsFromBag();
      _myBag = [];

      notifyListeners();
    } catch (_) {}
  }

  Future<void> getOrderedProducts() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(UserId.currentUid).get();

      List<dynamic> ordersData = documentSnapshot.get('orders');
      _orderedProducts = ordersData.map((order) {
        return {
          'id':
              DateTime.parse(order['id']), // Parse the string back to DateTime
          'deliveryDate': DateTime.parse(
              order['deliveryDate']), // Parse the string back to DateTime
          'deliveryUpdate': order['deliveryUpdate'],
          'orderId': order['orderId'],
          'totalPrice': order['totalPrice'],
          'userAddress': {
            'name': order['userAddress']['name'],
            'number': order['userAddress']['number'],
            'city': order['userAddress']['city'],
            'homeAddress': order['userAddress']['homeAddress']
          },
          'orderProducts':
              (order['orderProducts'] as List<dynamic>).map((product) {
            return {
              'id': product['id'],
              'name': product['name'],
              'quantity': product['quantity'],
              'weight': product['weight'],
              'price': product['price'],
              'image': product['image'],
            };
          }).toList(),
        };
      }).toList();

      // You can now use this 'orders' list in your app
    } catch (_) {}
  }

  // for limit time use only
  Future<void> adminUserOrders() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('orders').doc('orders').get();
      List<dynamic> ordersData = documentSnapshot.get('orders');
      _userOrders = ordersData.map((order) {
        return {
          'id':
              DateTime.parse(order['id']), // Parse the string back to DateTime
          'deliveryDate': DateTime.parse(
              order['deliveryDate']), // Parse the string back to DateTime
          'deliveryUpdate': order['deliveryUpdate'],
          'orderId': order['orderId'],
          'totalPrice': order['totalPrice'],
          'userAddress': {
            'name': order['userAddress']['name'],
            'number': order['userAddress']['number'],
            'city': order['userAddress']['city'],
            'homeAddress': order['userAddress']['homeAddress']
          },
          'orderProducts':
              (order['orderProducts'] as List<dynamic>).map((product) {
            return {
              'id': product['id'],
              'name': product['name'],
              'quantity': product['quantity'],
              'weight': product['weight'],
              'price': product['price'],
              'image': product['image'],
            };
          }).toList(),
        };
      }).toList();

      // You can now use this 'orders' list in your app
    } catch (_) {}
  }

  List<Map> activeDeliveries() {
    return orderedProducts.where((order) {
      return order['deliveryUpdate'] == false;
    }).toList();
  }

  List<Map> pastDeliveries() {
    return orderedProducts.where((order) {
      return order['deliveryUpdate'] == true;
    }).toList();
  }

  // for limited time  only

  List<Map> userActiveOrders() {
    return userOrders.where((order) {
      return order['deliveryUpdate'] == false;
    }).toList();
  }

  List<Map> userDelieveredOrders() {
    return userOrders.where((order) {
      return order['deliveryUpdate'] == true;
    }).toList();
  }

  Future<void> deletePrdouctsFromBag() async {
    // Get the current authenticated user
    await _firestore.collection('users').doc(UserId.currentUid).update({
      'bag': FieldValue.delete(),
    });
    _userAddress.clear();
    notifyListeners();
  }

  Map findOrderById(String id) {
    return _orderedProducts.firstWhere((order) {
      return order['id'].toString() == id;
    });
  }

  Map findOrderByIdAdmin(String id) {
    return _userOrders.firstWhere((order) {
      return order['id'].toString() == id;
    });
  }
}
