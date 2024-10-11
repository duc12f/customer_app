
import 'package:bandoan/components/my_button.dart';
import 'package:bandoan/components/my_cart_title.dart';
import 'package:bandoan/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        //cart
        final useCart = restaurant.cart;

        //
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Are you sure want to clear the cart ? '),
                      actions: [
                        //cancel
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('CANCEL'),),

                        //YES
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            restaurant.clearCart();
                          },
                          child: const Text('YES'))
                      ],
                    ));
                },
                icon: const Icon(Icons.delete),)
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    useCart.isEmpty ? const Expanded(child: Center(child: Text('Cart is Empty'))):
                    Expanded(
                      child: ListView.builder(
                          itemCount: useCart.length,
                          itemBuilder: (context, index) {
                            final cartItem = useCart[index];
                            return MyCartTitle(cartItem: cartItem);
                          }),
                    )
                  ],
                ),
              ),
              //button
              const MyButton(routeName: '/payment', text: "Thanh toán"),
              const SizedBox(height: 20,)
            ],
          ),
        );
      },
    );
  }
}
