import 'package:flutter/material.dart';

class NewfloatingButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  bool isButtonPressed;
  String partExample;
  String partPass;

  NewfloatingButton({
    Key? key,
    this.onTap,
    required this.isButtonPressed,
    required this.partExample,
    required this.partPass,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: 60,
          width: 160,
          decoration: BoxDecoration(
              color: isButtonPressed
                  ? Colors.green.shade200
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: isButtonPressed
                      ? Colors.green.shade200
                      : Colors.grey.shade100),
              boxShadow: isButtonPressed
                  ? [
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
                    ]
                  : []),
          child: Row(children: [
            Container(
              width: 5,
            ),
            Transform.scale(
                scale: 1.5,
                child: (isButtonPressed)
                    ? const Icon(
                        Icons.task_alt_outlined,
                        color: Colors.black,
                      )
                    : const Icon(Icons.radio_button_unchecked_outlined,
                        color: Colors.grey)),
            Container(
              width: 10,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                partExample,
                style: TextStyle(
                    fontSize: 20,
                    color: (isButtonPressed) ? Colors.black : Colors.grey),
              ),
              Container(
                height: 5,
              ),
              Text(
                partPass,
                style: TextStyle(
                    fontSize: 20,
                    color: (isButtonPressed) ? Colors.black : Colors.grey),
              ),
            ]),
          ]),
        ));
  }
}
