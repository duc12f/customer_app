import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  final CollectionReference orders = 
  FirebaseFirestore.instance.collection('orders');

  //save orders to database
  Future<void> saveOrderToDatabase(String receipt)async {
    await orders.add({
      'date' : DateTime.now(),
      'orders' : receipt,
    }
    );
  }
}