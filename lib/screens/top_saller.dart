import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/repositories/shop_repository.dart';
import 'package:active_ecommerce_flutter/screens/seller_details.dart';
import 'package:active_ecommerce_flutter/ui_elements/AppBar_Common.dart';
import 'package:active_ecommerce_flutter/ui_elements/shop_square_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_theme.dart';

class TopSeller extends StatefulWidget {
  const TopSeller({Key key}) : super(key: key);

  @override
  _TopSellerState createState() => _TopSellerState();
}

class _TopSellerState extends State<TopSeller> {

  String _searchKey = "";

  ScrollController _shopScrollController = ScrollController();


  List<dynamic> _shopList = [];
  bool _isShopInitial = true;
  int _shopPage = 1;
  int _totalShopData = 0;
  bool _showShopLoadingContainer = false;

  ScrollController _scrollController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchShopData();

    _shopScrollController.addListener(() {
      if (_shopScrollController.position.pixels ==
          _shopScrollController.position.maxScrollExtent) {
        setState(() {
          _shopPage++;
        });
        _showShopLoadingContainer = true;
        fetchShopData();
      }
    });
  }




  fetchShopData() async {
    var shopResponse =
    await ShopRepository().getShops(page: _shopPage, name: _searchKey);
    _shopList.addAll(shopResponse.shops);
    _isShopInitial = false;
    _totalShopData = shopResponse.meta.total;
    _showShopLoadingContainer = false;
    //print("_shopPage:" + _shopPage.toString());
    //print("_totalShopData:" + _totalShopData.toString());
    setState(() {});
  }

  resetShopList() {
    _shopList.clear();
    _isShopInitial = true;
    _totalShopData = 0;
    _shopPage = 1;
    _showShopLoadingContainer = false;
    setState(() {});
  }

  Future<void> _onShopListRefresh() async {
    resetShopList();
    fetchShopData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithBackAndTitle(context, "Top Seller"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: buildShopList(),

      )
    );
  }

  Container buildShopList() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: buildShopScrollableList(),
          )
        ],
      ),
    );
  }

  buildShopScrollableList() {
    if (_isShopInitial && _shopList.length == 0) {
      return SingleChildScrollView(
          controller: _scrollController,
          child: ShimmerHelper()
              .buildSquareGridShimmer(scontroller: _scrollController));
    } else if (_shopList.length > 0) {
      return RefreshIndicator(
        color: Colors.white,
        backgroundColor: MyTheme.primaryColor,
        onRefresh: _onShopListRefresh,
        child: SingleChildScrollView(
          controller: _shopScrollController,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              SizedBox(
                  height: 20
                //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
              ),
              GridView.builder(
                // 2
                //addAutomaticKeepAlives: true,
                itemCount: _shopList.length,
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1),
                padding: EdgeInsets.all(8),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // 3
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return SellerDetails();
                          }));
                    },
                    child: ShopSquareCard(
                      id: _shopList[index].id,
                      image: _shopList[index].logo,
                      name: _shopList[index].name,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      );
    } else if (_totalShopData == 0) {
      return Center(child: Text(AppLocalizations.of(context).common_no_shop_is_available));
    } else {
      return Container(); // should never be happening
    }
  }

}
