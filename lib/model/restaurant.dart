import 'package:bandoan/model/cart_item.dart';
import 'package:bandoan/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Restaurant extends ChangeNotifier {
  var logger = Logger();
  // Định nghĩa danh sách món ăn (ban đầu là rỗng)
  // ignore: prefer_final_fields
  List<Food> _menu = [];

  // Getters
  
  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  // Địa chỉ giao hàng
  String _deliveryAddress = "356/52";

  // Giỏ hàng
  final List<CartItem> _cart = [];

  // Thêm món vào giỏ hàng
  void addToCart(Food food, List<Addon> selectedAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      bool isSameAddons = const ListEquality().equals(item.selectedAddon, selectedAddons);
      return isSameAddons && isSameFood;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, selectedAddon: selectedAddons));
    }

    notifyListeners();
  }

  // Xóa món khỏi giỏ hàng
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (_cart[cartIndex].quantity > 1) {
      _cart[cartIndex].quantity--;
    } else {
      _cart.removeAt(cartIndex);
    }

    notifyListeners();
  }

  // Xóa toàn bộ giỏ hàng
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Tính tổng giá trị giỏ hàng
  double totalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      for (Addon addon in cartItem.selectedAddon) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

  // Tính tổng số lượng sản phẩm trong giỏ hàng
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // Cập nhật địa chỉ giao hàng
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  // Tạo hóa đơn
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt");
    receipt.writeln();

    // Định dạng ngày giờ
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-------------");

    for (final cartItem in _cart) {
      receipt.writeln(
        "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}"
      );
      if (cartItem.selectedAddon.isNotEmpty) {
        receipt.writeln("  Add-ons: ${_formatAddons(cartItem.selectedAddon)}");
      }
      receipt.writeln();
    }

    receipt.writeln("--------");
    receipt.writeln();
    receipt.writeln("Total items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(totalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivery to: $deliveryAddress");

    return receipt.toString();
  }

  // Định dạng giá tiền
  String _formatPrice(double price) {
    return "${price.toStringAsFixed(2)} đ";
  }

  // Định dạng Addons
  String _formatAddons(List<Addon> addons) {
    return addons.map((addon) => "${addon.name} (${_formatPrice(addon.price)})").join(', ');
  }

  // Lấy dữ liệu từ Firebase và cập nhật menu
  Future<void> fetchMenuFromFirebase() async {
    try {
      // Truy cập tới collection 'menu' trong Firestore
      final CollectionReference menuCollection = FirebaseFirestore.instance.collection('menu');

      // Lấy tất cả các tài liệu trong collection 'menu'
      QuerySnapshot querySnapshot = await menuCollection.get();

      // Làm trống danh sách menu trước khi thêm dữ liệu mới
      _menu.clear();

      // Duyệt qua các document và thêm vào danh sách _menu
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        List<Addon> addons = (data['availableAddons'] as List).map((addonData) {
          return Addon(
            name: addonData['name'],
            price: addonData['price'],
          );
        }).toList();

        Food food = Food(
          name: data['name'],
          description: data['description'],
          image: data['image'],
          price: data['price'],
          category: _parseCategory(data['category']),
          availableAddons: addons,
        );

        _menu.add(food);
      }

      notifyListeners();
      logger.d('Lấy dữ liệu từ Firebase và cập nhật menu thành công.');
    } catch (e) {
      logger.d('Lỗi khi lấy dữ liệu từ Firebase: $e');
    }
  }

  // Phương thức để chuyển chuỗi thành FoodCategory
  FoodCategory _parseCategory(String categoryString) {
    switch (categoryString) {
      case 'FoodCategory.burgers':
        return FoodCategory.burgers;
      case 'FoodCategory.deserts':
        return FoodCategory.deserts;
      case 'FoodCategory.drinks':
        return FoodCategory.drinks;
      case 'FoodCategory.salad':
        return FoodCategory.salad;
      default:
        throw Exception('Loại món ăn không hợp lệ');
    }
  }
}
