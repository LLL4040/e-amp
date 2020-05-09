
import 'dart:convert';
import 'package:http/http.dart' as http;

class userHttp {

  var myMessageHttp = "http://202.120.40.8:30401/api/message?name=";


  recommandActivity(UserListener net,String name) {
    var client = new http.Client();
    client.get(
      myMessageHttp+name,
    ).then((response,) {
      net.onMessageResponse(response.body);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
}
abstract class UserListener {

  void onMessageResponse(String result);
  void onError(error);
}
class User{
  final String username;
  final String password;
  User(this.username,this.password);
  String getUsername(){
    return this.username;
  }
  String getPassword(){
    return this.password;
  }
}
