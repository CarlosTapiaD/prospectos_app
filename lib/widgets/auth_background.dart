import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            _PurpleBox(),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                child: const Icon(
                  Icons.person_pin,
                  size: 150,
                  color: Colors.white,
                )),
            child
          ],
        ));
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      width: double.infinity,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          // Positioned(
          //   child: _Buggle(),
          //   top: 90,
          //   left: 1200,
          // ),
          // Positioned(
          //   child: _Buggle(),
          //   left: 500,
          //   bottom: 250,
          // ),
          // Positioned(
          //   child: _Buggle(),
          //   left: 900,
          //   bottom: 500,
          // ),
          // Positioned(child: _Buggle())
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

class _Buggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
