import 'package:flutter/material.dart';
import 'package:prospectos_app/ui/input_decoration.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Container(
          width: 500,
          decoration: _boxDecorationCard(),
          padding: EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }

  BoxDecoration _boxDecorationCard() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 15, offset: Offset(10, 5))
          ]);
}
