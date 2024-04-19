import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productive_families/data/local_data/shared_pref.dart';
import 'package:productive_families/data/models/ads_model.dart';
import 'package:productive_families/data/models/product_model.dart';
import 'package:productive_families/data/models/store_model.dart';
import 'package:productive_families/data/models/user_model.dart';

//user
Future createUser(
    {required String name,
    required int age,
    required String email,
    required String gender}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc(email);
  final user = UserModel(
    id: email,
    name: name,
    age: age,
    email: email,
    gender: gender,
    // store: StoreModel(),
  );
  final json = user.toJson();
  await docUser.set(json).then((value) {});
}

Future<UserModel?> getUser() async {
  final docUser =
      FirebaseFirestore.instance.collection('users').doc(getStringAsync("ID"));
  final snapshot = await docUser.get();
  if (snapshot.exists) {
    print(snapshot.exists);
    print(snapshot.data()!);
    return UserModel.fromJson(snapshot.data()!);
  } else {
    return null;
  }
}

//store
Future createStore({
  required String? storeName,
  required String? activityType,
  required String? desciption,
  required String? storeImage,
}) async {
  final docUser = FirebaseFirestore.instance
      .collection('users')
      .doc(getStringAsync('EMAIL'));
  final storeModel = StoreModel(
    id: ('${getStringAsync('EMAIL')} store').toString(),
    storeName: storeName,
    activityType: activityType,
    desciption: desciption,
    storeImage: storeImage,
  );

  final json = storeModel.toJson();
  await setValue('STOREID', '${getStringAsync('EMAIL')} store');
  await docUser.update({'store': json});
}

Future<StoreModel?> getStore() async {
  final docUser =
      FirebaseFirestore.instance.collection('users').doc(getStringAsync("ID"));

  try {
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      final storeData = snapshot.data()?['store'];

      if (storeData != null) {
        print(snapshot.exists);
        print(storeData);
        return StoreModel.fromJson(storeData);
      }
    }
  } catch (e) {
    print("Error getting store: $e");
  }

  return null;
}

//store
Future<void> addProducts({required List<ProductModel> products}) async {
  final docUser =
      FirebaseFirestore.instance.collection('users').doc(getStringAsync('ID'));
  try {
    await docUser.update({
      'store.products': products.map((product) => product.toJson()).toList()
    });
  } catch (e) {
    print("Error updating products: $e");
  }
}

Future updateStore({
  String? storeName,
  String? activityType,
  String? desciption,
  String? storeImage,
}) async {
  final docUser =
      FirebaseFirestore.instance.collection('store').doc('$storeName');
  final storeModel = StoreModel(
    id: docUser.id,
    storeName: storeName,
    activityType: activityType,
    desciption: desciption,
    storeImage: storeImage,
  );
  final json = storeModel.toJson();

  await setValue('DOC', storeName);
  await docUser.update(json);
}

// for delete just add FieldValue.delete()
//docUser.delete()
Future<List<ProductModel?>> getAllProducts() async {
  try {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<ProductModel?> allProducts = [];

    for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
      if (userSnapshot.exists) {
        final dynamic userData = userSnapshot.data();

        if (userData != null && userData['store'] != null) {
          final List<dynamic> productsData =
              userData['store']['products'] ?? [];

          List<ProductModel?> products = productsData
              .map((productData) => ProductModel.fromJson(productData))
              .toList();
          print(products);
          allProducts.addAll(products);
        }
      }
    }

    return allProducts;
  } catch (e) {
    print('Error fetching products: $e');
    return [];
  }
}

Future<List<ProductModel?>> getProductsByType(String type) async {
  try {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<ProductModel?> filteredProducts = [];

    for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
      if (userSnapshot.exists) {
        final dynamic userData = userSnapshot.data();

        if (userData != null && userData['store'] != null) {
          final List<dynamic> productsData =
              userData['store']['products'] ?? [];

          // Filter products by type
          List<ProductModel?> products = productsData
              .map((productData) => ProductModel.fromJson(productData))
              .where((product) => product.type == type) // Filter by type
              .toList();

          filteredProducts.addAll(products);
        }
      }
    }

    return filteredProducts;
  } catch (e) {
    print('Error fetching products by type: $e');
    return [];
  }
}

Future<List<StoreModel?>> getAllStores() async {
  try {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<StoreModel?> allStores = [StoreModel(storeName: "all")];

    for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
      if (userSnapshot.exists) {
        final dynamic userData = userSnapshot.data();

        if (userData != null && userData['store'] != null) {
          final List<Map<String, dynamic>> storesData = [];
          storesData.add(userData['store']);

          List<StoreModel?> stores = storesData
              .map((storesData) => StoreModel.fromJson(storesData))
              .toList();
          print(stores);
          allStores.addAll(stores);
        }
      }
    }

    return allStores;
  } catch (e) {
    print('Error fetching products: $e');
    return [];
  }
}

Future<List<AdsModel?>> getAllAds() async {
  try {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<AdsModel?> allAds = [];

    for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
      if (userSnapshot.exists) {
        final dynamic userData = userSnapshot.data();

        if (userData != null && userData['store'] != null) {
          final List<Map<String, dynamic>> adsData = [];
          adsData.add(userData['store']['ads'] ?? {});

          List<AdsModel?> ads =
              adsData.map((adsData) => AdsModel.fromJson(adsData)).toList();
          print(ads);
          allAds.addAll(ads);
        }
      }
    }

    return allAds;
  } catch (e) {
    print('Error fetching products: $e');
    return [];
  }
}

Future createOrder(
    {required List<ProductModel> product, required UserModel user}) async {
  final docUser = FirebaseFirestore.instance
      .collection('order')
      .doc(Timestamp.now().microsecondsSinceEpoch.toString());

  final json = {
    "user": user.toJson(),
    "products": product.map((e) => e.toJson()).toList(),
    "status": "pending",
    "store": product.map((e) => e.store!.toJson()).toList(),
    "date": DateTime.now().toString()
  };

  await docUser.set(json).then((value) {});
}

// Define a function to get orders by user ID
Future<List<Map<String, dynamic>>> getOrdersByUserId(String userId) async {
  List<Map<String, dynamic>> userOrders = [];

  try {
    // Query the Firestore collection 'order' for orders matching the user ID
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('order')
        .where('user.id', isEqualTo: userId)
        .get();

    // Iterate over the documents returned by the query
    for (var doc in querySnapshot.docs) {
      // Extract order data from each document
      Map<String, dynamic> orderData = {
        'orderId': doc.id,
        'user': doc['user'],
        'products': doc['products'],
        'status': doc['status'],
        'date': doc['date']
      };
      // Add the order data to the list
      userOrders.add(orderData);
    }

    // Return the list of orders matching the user ID
    print(userOrders);
    return userOrders;
  } catch (e) {
    // Handle any errors that occurred during the process
    print('Error fetching orders: $e');
    return []; // Return an empty list in case of error
  }
}

Future<void> deleteOrderByOrderId(String orderId) async {
  try {
    // Get the document reference for the order to delete
    final orderRef =
        FirebaseFirestore.instance.collection('order').doc(orderId);

    // Delete the document
    await orderRef.delete();

    print('Order deleted successfully');
  } catch (e) {
    print('Error deleting order: $e');
    // Handle any errors that occurred during the deletion process
    rethrow;
  }
}

Future<List<ProductModel?>> getRandomProducts() async {
  try {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    List<ProductModel?> allProducts = [];

    for (QueryDocumentSnapshot userSnapshot in querySnapshot.docs) {
      if (userSnapshot.exists) {
        final dynamic userData = userSnapshot.data();

        if (userData != null && userData['store'] != null) {
          final List<dynamic> productsData =
              userData['store']['products'] ?? [];

          // Convert productsData to a list of ProductModel
          List<ProductModel?> products = productsData
              .map((productData) => ProductModel.fromJson(productData))
              .toList();

          allProducts.addAll(products);
        }
      }
    }

    // Shuffle the list of products
    allProducts.shuffle();

    // Return the first two products (or fewer if there are fewer than two products)
    return allProducts.length >= 2 ? allProducts.sublist(0, 2) : allProducts;
  } catch (e) {
    print('Error fetching random products: $e');
    return [];
  }
}
