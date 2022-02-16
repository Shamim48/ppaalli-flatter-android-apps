import 'package:active_ecommerce_flutter/data_model/group_buying/group_buying_details.dart';
import 'package:active_ecommerce_flutter/data_model/group_buying/group_buying_product.dart';
import 'package:active_ecommerce_flutter/data_model/group_buying/group_product_details.dart';
import 'package:active_ecommerce_flutter/data_model/group_buying/ongoing_product.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/cupertino.dart';
import '../app_config.dart';
import 'package:http/http.dart' as http;

class GroupBuyingRepo{

  Future<GroupBuyingProduct> getGroupProduct({page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/group/products");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    print("Group Buying Product:" + response.body.toString());
    return groupProductResponseFromJson(response.body);
  }

  Future<GroupProductDetails> getGroupProductDetails({id}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/group/product_details/${id}");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    print("Group Product Details:" + response.body.toString());
    return groupProductDetailsResponseFromJson(response.body);
  }



   Future<OnGoingGroupProduct> getOnGoingProduct({page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/group/ongoing");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    print("On Going Product:" + response.body.toString());
    return onGoingProductResponseFromJson(response.body);
  }

  Future<GroupBuyingProductDetails> getProductDetails(
      {@required int id = 0}) async {
    // Uri url = Uri.parse("${AppConfig.BASE_URL}/products/${37}");
    Uri url = Uri.parse("${AppConfig.BASE_URL}/group/orders/details/${id}");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    return groupBuyingProductDetailsResponseFromJson(response.body);
  }

  Future<CheckGroupBuying> checkGroupProduct(id) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/group/product_check/${id}");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });
    print("Group Buying Check:" + response.body.toString());
    return checkGroupBuyingResponseFromJson(response.body);
  }






}