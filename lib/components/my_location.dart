import 'package:bandoan/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class MyLocation extends StatelessWidget {
  MyLocation({super.key});
  
  final TextEditingController textController = TextEditingController();

  void openLocationSearchBox(BuildContext context){
    showDialog(context: context,
     builder: (context) => AlertDialog(
      title: const Text('Your location'),
      content: TextField(
        controller: textController,
        decoration: const InputDecoration(hintText: "Enter Address"),
      ),
      actions: [
        MaterialButton(onPressed: () {
          Navigator.pop(context);
          textController.clear();},
        child: const Text('Cancel'),),

        MaterialButton(
          onPressed: () {
            String newAddress = textController.text;
            context.read<Restaurant>().updateDeliveryAddress(newAddress);
            Navigator.pop(context);},
        child: const Text('Save'),)
      ],
     )
     );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Deliver now",style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
          ),),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                //address
                Consumer<Restaurant>(builder: (context, restaurant, child) => 
                Text(restaurant.deliveryAddress)
                ,),
                //dropdown
                const Icon(Icons.keyboard_arrow_down_rounded,),
              ],
            ),
          )
        ],
      ),
    );
  }
}