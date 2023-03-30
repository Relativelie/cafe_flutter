import 'package:flutter/material.dart';

enum ModalSizesENUM { xs, full }

// Map<ModalSizesENUM, double> modalSizes = {
//   ModalSizesENUM.xs: 0.35,
//   ModalSizesENUM.full: 0.95
// };

// class BottomModal extends StatefulWidget {
//   final Widget button;
//   final Widget modalContent;
//   ModalSizesENUM? size;
//   BottomModal(
//       {required this.button,
//       required this.modalContent,
//       this.size = ModalSizesENUM.full,
//       super.key});

//   // const BottomModal({super.key});

//   @override
//   State<BottomModal> createState() => _BottomModalState();
// }

// class _BottomModalState extends State<BottomModal> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(Colors.transparent),
//             shadowColor: MaterialStateProperty.all(Colors.transparent)),
//         onPressed: () {
//           showModalBottomSheet<void>(
//             context: context,
//             isScrollControlled: true,
//             builder: (BuildContext context) {
//               return FractionallySizedBox(
//                   heightFactor: modalSizes[widget.size],
//                   child: widget.modalContent);
//             },
//           );
//         },
//         child: widget.button,
//       ),
//     );
//   }
// }

class BottomModal extends StatelessWidget {
  final Widget button;
  final Widget modalContent;
  ModalSizesENUM? size;
  BottomModal(
      {required this.button,
      required this.modalContent,
      this.size = ModalSizesENUM.full,
      super.key});

  final Map<ModalSizesENUM, double> _modalSizes = {
    ModalSizesENUM.xs: 0.35,
    ModalSizesENUM.full: 0.95
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                  heightFactor: _modalSizes[size], child: modalContent);
            },
          );
        },
        child: button,
      ),
    );
  }
}
