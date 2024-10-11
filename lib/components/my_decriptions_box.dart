import 'package:flutter/material.dart';
class MyDecriptionsBox extends StatelessWidget {
  const MyDecriptionsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //delivery fee
          Column(
            children: [
              Text('10.000 VND', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
              Text('Ship fee', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
            ],
          ),

          Column(
            children: [
              Text('15- 30p', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
              Text('Delivery time', style: TextStyle(color: Theme.of(context).colorScheme.primary),),
            ],
          )
        ],
      ),
    );
  }
}