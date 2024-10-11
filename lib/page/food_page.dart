import 'package:bandoan/components/my_button2.dart';
import 'package:bandoan/model/product.dart';
import 'package:bandoan/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodDetail extends StatefulWidget {
  final Food food;
  final Map<Addon, bool> selectedAddon = {};

  FoodDetail({super.key, required this.food}) {
    for (Addon addon in food.availableAddons) {
      selectedAddon[addon] = false;
    }
  }

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {

  //addtocart
  void addToCart(Food food, Map<Addon, bool> selectedAddon){
    Navigator.pushNamed(context, '/home');
    //format selected
    List<Addon> currentSelectedAddons = [];
    for(Addon addon in widget.food.availableAddons){
      if(widget.selectedAddon[addon] == true){
        currentSelectedAddons.add(addon);
      }
    }
    context.read<Restaurant>().addToCart(food, currentSelectedAddons);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image
            Image.asset(widget.food.image),
            // Name
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.food.name,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  // Description
                  Text(
                    widget.food.description,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text("", style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),),
                  const SizedBox(height: 10,),
                  // Addons
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.food.availableAddons.length,
                      itemBuilder: (context, index) {
                        // Get addon
                        Addon addon = widget.food.availableAddons[index];
                    
                        // Return checkbox UI
                        return CheckboxListTile(
                          title: Text(addon.name),
                          subtitle: Text(
                            addon.price.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          value: widget.selectedAddon[addon],
                          onChanged: (bool? value) {
                            setState(() {
                              widget.selectedAddon[addon] = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            MyButton2(
              onPressed: () => addToCart(widget.food, widget.selectedAddon),
              text: 'ADD TO CART',
            ),
          ],
        ),
      ),
    );
  }
}
