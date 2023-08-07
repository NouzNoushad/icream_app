import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icream/models/cart_model.dart';
import 'package:icream/utils/constants.dart';

class CartService {
  final db = FirebaseFirestore.instance;
  late CartStatus status;

  getICreamCarts() {
    final docRef = db.collection('iCreamCart');
    return docRef.get();
  }

  Future<CartStatus> addICreamToCart(String image, String name, String flavour,
      double price, int count) async {
    final docRef = db.collection('iCreamCart');
    Cart cart = Cart(
      image: image,
      name: name,
      flavour: flavour,
      price: price,
      count: count,
    );
    await docRef.add(cart.toJson()).then((value) {
      status = CartStatus.success;
    }).catchError((err) {
      status = CartStatus.failed;
    });
    return status;
  }

  Future<CartStatus> removeICreamFromCart(String id) async {
    final docRef = db.collection('iCreamCart').doc(id);
    await docRef.delete().then((value) {
      status = CartStatus.success;
    }).catchError((err) {
      status = CartStatus.failed;
    });
    return status;
  }

  incrementCartICreamCount(String id, int count) {
    final docRef = db.collection('iCreamCart').doc(id);
    if (count <= 100) {
      count++;
    } else {
      count = 1;
    }
    return docRef.update({'count': count});
  }

  decrementCartICreamCount(String id, int count) {
    final docRef = db.collection('iCreamCart').doc(id);
    if (count > 1) {
      count--;
    } else {
      count = 1;
    }
    return docRef.update({'count': count});
  }
}
