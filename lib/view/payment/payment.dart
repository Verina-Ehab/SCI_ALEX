import 'package:flutter/material.dart';
import 'package:sci_alex/reusable_components/background.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          const BackgroundImg(),
          Padding(
            padding: const EdgeInsets.only(left: 60, top: 15),
            child: Column(
              children: const [],
            ),
          ),
        ],
      ),
    ));
  }
}
