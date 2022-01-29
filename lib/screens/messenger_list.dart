import 'package:active_ecommerce_flutter/data_model/group_order.dart';
import 'package:active_ecommerce_flutter/ui_elements/AppBar_Common.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/chat.dart';
import 'package:active_ecommerce_flutter/repositories/chat_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'filter.dart';

class MessengerList extends StatefulWidget {
  @override
  _MessengerListState createState() => _MessengerListState();
}

class _MessengerListState extends State<MessengerList> {
  ScrollController _scrollController = ScrollController();

  List<dynamic> _list = [];
  bool _isInitial = true;
  int _page = 1;
  int _totalData = 0;
  bool _showLoadingContainer = false;

 List<dynamic> _groupList = [];
  bool _isGroupInitial = true;
  int _groupPage = 1;
  int _groupTotalData = 0;
  bool _groupShowLoadingContainer = false;

  bool groupColor=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();

    _scrollController.addListener(() {
      //print("position: " + _xcrollController.position.pixels.toString());
      //print("max: " + _xcrollController.position.maxScrollExtent.toString());

      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
          _groupPage++;
        });
        _showLoadingContainer = true;

      }
    });

  }

  fetchData() async {
    getSellerList();
    getGroupList();
  }

  getSellerList() async{
    var conversatonResponse =
    await ChatRepository().getConversationResponse(page: _page);
    _list.addAll(conversatonResponse.conversation_item_list);
    _isInitial = false;
    _totalData = conversatonResponse.meta.total;
    _showLoadingContainer = false;
    setState(() {});
  }

   getGroupList() async{
    var conversatonResponse =
    await ChatRepository().getGroupConversationResponse(page: _page);
    _groupList.addAll(conversatonResponse.data);
    _isGroupInitial = false;
    _groupTotalData = conversatonResponse.meta.total;
    _groupShowLoadingContainer = false;
    print("Group Order length:"+_groupList.length.toString());
    setState(() {});
  }


  reset() {
    _list.clear();
    _isInitial = true;
    _totalData = 0;
    _page = 1;
    _showLoadingContainer = false;
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchData();
  }
  //01928376409
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            RefreshIndicator(
              color: MyTheme.primaryColor,
              backgroundColor: Colors.white,
              onRefresh: _onRefresh,
              displacement: 0,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        16.0,
                        0.0,
                        0.0,
                      ),
                      child: SizedBox(
                        height: 40,
                        width: 150,
                        child: buildChatSearch(context),
                      ),
                    ),
                  ),

                   SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        16.0,
                        0.0,
                        0.0,
                      ),
                      child: SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: buildchatTyepe(context),
                      ),
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: buildMessengerList(),
                      ),
                    ]),
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: buildLoadingContainer())
          ],
        ),
      ),
    );
  }

  Container buildLoadingContainer() {
    return Container(
      height: _showLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalData == _list.length
            ? AppLocalizations.of(context).common_no_more_items
            : AppLocalizations.of(context).common_loading_more_items),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Image.asset(
            Images.hamburger,
            color: MyTheme.primary_Colour,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Image.asset(
        Images.logo,
        height: 40,
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildMessengerList() {
    return SingleChildScrollView(
      child: ListView.builder(
        itemCount: _groupList.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(0.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
            child: groupColor? buildGroupMessengerItemCard(index) : buildMessengerItemCard(index),
          );
        },
      ),
    );
    /*  if (_isInitial && _list.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 10, item_height: 100.0));
    } else if (_list.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: 6,//_list.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(0.0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
              child: buildMessengerItemCard(index),
            );
          },
        ),
      );
    } else if (_totalData == 0) {
      return Center(child: Text("No data is available"));
    } else {
      return Container(); // should never be happening
    }*/
  }

  buildMessengerItemCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Chat(
            conversation_id: 1, //_list[index].id,
            messenger_name: "Parthona Store", //_list[index].shop_name,
            messenger_title: "Cloth", //_list[index].title,
            messenger_image: Images.complete, //_list[index].shop_logo,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: MyTheme.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: MyTheme.dark_grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2)
              ]),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: MyTheme.primary_Colour.withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      //shape: BoxShape.rectangle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8) , topLeft: Radius.circular(8)),
                      child: Image.asset(
                        Images.p4, //AppConfig.BASE_PATH + _list[index].shop_logo,
                        fit: BoxFit.contain,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    )
                    /*ClipRRect(
                //  borderRadius: BorderRadius.circular(35),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: Images.complete,//AppConfig.BASE_PATH + _list[index].shop_logo,
                    fit: BoxFit.contain,
                    height: double.infinity,
                    width: double.infinity,
                  )),*/
                    ),
                Container(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All rounder shop", // _list[index].shop_name,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.font_grey,
                                  fontSize: 13,
                                  height: 1.6,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Cloth", //_list[index].title,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.medium_grey,
                                  height: 1.6,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "\$250",
                      style: LatoBold,
                    )

                    /*Icon(
                Icons.arrow_forward_ios_rounded,
                color: MyTheme.medium_grey,
                size: 14,
              ),*/
                    )
              ]),
        ),
      ),
    );
  }
  buildGroupMessengerItemCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Chat(
            conversation_id: 1, //_list[index].id,
            messenger_name: "Parthona Store", //_list[index].shop_name,
            messenger_title: "Cloth", //_list[index].title,
            messenger_image: Images.complete, //_list[index].shop_logo,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: MyTheme.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    color: MyTheme.dark_grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2)
              ]),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: MyTheme.primary_Colour.withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      //shape: BoxShape.rectangle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8) , topLeft: Radius.circular(8)),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image:AppConfig.BASE_PATH + _groupList[index].productInfo.thumbnailImage,
                        fit: BoxFit.contain,
                        height: double.infinity,
                        width: double.infinity,
                      )
                    )
                    /*ClipRRect(
                //  borderRadius: BorderRadius.circular(35),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: Images.complete,//AppConfig.BASE_PATH + __groupList[index].productInfo.thumbnail_image,
                    fit: BoxFit.contain,
                    height: double.infinity,
                    width: double.infinity,
                  )),*/
                    ),
                Container(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _groupList[index].productInfo.name, // _list[index].shop_name,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.font_grey,
                                  fontSize: 13,
                                  height: 1.6,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${_groupList[index].totalMemberJoin} Member joined", //_list[index].title,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyTheme.medium_grey,
                                  height: 1.6,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_groupList[index].productUnitPrice}", // _list[index].shop_name,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: MyTheme.font_grey,
                            fontSize: 13,
                            height: 1.6,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "00:50:56", //_list[index].title,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: MyTheme.medium_grey,
                            height: 1.6,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  buildChatSearch(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            size: 35,
            color: MyTheme.primary_Colour,
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: MyTheme.white,
                boxShadow:[ BoxShadow(
                  color: MyTheme.dark_grey.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 2
                )]
              ),
              padding: EdgeInsets.only(left: 10, right: 0),
              child: TextField(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Filter();
                  }));
                },
                autofocus: false,
                decoration: InputDecoration(
                    hintText: "Search..",
                    hintStyle: LatoRegular.copyWith(color: MyTheme.dark_grey),
                    fillColor: MyTheme.white,
                    border: InputBorder.none,
                    /*  enabledBorder: OutlineInputBorder(
                // borderSide: BorderSide(color: MyTheme.primary_Colour, width: 0.5),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(16.0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyTheme.primary_Colour, width: 1.0),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(16.0),
                ),
              ),*/
                    suffixIcon: Stack(
                      children: [
                        Positioned(
                            // padding: const EdgeInsets.all(5.0),
                            right: -1,
                            top: 4,
                            bottom: 4,
                            child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyTheme.primary_Colour,
                                  ),
                                  child: Icon(
                                    Icons.search,
                                    color: MyTheme.white,
                                    size: 20,
                                  ),
                                ))),
                      ],
                    ),
                    contentPadding: EdgeInsets.all(0.0)),
              ),
            ),
          ),
          SizedBox(width: 30,),
        ],
      ),
    );
  }

  buildchatTyepe(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          InkWell(
            onTap: (){
              setState(() {
                groupColor=true;
              });

            },
            child: Container(
              width: 100,
              height: 100,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: groupColor? MyTheme.primary_Colour: MyTheme.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: MyTheme.dark_grey.withOpacity(0.2)
                        )
                      ]
                    ),
                    child: Padding( padding: EdgeInsets.all(10),
                        child: Image.asset(Images.group, color: groupColor? MyTheme.white : MyTheme.primary_Colour ,)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10),
                  child: Text("Member Chat", style: LatoHeavy,),
                  )
                ],
              ),
            ),
          ),
           InkWell(
             onTap: (){
               setState(() {
                 groupColor=false;
               });
             },
             child: Container(
              width: 100,
              height: 100,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: groupColor? MyTheme.white:  MyTheme.primary_Colour,
                        shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: MyTheme.dark_grey.withOpacity(0.2)
                        )
                      ]
                    ),
                    child: Padding( padding: EdgeInsets.all(10),
                        child: Image.asset(Images.profile_Home, color: groupColor? MyTheme.primary_Colour:   MyTheme.white,)),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10),
                    child: Text("Seller", style: LatoHeavy,),
                  )
                ],
              ),
          ),
           )

        ],
      ),
    );
  }
}
