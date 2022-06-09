import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/group_message_response.dart';
import 'package:active_ecommerce_flutter/data_model/group_order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/conversation_response.dart';
import 'package:active_ecommerce_flutter/data_model/message_response.dart';
import 'package:active_ecommerce_flutter/data_model/conversation_create_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class ChatRepository {

  Future<ConversationResponse> getConversationResponse(
      {@required page = 1}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/seller/chat/conversations/${user_id.$}?page=${page}");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );
    return conversationResponseFromJson(response.body);
  }

  Future<GroupOrder> getGroupConversationResponse(
      {@required page = 1}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/group/orders/${user_id.$}");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );
    print("Group Order length:"+response.body.toString());
    return groupOrderResponse(response.body);
  }



  Future<MessageResponse> getMessageResponse(
      {@required conversation_id, @required page = 1}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/seller/chat/messages/${conversation_id}");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );
    print("Seller Message:");
    print(response.body);
    return messageResponseFromJson(response.body);
  }

 Future<GroupOrderMessage> getGroupMessageResponse(
      {@required conversation_id, @required page = 1}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/group/orders/chat/${conversation_id}");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );
    return groupMessageResponseFromJson(response.body);
  }


  Future<MessageResponse> getInsertMessageResponse(
      {@required conversation_id, @required String message}) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.$}",
      "conversation_id": "${conversation_id}",
      "message": "${message}"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/seller/chat/create_message");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);
    return messageResponseFromJson(response.body);
  }

  Future<GroupOrderMessage> getInsertGroupMessageResponse(
      {@required conversation_id, @required String message}) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.$}",
      "group_order_id": "${conversation_id}",
      "message": "${message}"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/group/chat/create_message");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);
    return groupMessageResponseFromJson(response.body);
  }


  Future<MessageResponse> getNewMessageResponse(
      {@required conversation_id, @required last_message_id}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/seller/chat/new_messages/${conversation_id}/${last_message_id}");
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );
    /* print("${AppConfig.BASE_URL}/chat/get-new-messages/${conversation_id}/${last_message_id}");
    print(response.body.toString());*/
    return messageResponseFromJson(response.body);
  }

  Future<ConversationCreateResponse> getCreateConversationResponse(
      {@required product_id,
      @required String message}) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.$}",
      "product_id": "${product_id}",
      "message": "${message}"
    });

   // Uri url = Uri.parse("${AppConfig.BASE_URL}/chat/create-conversation");
    Uri url = Uri.parse("${AppConfig.BASE_URL}/seller/chat/create_conversations");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);
    return conversationCreateResponseFromJson(response.body);
  }

  /*Future<ConversationCreateResponse> getCreateConversationResponse(
      {@required product_id,
      @required String title,
      @required String message}) async {
    var post_body = jsonEncode({
      "user_id": "${user_id.$}",
      "product_id": "${product_id}",
      "title": "${title}",
      "message": "${message}"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/chat/create-conversation");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);
    return conversationCreateResponseFromJson(response.body);
  }*/

}
