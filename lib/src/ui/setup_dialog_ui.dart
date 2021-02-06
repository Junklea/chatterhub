import 'package:chatterhub/src/app/locator.dart';
import 'package:chatterhub/src/enum/dialog_type.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  var dialogService = getIt<DialogService>();

  final builders = {
    DialogType.Basic: (context, sheetRequest, completer) =>
        _BasicCustomDialog(dialogRequest: sheetRequest, onDialogTap: completer),
    DialogType.Form: (context, sheetRequest, completer) =>
        _FormDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicCustomDialog extends StatelessWidget {
  final DialogRequest dialogRequest;
  final Function(DialogResponse) onDialogTap;
  const _BasicCustomDialog({Key key, this.dialogRequest, this.onDialogTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            dialogRequest.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            dialogRequest.description,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => onDialogTap(DialogResponse(confirmed: true)),
            child: Container(
              child: dialogRequest.showIconInMainButton
                  ? Icon(Icons.check_circle)
                  : Text(dialogRequest.mainButtonTitle),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _FormDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _FormDialog({Key key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lol = TextEditingController();

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              request.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: lol,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => completer(DialogResponse(responseData: [lol.text])),
              child: Container(
                child: request.showIconInMainButton
                    ? Icon(Icons.check_circle)
                    : Text(request.mainButtonTitle),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _FormCustomDialog extends HookWidget {
//   final DialogRequest dialogRequest;
//   final Function(DialogResponse) onDialogTap;
//   const _FormCustomDialog({Key key, this.dialogRequest, this.onDialogTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var controller = useTextEditingController();
// return Container(
//   padding: const EdgeInsets.all(20),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(10),
//   ),
// child: Column(
//   crossAxisAlignment: CrossAxisAlignment.center,
//   mainAxisSize: MainAxisSize.min,
//   children: <Widget>[
//     Text(
//       dialogRequest.title,
//       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
//     ),
//     SizedBox(
//       height: 20,
//     ),
//     TextField(
//       controller: controller,
//     ),
//     SizedBox(
//       height: 20,
//     ),
//     GestureDetector(
//       onTap: () =>
//           onDialogTap(DialogResponse(responseData: [controller.text])),
//       child: Container(
//         child: dialogRequest.showIconInMainButton
//             ? Icon(Icons.check_circle)
//             : Text(dialogRequest.mainButtonTitle),
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.redAccent,
//           borderRadius: BorderRadius.circular(5),
//         ),
//       ),
//     )
//   ],
// ),
//     );
//   }
// }
