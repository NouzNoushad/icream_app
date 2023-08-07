import 'package:flutter/material.dart';
import 'package:icream/services/cart_service.dart';

import '../screens/widgets/dialog_box.dart';
import '../utils/constants.dart';

class CartProvider extends ChangeNotifier {
  CartService cartService = CartService();

  addICreamToCart(context, String image, String name, String flavour,
      double price, int count) async {
    var response =
        await cartService.addICreamToCart(image, name, flavour, price, count);
    if (response == CartStatus.success) {
      showAlertDialog(
        context: context,
        title: 'Success',
        content: 'Created your new account',
        status: Status.success,
      );
    } else if (response == CartStatus.failed) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'User already exists',
        status: Status.failed,
      );
    }
  }

  removeICreamFromCart(context, String id) async {
    var response = await cartService.removeICreamFromCart(id);
    if (response == CartStatus.success) {
      showAlertDialog(
        context: context,
        title: 'Success',
        content: 'Created your new account',
        status: Status.success,
      );
    } else if (response == CartStatus.failed) {
      showAlertDialog(
        context: context,
        title: 'Error',
        content: 'User already exists',
        status: Status.failed,
      );
    }
  }

  incrementCartICreamCount(String id, int count) async {
    var response = await cartService.incrementCartICreamCount(id, count);
    return response;
  }

  decrementCartICreamCount(String id, int count) async {
    var response = await cartService.decrementCartICreamCount(id, count);
    return response;
  }
}
