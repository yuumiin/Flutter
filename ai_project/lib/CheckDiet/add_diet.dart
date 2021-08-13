import 'dart:io';
import 'package:ai_project/CheckDiet/check_diet.dart';
import 'package:ai_project/MemberInfo/management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:group_button/group_button.dart';
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

  File? image;
  final picker = ImagePicker();

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if (image != null) {
      change();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future pickImage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;

        final imageTemporary = File(image.path);
        setState(() {
          this.image = imageTemporary;
        });
      } on PlatformException catch (e) {
        print('Failed to picl image: $e');
      }
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
              pickImage(ImageSource.camera),
            },
          ),
          SpeedDialChild(
            child: !rmicons ? Icon(Icons.collections_rounded) : null,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            label: '앨범에서 불러오기',
            onTap: () => {
              print("앨범"),
              pickImage(ImageSource.gallery),
              // image != null ? change() : FlutterLogo(),
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

  change() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WriteDiet(image!)),
    );
  }
}

class WriteDiet extends StatefulWidget {
  WriteDiet(this.image);
  final File image;

  @override
  State<WriteDiet> createState() => _WriteDietState();
}

class _WriteDietState extends State<WriteDiet> {
  List<String> button_value = ["아침", "점심", "저녁"];
  TextEditingController month_value = TextEditingController();
  TextEditingController day_value = TextEditingController();
  File? new_image; // 다시 선택하기 버튼 누를 때 불러올 이미지 변수

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.new_image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to picl image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('식단관리앱'),
        backgroundColor: Color(0xFF151026),
        centerTitle: true,
        elevation: 0.0, // 그림자생김
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print('button is clicked');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Management()));
            },
            icon: Icon(Icons.person, size: 30),
            padding: EdgeInsets.only(right: 15, left: 15),
            // 왼쪽도 패딩을 같이 줘야 터치반응액션이 아이콘 중앙에 있게됨
          ),
        ], // 1개 이상의 위젯 리스트를 가짐
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  margin: EdgeInsets.only(top: 20),
                  // color: Colors.amber,
                  width: 300,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: new_image != null
                        ? Image.file(
                            new_image!,
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            widget.image,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.5),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                // color: Colors.yellow,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('다시 선택하기'),
                    OutlinedButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      child: const Text(
                        '카메라',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NanumSquare',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1.5, color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // <-- Radius
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: const Text(
                        '갤러리',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NanumSquare',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(width: 1.5, color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // <-- Radius
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2.5,
                color: Colors.grey[300],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      '날짜',
                      style: TextStyle(fontSize: 15, fontFamily: 'NanumSquare'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4, left: 8),
                        child: SizedBox(
                          width: 45,
                          height: 35,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: month_value,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: '월'),
                          ),
                        ),
                      ),
                      const Text(
                        '월',
                        style:
                            TextStyle(fontSize: 15, fontFamily: 'NanumSquare'),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4, left: 8),
                        child: SizedBox(
                          width: 45,
                          height: 35,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: day_value,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: '일'),
                          ),
                        ),
                      ),
                      const Text(
                        '일',
                        style:
                            TextStyle(fontSize: 15, fontFamily: 'NanumSquare'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "식사 시간",
                      style: TextStyle(fontSize: 15, fontFamily: 'NanumSquare'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    GroupButton(
                      mainGroupAlignment: MainGroupAlignment.start,
                      crossGroupAlignment: CrossGroupAlignment.start,
                      groupRunAlignment: GroupRunAlignment.start,
                      isRadio: true,
                      spacing: 10,
                      buttons: button_value,
                      onSelected: (index, isSelected) => print(
                          '$index button is selected ' + button_value[index]),
                      selectedTextStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      selectedColor: Colors.grey[100],
                      unselectedBorderColor: Colors.grey[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 18, left: 18, top: 5),
                // color: Colors.green
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    // side: BorderSide(color: Color(0xFF151026), width: 5),
                  ),
                  onPressed: () {
                    return_image();
                  },
                  child: const Text(
                    '등록',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  return_image() {
    new_image == null
        ? Navigator.of(context).pushNamed('/second', arguments: widget.image)
        : Navigator.of(context).pushNamed('/second', arguments: new_image);
  }
}
