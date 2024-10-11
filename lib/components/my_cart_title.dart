import 'package:bandoan/components/my_quantity_selector.dart';
import 'package:bandoan/model/cart_item.dart';
import 'package:bandoan/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTitle extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTitle({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (context, restaurant, child) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            cartItem.food.image,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.food.name),
                            Text(cartItem.food.price.toString()),
                            
                            const SizedBox(height: 10,),
                            MyQuantitySelector(
                              quantity: cartItem.quantity,
                              food: cartItem.food,
                              onDecrement: () {
                                restaurant.removeFromCart(cartItem);
                              },
                              onIncrement: () {
                                restaurant.addToCart(
                                    cartItem.food, cartItem.selectedAddon);
                              },
                            )
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  //addon
                  SizedBox(
                    height: cartItem.selectedAddon.isEmpty ? 0 : 60,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(10),
                        children: cartItem.selectedAddon
                            .map((addon) => Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: FilterChip(
                                    label: Row(
                                      children: [
                                        Text(addon.name),
                                        Text(addon.price.toString()),
                                      ],
                                    ),
                                    shape: StadiumBorder(
                                        side: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                                    onSelected: (value) {},
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    labelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ))
                            .toList()),
                  )
                ],
              ),
            ));
  }
}
