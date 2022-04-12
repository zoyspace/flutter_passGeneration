import 'package:flutter/material.dart';

class FloatingButton_generate extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  bool isButtonPressed;

  FloatingButton_generate({
    Key? key,
    this.onTap,
    required this.isButtonPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 30,
          width: 160,
          child: Row(children: [
            Icon(Icons.favorite,
                size: 30,
                color: isButtonPressed ? Colors.red[100] : Colors.red[500]),
            Text('generate'),
          ]),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: isButtonPressed
                      ? Colors.grey.shade200
                      : Colors.grey.shade300),
              boxShadow: isButtonPressed
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(6, 6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        offset: Offset(-6, -6),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ]),
        ));
  }
}
