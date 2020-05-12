import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Activity.dart';
import 'package:untitled/User.dart';
import 'package:untitled/pricePage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

var  res ='{"winers":"sss","starter":"11111","prize":"ipad"}';

class room extends StatelessWidget {
  final Activity activity;
  final User user;
  room({Key key,@required this.activity,@required this.user}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: activity.getName()+"活动室",
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: new ChatScreen(
        channel: new IOWebSocketChannel.connect('ws://202.120.40.8:30401//websocket/api/room/'+activity.getId()),
        user: this.user,
        activity: this.activity,
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    var map = json.decode(text);
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOut
        ),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(child: new Text(map['user'].toString())),
              ),
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(map['user'], style: Theme.of(context).textTheme.subhead),
                    new Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: new Text(map['content'].toString()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}

class ChatScreen extends StatefulWidget {
  final WebSocketChannel channel;
  final User user;
  final Activity activity;
  ChatScreen({@required this.channel,@required this.user,@required this.activity});
  @override
  State createState() => new ChatScreenState(user: this.user,activity: this.activity);
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin,NetListener {
  final User user;
  final Activity activity;
  ChatScreenState({@required this.user,@required this.activity});
  String ms;
  activityHttp manager = activityHttp();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;
  _getpirce(){
    manager.joinPrice(this, user.getUsername(), int.parse(activity.getId()));
  }
  _endPrice(){
    manager.endPrice(this, int.parse(activity.getId()));
  }
  void _send(String text){
    if (_textController.text.isNotEmpty) {
      widget.channel.sink.add("{'type':'talk','user':"+user.getUsername()+',content:'+_textController.text+"'}");
    }
  }
  void _handleSubmitted(String text)  {
    print(text);
    if(ms !=text && (json.decode(text)['type']=='talk')){
      ms =text;
      _textController.clear();

      Future.delayed(Duration(milliseconds: 200)).then((e) {
        setState(() {
          _isComposing = false;
        });
      });
      ChatMessage message = new ChatMessage(
        text: text,
        animationController: new AnimationController(
          duration: new Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      Future.delayed(Duration(milliseconds: 200)).then((e) {
        setState(() {
          _messages.insert(0, message);
        });
      });
      message.animationController.forward();
    }
    if((json.decode(text)['type']=='end')){
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "活动已结束",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    widget.channel.sink.close();
    super.dispose();
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? new CupertinoButton(
                  child: new Text("Send"),
                  onPressed: _isComposing
                      ? () => _send(_textController.text)
                      : null,
                )
                    : new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _send(_textController.text)
                      : null,
                )),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
              border:
              new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("活动室"+activity.getName()),
          elevation:
          Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0
      ),
      body: Stack(
        children: <Widget>[
          new Container(
              child: new Column(
                  children: <Widget>[
                    new Flexible(
                        child: new ListView.builder(
                          padding: new EdgeInsets.all(8.0),
                          reverse: true,
                          itemBuilder: (_, int index) => _messages[index],
                          itemCount: _messages.length,
                        )
                    ),
                    new Divider(height: 1.0),
                    new Container(
                      decoration: new BoxDecoration(
                          color: Theme.of(context).cardColor),
                      child: _buildTextComposer(),
                    ),
                    new StreamBuilder(
                      stream: widget.channel.stream,
                      builder: (context, snapshot) {
                        _handleSubmitted(snapshot.hasData ? '${snapshot.data}' : '');
                        return new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                        );
                      },
                    )
                  ]
              ),
              decoration: Theme.of(context).platform == TargetPlatform.iOS ? new BoxDecoration(border: new Border(top: new BorderSide(color: Colors.grey[200]))) : null),
          Positioned(
            left: 300,
            top: 100,
              child: new FloatingActionButton(
              onPressed: (){
                showDialog<Null>(
                  context: context,
                  builder: (BuildContext context) {
                    return new SimpleDialog(
                      title: new Text('发起'),
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      children: <Widget>[
                        new SimpleDialogOption(
                          child: new Text('投票'),
                          onPressed: _launchURL,
                        ),
                        new SimpleDialogOption(
                        ),
                        new SimpleDialogOption(
                          child: new Text('参与抽奖'),
                          onPressed: () {
                            _getpirce();
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: "参与成功",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );
                          },
                        ),
                        new SimpleDialogOption(
                        ),
                        new SimpleDialogOption(
                          child: new Text('发起抽奖'),
                          onPressed: () {
                            Navigator.push<String>(context,
                              new MaterialPageRoute(builder: (context) {
                                return new pricePage(user: user,activity: activity,);
                              }));

                          },
                        ),
                        new SimpleDialogOption(
                        ),
                        new SimpleDialogOption(
                          child: new Text('开奖'),
                          onPressed: () async{
                            await _endPrice();
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: "开奖成功",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );
                            widget.channel.sink.add("{'type':'talk','user':"+user.getUsername()+',content:'+json.decode(res)['winers']+"'}");
                          },
                        ),
                      ],
                    );
                  },
                ).then((val) {
                  print(val);
                });
              },
              tooltip: 'add',
              child: new Icon(Icons.menu),
              backgroundColor: Colors.purpleAccent[400],
            ),
          ),
        ],
      ), //new
    );
  }
  _launchURL() async {
    const url = 'https://www.wjx.cn/jq/3795229.aspx?sojumpparm=wenjuanxing';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  void initState() {
    widget.channel.sink.add("{'type':'join','user':"+user.getUsername()+"}");
    print("初始化");
    super.initState();
  }
  @override
  onMyNoticeResponse(List<Activity> activities){
  }
  @override
  void onAddActivityResponse(String result) {
    res = result;
    setState(() {

    });
    // TODO: implement onAddActivityResponse
  }
  @override
  void onError(error) {}
}
