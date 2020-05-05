import 'package:flutter/material.dart';
import 'User.dart';
import 'list.dart' as newsList;
import 'AddActivity.dart';
const TITLE  = '标题标题标题标题标题标题标题';
const SUB_TITLE = '二级标题二级标题二级标题二级标题二级标题二级标题二级标题二级标题二';
const IMAGE_SRC =
    'http://cms-bucket.ws.126.net/2019/06/20/68fa7f186ffe4479ab27efabd4d94246.png';
class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({Key key,@required this.user}):super(key:key);
  @override
  State<StatefulWidget> createState() => HomeScreenState(user: this.user);
}

class HomeScreenState extends State<HomeScreen> {
  final User user;
  HomeScreenState({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOME'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push<String>(context,
                  new MaterialPageRoute(builder: (context) {
                    return new AddActivity();
                  }));
            },
          ),
        ],
      ),
      body: HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  Widget buildItem(BuildContext context, int index) {
    Map news = newsList.news[index];
    return CardItem2(
      title: news['title'],
      subTitle: news['docurl'],
      cover: news['imgurl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.news.length,
      itemBuilder: buildItem,
    );
    // return ListView(
    //   children: <Widget>[
    //     CardItem(),
    //     CardItem2(),
    //     CardItem2(),
    //   ],
    //   padding: EdgeInsets.only(top: 20),
    // );
  }
}

class CardItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(TITLE),
            subtitle: Text(SUB_TITLE),
          ),
          ListTile(
            title: Text('地址：上海市'),
          ),
          ListTile(
            title: Text('电话：12345678901'),
          )
        ],
      ),
    );
  }
}

class CardItem2 extends StatelessWidget {
  CardItem2({
    this.title,
    this.subTitle,
    this.cover,
  });
  final String title;
  final String subTitle;
  final String cover;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          AspectRatio(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(this.cover),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ),
            aspectRatio: 16 / 9,
          ),
          ListTile(
            title:
            Text(this.title, maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text(this.subTitle,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            leading: ClipOval(
              child: CircleAvatar(backgroundImage: NetworkImage(this.cover)),
            ),
          )
        ],
      ),
      margin: EdgeInsets.all(10),
    );
  }
}
