import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;

  CustomBottomSheet(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(children: [
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        child,
      ]),
    );
  }

  static showCustomBottomSheet({BuildContext context, Widget child}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (modalContext) {
        return CustomBottomSheet(child);
      },
    ).then((_) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }
}
