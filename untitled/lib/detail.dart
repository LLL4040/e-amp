import 'package:flutter/material.dart';
import 'package:untitled/Activity.dart';
import 'package:untitled/room.dart';
import 'package:untitled/User.dart';
import 'package:fluttertoast/fluttertoast.dart';

class detail extends StatefulWidget {
  final User user;
  final Activity activity;
  detail({Key key,@required this.user,@required this.activity}):super(key:key);
  @override
  State<StatefulWidget> createState() => detailState(activity: this.activity,user: this.user);
}

class detailState extends State<detail> with NetListener{
  final Activity activity;
  final User user;
  detailState({@required this.activity,@required this.user});
  activityHttp manager = new activityHttp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[

                ListTile(
                  subtitle: Text('起始时间: '+activity.getStart()),
                  trailing: Icon(Icons.access_alarms),
                  onTap: (){
                    DateTime last = DateTime.now();
                    DateTime start = DateTime.parse(activity.getStart());
                    DateTime end = DateTime.parse(activity.getEnd());
                    if(end.isBefore(last)){
                      Fluttertoast.showToast(
                        msg: "活动已结束",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    }
                    if(start.isAfter(last)){
                      Fluttertoast.showToast(
                        msg: "活动未开始",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    }
                    if(start.isBefore(last)){
                      Navigator.push<String>(context,
                          new MaterialPageRoute(builder: (context) {
                            return new room(activity: activity,user: user,);
                          }));
                    }

                  },
                ),
                ListTile(
                  subtitle: Text('终止时间: '+activity.getEnd()),
                ),
                ListTile(
                  title: Text(activity.getName(),style: TextStyle(fontSize: 28)),
                  subtitle: Text(activity.getTags()),
                  leading: new Image.network(activity.getImgurl()),
                ),
                Divider(),
                ListTile(
                  title: Text(activity.getDescription()),
                ),
                ListTile(
                    title: Text('地点:  '+activity.getLocation()),
                    subtitle: Text('主办方:  '+activity.getSponsor()),
                ),
                ListTile(
                  title: Text('活动人数'+activity.getNum().toString()),
                ),
                ListTile(
                  title: new Text('参加活动'),
                  trailing: Icon(Icons.check_circle),
                  onTap: (){
                    _joinActivity();
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                      msg: "参加成功",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                  },
                ),
                ListTile(
                  title: new Text('举报活动'),
                  trailing: Icon(Icons.warning),
                  onTap: (){
                    showDialog<Null>(
                      context: context,
                      builder: (BuildContext context) {
                        return new SimpleDialog(
                          title: new Text('选择'),
                          children: <Widget>[
                            new SimpleDialogOption(
                              child: new Text('淫秽色情'),
                              onPressed: () async {
                                await _accuActivity('淫秽色情');
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                    msg: "举报成功",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                );
                              },
                            ),
                            new SimpleDialogOption(
                            ),
                            new SimpleDialogOption(
                              child: new Text('人身攻击'),
                              onPressed: () {
                                _accuActivity('人身攻击');
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                  msg: "举报成功",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );
                              },
                            ),
                            new SimpleDialogOption(
                            ),
                            new SimpleDialogOption(
                              child: new Text('违法活动'),
                              onPressed: () {
                                _accuActivity('违法行动');
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                  msg: "举报成功",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );

                              },
                            ),
                            new SimpleDialogOption(
                            ),
                            new SimpleDialogOption(
                              child: new Text('返回'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    ).then((val) {
                      print(val);
                    });
                  },
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
  _joinActivity() async {
    print("join activity");

    await manager.joinActivity(this,user.getUsername(),int.parse(activity.getId()));
    return true;
  }
  _accuActivity(String content) async {
    print("join activity");

    await manager.accuActivity(this,user.getUsername(),int.parse(activity.getId()),content);
    return true;
  }

  @override
  onMyNoticeResponse(List<Activity> activities){
  }
  @override
  void onAddActivityResponse(String result) {
    // TODO: implement onAddActivityResponse
  }
  @override
  void onError(error) {}
}
