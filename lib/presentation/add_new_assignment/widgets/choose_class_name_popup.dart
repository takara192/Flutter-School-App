import 'package:flutter/material.dart';

class ChooseClassNamePopup extends StatelessWidget {
  const ChooseClassNamePopup({
    super.key,
    required this.closePopup,
  });

  final void Function() closePopup;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: InkWell(
        onTap: closePopup,
        child: Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: InkWell(
              onTap: () {

              },
              child: Container(
                width: 300,
                height: 300,
                color: Colors.white,
                child: Column(
                  children: [
                    Text('Choose class name'),
                    TextField(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
