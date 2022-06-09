// To parse this JSON data, do
//
//     final profileCountersResponse = profileCountersResponseFromJson(jsonString);

import 'dart:convert';

ProfileCountersResponse profileCountersResponseFromJson(String str) => ProfileCountersResponse.fromJson(json.decode(str));

String profileCountersResponseToJson(ProfileCountersResponse data) => json.encode(data.toJson());

class ProfileCountersResponse {
  int cartItemCount;
  int wishlistItemCount;
  int orderCount;
  int orderComplete;
  int orderOnDelivery;
  int orderConfirmed;
  int orderPending;
  int orderCancelled;
  int groupOrderCount;

  ProfileCountersResponse(
      {this.cartItemCount,
        this.wishlistItemCount,
        this.orderCount,
        this.orderComplete,
        this.orderOnDelivery,
        this.orderConfirmed,
        this.orderPending,
        this.orderCancelled,
        this.groupOrderCount});

  ProfileCountersResponse.fromJson(Map<String, dynamic> json) {
    cartItemCount = json['cart_item_count'];
    wishlistItemCount = json['wishlist_item_count'];
    orderCount = json['order_count'];
    orderComplete = json['order_complete'];
    orderOnDelivery = json['order_on_delivery'];
    orderConfirmed = json['order_confirmed'];
    orderPending = json['order_pending'];
    orderCancelled = json['order_cancelled'];
    groupOrderCount = json['group_order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_item_count'] = this.cartItemCount;
    data['wishlist_item_count'] = this.wishlistItemCount;
    data['order_count'] = this.orderCount;
    data['order_complete'] = this.orderComplete;
    data['order_on_delivery'] = this.orderOnDelivery;
    data['order_confirmed'] = this.orderConfirmed;
    data['order_pending'] = this.orderPending;
    data['order_cancelled'] = this.orderCancelled;
    data['group_order_count'] = this.groupOrderCount;
    return data;
  }
}
