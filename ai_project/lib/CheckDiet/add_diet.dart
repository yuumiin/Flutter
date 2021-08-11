import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

class AddButton extends StatefulWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false; // true로 하면 타원모양됨
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.Up;
  var selectedfABLocation = FloatingActionButtonLocation.endFloat;

  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource source) async {
      // XFile image = await picker.pickImage(sou)
      final PickedFile = await picker.getImage(source: source);
      setState(() {
        _image = File(PickedFile!.path);
      });
    }

    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: SpeedDial(
        icon: Icons.add_rounded,
        activeIcon: Icons.close_rounded,
        backgroundColor: Colors.blue[900],
        spacing: 3,
        openCloseDial: isDialOpen,
        childPadding: EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        buttonSize: 56,
        iconTheme: IconThemeData(size: 33),

        label: extend ? Text("Open") : null,
        activeLabel: extend ? Text("Close") : null,

        childrenButtonSize: 56.0,
        visible: visible,
        direction: speedDialDirection,
        switchLabelPosition: switchLabelPosition,

        closeManually: closeManually,

        renderOverlay: renderOverlay,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        useRotationAnimation: useRAnimation,
        elevation: 8.0,
        isOpenOnStart: false,
        animationSpeed: 200, // + 아이콘 돌아가는 속도
        // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          SpeedDialChild(
            child: !rmicons ? Icon(Icons.add_a_photo_rounded) : null,
            backgroundColor: Colors.indigo, // 버튼 배경 색
            foregroundColor: Colors.white, // 아이콘 색
            label: '카메라로 추가하기',
            onTap: () => {
              print("카메라"),
              getImage(ImageSource.camera),
            },
          ),
          SpeedDialChild(
            child: !rmicons ? Icon(Icons.collections_rounded) : null,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            label: '앨범에서 불러오기',
            onTap: () => {
              print("앨범"),
              getImage(ImageSource.gallery),
            },
          ),
          SpeedDialChild(
            child: !rmicons ? Icon(Icons.post_add_rounded, size: 30) : null,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            label: '텍스트로 추가하기',
            visible: true,
            onTap: () => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(("텍스트")))),
          ),
        ],
      ),
    );
  }
}
