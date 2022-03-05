import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/group_buying/group_order_details_response.dart';
import 'package:active_ecommerce_flutter/data_model/group_order.dart';
import 'package:active_ecommerce_flutter/screens/group_order_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:active_ecommerce_flutter/data_model/order_mini_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_detail_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_item_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class OrderRepository {
  Future<OrderMiniResponse> getOrderList(
      {page = 1, payment_status = "", delivery_status = ""}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/purchase-history/" +
        "${user_id.$}" +
        "?page=${page}&payment_status=${payment_status}&delivery_status=${delivery_status}");

    final response = await http.get(url,headers: {
          "App-Language": app_language.$,
        });
    //print("url:" +url.toString());
    return orderMiniResponseFromJson(response.body);
  }

  Future<GroupOrder> getGroupOrderList(
      {page = 1, }) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/group/orders/${user_id.$}");

    final response = await http.get(url,headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${access_token.$}",
      "App-Language": app_language.$,

    });

    //print("url:" +url.toString());
    print("User Id: ${user_id.$}");
    print("Order Status code"+ response.statusCode.toString());
    print("Order"+ response.body.toString());
    return groupOrderMiniResponseFromJson(response.body);

  }


Future<GroupOrderDetailsResponse> getGroupOrderDetails(
      int id) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/group/orders/details/${id}");

    final response = await http.get(url,headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${access_token.$}",
      "App-Language": app_language.$,

    });

    //print("url:" +url.toString());
    print("User Id: ${user_id.$}");
    print("Order Status code"+ response.statusCode.toString());
    print("Order"+ response.body.toString());
    return groupOrderDetailsResponseFromJson(response.body);
  }


  Future<OrderDetailResponse> getOrderDetails({@required int id = 0}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/purchase-history-details/" + id.toString());

    final response = await http.get(url,headers: {
          "App-Language": app_language.$,
        });
    //print("url:" +url.toString());
    //print(response.body);
    return orderDetailResponseFromJson(response.body);
  }

  Future<OrderItemResponse> getOrderItems({@required int id = 0}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/purchase-history-items/" + id.toString());
    final response = await http.get(url,headers: {
          "App-Language": app_language.$,
        });
    //print("url:" +url.toString());
    return orderItemlResponseFromJson(response.body);
  }
}
