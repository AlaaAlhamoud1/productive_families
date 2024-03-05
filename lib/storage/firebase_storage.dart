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
  await docUser.set(json).then((value) {
    setValue('ID', email);
    setValue('NAME', name);
    setValue('AGE', age);
    setValue('EMAIL', email);
  });
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
          adsData.add(userData['store']['ads']);

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
