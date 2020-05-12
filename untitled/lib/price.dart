
import 'dart:convert';
import 'package:http/http.dart' as http;

class priceHttp {

  var startHttp = "http://202.120.40.8:30401/api/startPrize";


  startPrice(PriceListener net,String name,String id,String prize,int num) {
    var client = new http.Client();
    client.post(
      startHttp,
      headers:{
        "Content-Type": "application/json",
      },
      body: json.encode({
        "name": name,
        "id":id,
        "prize": prize,
        "num": num,
      }),
    ).then((response,) {
      net.onMessageResponse(response.body);
    }, onError: (error) {
      net.onError(error);
    }).whenComplete(
      client.close,
    );
  }
}
abstract class PriceListener {

  void onMessageResponse(String result);
  void onError(error);
}

