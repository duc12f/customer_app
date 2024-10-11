import 'package:bandoan/model/product.dart';

class CartItem {
  Food food;
  List<Addon> selectedAddon;
  int quantity;

  CartItem({
    required this.food,
    required this.selectedAddon,
    this.quantity = 1
  });

  double get totalPrice{
    double addonPrice = selectedAddon.fold(0, (sum, addon) => sum + addon.price);
    return (food.price + addonPrice)* quantity;
  }
}