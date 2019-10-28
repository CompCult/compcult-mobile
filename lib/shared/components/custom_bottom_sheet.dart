import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;

  CustomBottomSheet(this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      color: Colors.white,
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
