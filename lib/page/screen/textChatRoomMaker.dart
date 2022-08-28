import 'package:flutter/material.dart';
import 'package:salondec/component/custom_input_field.dart';
import 'package:salondec/component/custom_input_field_multi.dart';
import 'package:salondec/component/custom_form_buttom.dart';

class Textchat_making_room extends StatefulWidget {
  final String username;
  const Textchat_making_room({Key? key, required this.username}) : super(key: key);

  @override
  _Textchat_making_roomState createState() => _Textchat_making_roomState();
}

class _Textchat_making_roomState extends State<Textchat_making_room> {
  final _titleFieldController = TextEditingController();
  final _contentFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("글쓰기"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child:Column(
           children: [
                    SizedBox(height: 100),
                    CustomInputField(
                      controller: _titleFieldController,
                      labelText: '제목',
                      hintText: '무엇을 이야기하고 싶은가요?',
                      isDense: true,
                      validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return '제목을 넣어주세요!';
                          }
                          return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomInputField_multi(
                      controller: _contentFieldController,
                      labelText: '내용',
                      hintText: '주저리주저리 얘기해도 괜찮아요',
                      isDense: true,
                      validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return '내용을 넣어주세요!';
                          }
                          return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomFormButton(
                        innerText: '게시하기',
                        onPressed:(){
                          
                          }
                      ),
                    SizedBox(height: 200),
                  ],
                ),
        )
      )
    );
  }
}
