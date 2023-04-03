import 'package:flutter/material.dart';

enum ModalSizesENUM { xs, full }

final Map<ModalSizesENUM, double> modalSizes = {
  ModalSizesENUM.xs: 0.35,
  ModalSizesENUM.full: 0.95
};

class WdBottomModal extends StatelessWidget {
  final Widget button;
  final Widget modalContent;
  final ModalSizesENUM? size;
  const WdBottomModal(
      {required this.button,
      required this.modalContent,
      this.size = ModalSizesENUM.full,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        child: Center(
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent)),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                // isScrollControlled: true,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                      heightFactor: modalSizes[size],
                      child: Container(
                        color: Theme.of(context).colorScheme.background,
                        child: Column(
                          children: [

                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            Expanded(child: modalContent)
                          ],
                        ),
                      )
                      );
                },
              );
            },
            child: button,
          ),
        ));
  }
}
