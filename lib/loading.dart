import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  final String text;
  const Loading(this.text, {Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: const Alignment(1, 0.8),
              child: Text(
                widget.text,
                style: const TextStyle(color: Colors.orange, fontSize: 40),
              ),
            ),
          ),
          const CircularProgressIndicator(color: Colors.orange),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
