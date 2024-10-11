import 'package:bandoan/model/product.dart';
import 'package:flutter/material.dart';

class MyFoodTitle extends StatelessWidget {
  final Food food;
  final void Function()? onTap;
  
  const MyFoodTitle({
    super.key,
    required this.food,
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.name),
                    Text(food.price.toString(),
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                    Text(food.description, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                  ],
                ),
                ),
            
                //image
                const SizedBox(width: 15,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(food.image, height: 100, width: 120,)),
              ],
            ),
          ),
        ),
        Divider(
        color: Theme.of(context).colorScheme.tertiary,
        endIndent: 25,
        indent: 25,),
      ],
    );
  }
}