import 'package:bandoan/components/my_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cardNumber = '';

  String expiryDate = '';

  String cardHolderName = '';

  String cvvCode = '';

  bool isCvvFocused = false;

  void tapPay() {
    // if(formKey.currentState == null){
    //   showDialog(context: context, builder: (context) => const AlertDialog(
    //     title: Text("Nhap du thong tin"),
    //   ));
    // }
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Xac nhan'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text("Card Number : $cardNumber"),
                      Text("Expire Day : $expiryDate"),
                      Text("Card Holder Name : $cardHolderName"),
                      Text("CVV : $cvvCode"),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/delivery_progress');
                      },
                      child: const Text("Yes"))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("THANH TOÁN"),
      ),
      body: SingleChildScrollView(
        child: Container(
          // Thêm Container
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Thay đổi tại đây
            children: [
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (p0) {},
              ),
              const SizedBox(height: 20), // Thêm khoảng cách
              CreditCardForm(
                themeColor: Theme.of(context).colorScheme.inversePrimary,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                  });
                },
                formKey: formKey,
              ),
              const SizedBox(height: 20),
              MyButton2(
                text: "Pay Now",
                onPressed: tapPay,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
