import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Activity.dart';
import 'package:untitled/User.dart';
import 'dart:async';
import 'mainpage.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddActivity extends StatefulWidget {
  final User user;
  AddActivity({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() => _DateTimeDemoState(user: user);
}

class _DateTimeDemoState extends State<AddActivity> with SingleTickerProviderStateMixin,NetListener{
  String res = '';
  final User user;
  _DateTimeDemoState({@required this.user});
  final TextEditingController _aname =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));
  final TextEditingController _adetail =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));

  final TextEditingController _atitle =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));
  final TextEditingController _alocation =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));
  final TextEditingController _anum =
  new TextEditingController.fromValue(new TextEditingValue(text: ""));
  //http
  activityHttp manager = new activityHttp();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 30);
  DateTime Date = DateTime.now();
  TimeOfDay Time = TimeOfDay(hour: 21, minute: 30);

  Future<void> _selectDate() async //异步
      {
    final DateTime date = await showDatePicker( //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      selectedDate = date;
    });
  }
  Future<void> _sDate() async //异步
      {
    final DateTime date = await showDatePicker( //等待异步处理的结果
      //等待返回
      context: context,
      initialDate: Date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date == null) return; //点击DatePicker的cancel

    setState(() {
      //点击DatePicker的OK
      Date = date;
    });
  }
  Future<void> _sTime() async {//异步
    final TimeOfDay time = await showTimePicker( //等待异步处理的结果
      context: context,
      initialTime: Time,
    );
    if (time == null) return;

    setState(() {
      Time = time;
    });
  }

  Future<void> _seletedTime() async {//异步
    final TimeOfDay time = await showTimePicker( //等待异步处理的结果
      context: context,
      initialTime: selectedTime,
    );
    if (time == null) return;

    setState(() {
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('发起活动'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: (){
              _addActivity();
              Fluttertoast.showToast(
                msg: "添加活动成功",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (context) {
                    return new MysApp(user: user,);
                  }));
            },
          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    //包装一个相应点击的组件
                    onTap: _selectDate,
                    child: Row(
                      children: <Widget>[
                        // Text(DateFormat.yMd().format(selectedDate)),// 5/10/2019
                        // Text(DateFormat.yMMM().format(selectedDate)),// May 2019
                        Text(DateFormat.yMMMd()
                            .format(selectedDate)), // May 10, 2019
                        // Text(DateFormat.yMMMMd().format(selectedDate)),// May 10, 2019
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  InkWell(
                    //包装一个相应点击的组件
                    onTap: _seletedTime,
                    child: Row(
                      children: <Widget>[
                        Text(selectedTime.format(context)), // May 10, 2019
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    //包装一个相应点击的组件
                    onTap: _selectDate,
                    child: Row(
                      children: <Widget>[
                        // Text(DateFormat.yMd().format(selectedDate)),// 5/10/2019
                        // Text(DateFormat.yMMM().format(selectedDate)),// May 2019
                        Text(DateFormat.yMMMd()
                            .format(Date)), // May 10, 2019
                        // Text(DateFormat.yMMMMd().format(selectedDate)),// May 10, 2019
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  InkWell(
                    //包装一个相应点击的组件
                    onTap: _seletedTime,
                    child: Row(
                      children: <Widget>[
                        Text(Time.format(context)), // May 10, 2019
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  )
                ],
              ),
              new Container(
                color: Colors.white,
                height: 30.0,
                width: 0.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(
                          0.0, 0.0, 5.0, 0.0),
                      child: Icon(Icons.assignment),
                    ),
                    new Expanded(
                        child: new TextField(
                          controller: _aname,
                          decoration: new InputDecoration(
                            hintText: '请输入活动名称',
                          ),
                          obscureText: false,
                        )),
                  ]
              ),
              new Container(
                color: Colors.white,
                height: 30.0,
                width: 0.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(
                          0.0, 0.0, 5.0, 0.0),
                      child: Icon(Icons.perm_identity),
                    ),
                    new Expanded(
                        child: new TextField(
                          controller: _atitle,
                          decoration: new InputDecoration(
                            hintText: '请输入活动标签',
                          ),
                          obscureText: false,
                        )),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(
                          0.0, 0.0, 5.0, 0.0),
                      child: Icon(Icons.location_city),
                    ),
                    new Expanded(
                        child: new TextField(
                          controller: _alocation,
                          decoration: new InputDecoration(
                            hintText: '请输入活动地址',
                          ),
                          obscureText: false,
                        )),
                  ]
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: new EdgeInsets.fromLTRB(
                          0.0, 0.0, 5.0, 0.0),
                      child: Icon(Icons.people),
                    ),
                    new Expanded(
                        child: new TextField(
                          controller: _anum,
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: '请输入活动人数',
                          ),
                          obscureText: true,
                        )),
                  ]
              ),

              new Container(
                color: Colors.white,
                height: 30.0,
                width: 0.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(
                        0.0, 0.0, 0.0, 5.0),
                  ),
                  new Expanded(
                      child: new Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              maxLines: 8,
                              controller: _adetail,
                              decoration: InputDecoration.collapsed(hintText: "请输入活动详情"),
                            ),
                          )
                      ))
                ],
              )
            ],
          ),
        ),
      )
    );
  }
  _addActivity() async {
    print("addActivity");

    await manager.addActivity(this,_aname.text,_atitle.text
        ,Date.toString(),
        selectedDate.toString(),int.parse(_anum.text),
    user.getUsername(),_alocation.text,_adetail.text);
    print("返回"+res);
  }
  @override
  onMyNoticeResponse(List<Activity> activities){
  }
  @override
  void onAddActivityResponse(String result) {
    // TODO: implement onAddActivityResponse
    res = "ddd";
    print('返回结果'+res);
  }
  @override
  void onError(error) {}
}
