import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/dummy_data/brands.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/repositories/sliders_repository.dart';
import 'package:active_ecommerce_flutter/screens/brand_products.dart';
import 'package:active_ecommerce_flutter/screens/category_list.dart';
import 'package:active_ecommerce_flutter/screens/category_products.dart';
import 'package:active_ecommerce_flutter/screens/chat.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:active_ecommerce_flutter/screens/flash_deal_list.dart';
import 'package:active_ecommerce_flutter/screens/messenger_list.dart';
import 'package:active_ecommerce_flutter/screens/product_card.dart';
import 'package:active_ecommerce_flutter/screens/product_details.dart';
import 'package:active_ecommerce_flutter/screens/todays_deal_products.dart';
import 'package:active_ecommerce_flutter/screens/top_selling_products.dart';
import 'package:active_ecommerce_flutter/ui_sections/drawer.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:one_context/one_context.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title, this.show_back_button = false, go_back = true})
      : super(key: key);


  final String title;
  bool show_back_button;
  bool go_back;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _current_slider = 0;
  ScrollController _featuredProductScrollController;
  ScrollController _mainScrollController = ScrollController();

  AnimationController pirated_logo_controller;
  Animation pirated_logo_animation;

  var _carouselImageList = [];
  var _featuredCategoryList = [];
  var _featuredProductList = [];
  var _bestSellingProductList = [];
  bool _isProductInitial = true;
  bool _isBestSellingProductInitial = true;
  bool _isCategoryInitial = true;
  bool _isCarouselInitial = true;
  int _totalProductData = 0;
  int _totalBestSellingProductData = 0;
  int _productPage = 1;
  bool _showProductLoadingContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()
    if (AppConfig.purchase_code == "") {
      initPiratedAnimation();
    }

    print("UserId: ${user_id.$}");
    fetchAll();

    _mainScrollController.addListener(() {
      //print("position: " + _xcrollController.position.pixels.toString());
      //print("max: " + _xcrollController.position.maxScrollExtent.toString());

      if (_mainScrollController.position.pixels ==
          _mainScrollController.position.maxScrollExtent) {
        setState(() {
          _productPage++;
        });
        _showProductLoadingContainer = true;
        fetchFeaturedProducts();
        fetchBestSellingProducts();
      }
    });
  }

  fetchAll() {
    fetchCarouselImages();
    fetchFeaturedCategories();
    fetchFeaturedProducts();
    fetchBestSellingProducts();
  }

  fetchCarouselImages() async {
    var carouselResponse = await SlidersRepository().getSliders();
    carouselResponse.sliders.forEach((slider) {
      _carouselImageList.add(slider.photo);
    });
    _isCarouselInitial = false;
    setState(() {});
  }

  fetchFeaturedCategories() async {
    var categoryResponse = await CategoryRepository().getFeturedCategories();
    _featuredCategoryList.addAll(categoryResponse.categories);
    _isCategoryInitial = false;
    setState(() {});
  }

  fetchFeaturedProducts() async {
    var productResponse = await ProductRepository().getFeaturedProducts(
      page: _productPage,
    );

    //_featuredProductList=productList_;
    _featuredProductList.addAll(productResponse.data);
    _isProductInitial = false;
    _totalProductData = _featuredProductList.length;
    _showProductLoadingContainer = false;
    setState(() {});
  }

  fetchBestSellingProducts() async {
    var productResponse = await ProductRepository().getBestSellingProducts();

    //_featuredProductList=productList_;
    _bestSellingProductList.addAll(productResponse.data);
    _isBestSellingProductInitial = false;
    _totalBestSellingProductData = _bestSellingProductList.length;
    _showProductLoadingContainer = false;
    setState(() {});
  }

  reset() {
    _carouselImageList.clear();
    _featuredCategoryList.clear();
    _isCarouselInitial = true;
    _isCategoryInitial = true;

    setState(() {});

    resetProductList();
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }

  resetProductList() {
    _featuredProductList.clear();
    _isProductInitial = true;
    _isBestSellingProductInitial = true;
    _totalProductData = 0;
    _productPage = 1;
    _showProductLoadingContainer = false;
    setState(() {});
  }

  initPiratedAnimation() {
    pirated_logo_controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    pirated_logo_animation = Tween(begin: 40.0, end: 60.0).animate(
        CurvedAnimation(
            curve: Curves.bounceOut, parent: pirated_logo_controller));

    pirated_logo_controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        pirated_logo_controller.repeat();
      }
    });

    pirated_logo_controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pirated_logo_controller?.dispose();
    _mainScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    //print(MediaQuery.of(context).viewPadding.top);

    return WillPopScope(
      onWillPop: () async {
        return widget.go_back;
        // Feature Product
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            appBar: buildAppBar(statusBarHeight, context),
            drawer: MainDrawer(),
            body: Stack(
              children: [
                RefreshIndicator(
                  color: MyTheme.primaryColor,
                  backgroundColor: Colors.white,
                  onRefresh: _onRefresh,
                  displacement: 0,
                  child: CustomScrollView(
                    controller: _mainScrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          AppConfig.purchase_code == ""
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    8.0,
                                    16.0,
                                    8.0,
                                    0.0,
                                  ),
                                  child: Container(
                                    height: 140,
                                    color: Colors.black,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            left: 20,
                                            top: 0,
                                            child: AnimatedBuilder(
                                                animation:
                                                    pirated_logo_animation,
                                                builder: (context, child) {
                                                  return Image.asset(
                                                    "assets/pirated_square.png",
                                                    height:
                                                        pirated_logo_animation
                                                            .value,
                                                    color: Colors.white,
                                                  );
                                                })),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 24.0, left: 24, right: 24),
                                            child: Text(
                                              "This is a pirated app. Do not use this. It may have security issues.",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              30.0,
                              0.0,
                              30.0,
                              0.0,
                            ),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)
                              ),

                             /* kToolbarHeight +
                                  statusBarHeight -
                                  (MediaQuery.of(context).viewPadding.top > 40 ? 16.0 : 16.0),*/
                              //MediaQuery.of(context).viewPadding.top is the statusbar height, with a notch phone it results almost 50, without a notch it shows 24.0.For safety we have checked if its greater than thirty
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                child: Padding(
                                    padding: app_language_rtl.$
                                        ? const EdgeInsets.only(top: 14.0, bottom: 14, left: 12)
                                        : const EdgeInsets.only(top: 14.0, bottom: 14, right: 12),
                                    // when notification bell will be shown , the right padding will cease to exist.
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) {
                                                return Filter();
                                              }));
                                        },
                                        child: buildHomeSearchBox(context))),
                              ),
                            ),
                          ),

                           Padding(
                            padding: const EdgeInsets.fromLTRB(
                              8.0,
                              16.0,
                              8.0,
                              0.0,
                            ),
                            child: buildHomeCarouselSlider(context),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              8.0,
                              16.0,
                              8.0,
                              0.0,
                            ),
                            child: buildHomeMenuRow(context),
                          ),
                        ]),
                      ),
                      // Group Buying
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Group Buying",
                                  style: LatoHeavy.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ]),
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
                            width: 150,
                            child: buildGroupBuyingProduct(context),
                          ),
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)
                                      .home_screen_featured_products,
                                  style: LatoHeavy.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ]),
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
                              width: 150,
                              child: buildHomeFeaturedProduct(context)
                              //buildHomeFeaturedProduct(context),
                              ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Best Selling",
                                  style: LatoHeavy.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ]),
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
                            width: 150,
                            child: buildHomeBestSellingProduct(context),
                          ),
                        ),
                      ),

                      SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              0.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Student Offer",
                                  style: LatoHeavy.copyWith(fontSize: 20) ,
                                ),
                              ],
                            ),
                          ),
                        ]),
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
                            width: 150,
                            child: buildHomeFeaturedProduct(context),
                          ),
                        ),
                      ),

                      SliverList(
                          delegate: SliverChildListDelegate([
                        Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              16.0,
                              16.0,
                              0.0,
                            ),
                            child: SizedBox(
                              height: 80,
                            )),
                      ]))

                      /*SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    4.0,
                                    16.0,
                                    8.0,
                                    0.0,
                                  ),
                                  child: buildHomeFeaturedProducts_List(context),
                                ),
                              ],
                            ),
                          ),*/
                      /*
                          Container(
                            height: 80,
                          )
                        ]),
                      ),*/

                    /*
                      ListView.builder(
                        // 2
                        // addAutomaticKeepAlives: true,
                          itemCount: productList_.length,
                          controller: _featuredProductScrollController,
                          scrollDirection: Axis.horizontal,

                          */
                    /* gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.618),*/
                      /*

                          padding: EdgeInsets.all(8),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return ProductDetails(id: 1,);
                                  }));
                                },
                                child: Card(
                                  //clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  elevation: 0.0,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        Container(
                                            width: double.infinity,
                                            //height: 158,
                                            height: (( MediaQuery.of(context).size.width - 28 ) / 2) + 2,
                                            child: ClipRRect(
                                              clipBehavior: Clip.hardEdge,
                                              borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(16), bottom: Radius.zero),
                                              */
                      /*  child: FadeInImage.assetNetwork( //assetNetwork
                        placeholder: 'assets/placeholder.png',
                        image: AppConfig.BASE_PATH + widget.image,
                        fit: BoxFit.cover,
                      )*/ /*

                                              // child: Image.asset(AppConfig.BASE_PATH + widget.image),
                                              child: Image.asset("assets/app_logo.png"),
                                            )),
                                        Container(
                                          height: 90,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                                                child: Text("Product Name",
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      color: MyTheme.font_grey,
                                                      fontSize: 14,
                                                      height: 1.2,
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
                                                child: Text("500",
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: MyTheme.accent_color,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              true ? Padding(
                                                padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                                                child: Text(
                                                  "450",
                                                  textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      decoration:TextDecoration.lineThrough,
                                                      color: MyTheme.medium_grey,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ):Container(),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              )

                        */
                    /*ProductCard(
              id: _featuredProductList[index].id,
              image: _featuredProductList[index].thumbnail_image,
              name: _featuredProductList[index].name,
              main_price: _featuredProductList[index].main_price,
              stroked_price: _featuredProductList[index].stroked_price,
              has_discount: _featuredProductList[index].has_discount);*/
                      /*
                      )
                    */
                    ],
                  ),
                ),
                /*   Align(
                    alignment: Alignment.center,
                    child: buildProductLoadingContainer())*/
              ],
            )),
      ),
    );
  }

  buildHomeFeaturedProducts_List(context) {
    if (_isProductInitial && _featuredProductList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildProductGridShimmer(
              scontroller: _featuredProductScrollController));
    } else if (_featuredProductList.length > 0) {
      //snapshot.hasData
      return ListView.builder(
          // 2
          // addAutomaticKeepAlives: true,
          itemCount: _featuredProductList.length,
          controller: _featuredProductScrollController,
          scrollDirection: Axis.horizontal,
/*         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.618),*/
          padding: EdgeInsets.all(8),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProductDetails(
                      id: _featuredProductList[index].id,
                    );
                  }));
                },
                child: Card(
                  //clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 0.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: double.infinity,
                            //height: 158,
                            height:
                                ((MediaQuery.of(context).size.width - 28) / 2) +
                                    2,
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                  bottom: Radius.zero),
                              /*  child: FadeInImage.assetNetwork( //assetNetwork
                        placeholder: 'assets/placeholder.png',
                        image: AppConfig.BASE_PATH + widget.image,
                        fit: BoxFit.cover,
                      )*/
                              // child: Image.asset(AppConfig.BASE_PATH + widget.image),
                              child: Image.asset("assets/app_logo.png"),
                            )),
                        Container(
                          height: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                                child: Text(
                                  "Product Name",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: MyTheme.font_grey,
                                      fontSize: 14,
                                      height: 1.2,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
                                child: Text(
                                  "500",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: MyTheme.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              true
                                  ? Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(16, 0, 16, 8),
                                      child: Text(
                                        "450",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: MyTheme.medium_grey,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ]),
                ),
              )

          /*ProductCard(
              id: _featuredProductList[index].id,
              image: _featuredProductList[index].thumbnail_image,
              name: _featuredProductList[index].name,
              main_price: _featuredProductList[index].main_price,
              stroked_price: _featuredProductList[index].stroked_price,
              has_discount: _featuredProductList[index].has_discount);*/

          );
    } else if (_totalProductData == 0) {
      return Center(
          child: Text(
              AppLocalizations.of(context).common_no_product_is_available));
    } else {
      return Container(); // should never be happening
    }
  }

  buildHomeFeaturedProducts(context) {
    if (_isProductInitial && _featuredProductList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper().buildProductGridShimmer(
              scontroller: _featuredProductScrollController));
    } else if (_featuredProductList.length > 0) {
      //snapshot.hasData
      return GridView.builder(
        // 2
        // addAutomaticKeepAlives: true,
        itemCount: _featuredProductList.length,
        controller: _featuredProductScrollController,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            childAspectRatio: 0.618),
        padding: EdgeInsets.all(8),
        //  physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // 3
          return ProductCard(
              id: _featuredProductList[index].id,
              image: _featuredProductList[index].thumbnailImage,
              name: _featuredProductList[index].name,
              main_price: _featuredProductList[index].mainPrice,
            rating: _featuredProductList[index].rating,
              );
        },
      );
    } else if (_totalProductData == 0) {
      return Center(
          child: Text(
              AppLocalizations.of(context).common_no_product_is_available));
    } else {
      return Container(); // should never be happening
    }
  }

  buildHomeFeaturedProduct(context) {
    if (_isProductInitial && _featuredProductList.length == 0) {
      return Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
        ],
      );
    } else if (_featuredProductList.length > 0) {
      //snapshot.hasData
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _featuredProductList.length,
          itemExtent: 130,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProductDetails(
                        id: _featuredProductList[index].id,
                      );
                    }));
                  },
                  child: Container(
                      // clipBehavior: Clip.antiAlias,
                      height: 100,
                      width: 130,
                      decoration: BoxDecoration(
                        // color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: MyTheme.primary_Colour.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 130,
                                height: 60,
                                color: MyTheme.white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/placeholder.png',
                                    image: AppConfig.BASE_PATH +
                                        _featuredProductList[index]
                                            .thumbnailImage,
                                    fit: BoxFit.scaleDown,
                                    height: 60,
                                    width: 130,
                                  ),
                                )),

                            /*ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                    bottom: Radius.zero),
                                )),*/
                            Flexible(
                                child: Container(
                                    width: 130,
                                    height: 40,
                                    color: MyTheme.primary_Colour,
                                    child: Column(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          _featuredProductList[index].name,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: MyTheme.white),
                                        )),
                                        Row(
                                          children: [
                                            /*  RatingBar(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),*/

                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: RatingBarIndicator(
                                                  rating: 2.75,
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 12.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 2, 5, 5),
                                              child: Text(
                                                _featuredProductList[index]
                                                    .basePrice,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: MyTheme.white),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )))
                          ],
                        ),
                      ))),
            );
          });
    } else if (!_isProductInitial && _featuredProductList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).home_screen_no_category_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  buildHomeBestSellingProduct(context) {
    if (_isBestSellingProductInitial && _bestSellingProductList.length == 0) {
      return Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
        ],
      );
    } else if (_bestSellingProductList.length > 0) {
      //snapshot.hasData
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _bestSellingProductList.length,
          itemExtent: 130,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProductDetails(
                        id: _bestSellingProductList[index].id,
                      );
                    }));
                  },
                  child: Container(
                      // clipBehavior: Clip.antiAlias,
                      height: 100,
                      width: 130,
                      decoration: BoxDecoration(
                        // color: MyTheme.primary_Colour,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: MyTheme.primary_Colour.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 130,
                                height: 60,
                                color: MyTheme.white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/placeholder.png',
                                    image: AppConfig.BASE_PATH +
                                        _bestSellingProductList[index]
                                            .thumbnailImage,
                                    fit: BoxFit.scaleDown,
                                    height: 60,
                                    width: 130,
                                  ),
                                )),

                            /*ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                    bottom: Radius.zero),
                                )),*/
                            Flexible(
                                child: Container(
                                    width: 130,
                                    height: 40,
                                    color: MyTheme.primary_Colour,
                                    child: Column(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          _bestSellingProductList[index].name,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: MyTheme.white),
                                        )),
                                        Row(
                                          children: [
                                            /*  RatingBar(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),*/

                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: RatingBarIndicator(
                                                  rating: 2.75,
                                                  itemBuilder:
                                                      (context, index) => Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 12.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 2, 5, 5),
                                              child: Text(
                                                _bestSellingProductList[index]
                                                    .basePrice,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: MyTheme.white),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )))
                          ],
                        ),
                      ))),
            );
          });
    } else if (!_isBestSellingProductInitial &&
        _bestSellingProductList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).home_screen_no_category_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  buildGroupBuyingProduct(context) {
    if (_isCategoryInitial && _featuredCategoryList.length == 0) {
      return Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
        ],
      );
    } else if (_featuredCategoryList.length > 0) {
      //snapshot.hasData
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _featuredCategoryList.length,
          itemExtent: 130,
          itemBuilder: (context, index) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CategoryProducts(
                                  category_id: _featuredCategoryList[index].id,
                                  category_name:
                                      _featuredCategoryList[index].name,
                                );
                              }));
                            },
                            child: Container(
                                // clipBehavior: Clip.antiAlias,
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  // color: MyTheme.primary_Colour,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyTheme.primary_Colour
                                          .withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: 130,
                                          height: 60,
                                          color: MyTheme.white,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/placeholder.png',
                                              image: AppConfig.BASE_PATH +
                                                  _featuredCategoryList[index]
                                                      .banner,
                                            ),
                                          )),

                                      /*ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                    bottom: Radius.zero),
                                )),*/
                                      Container(
                                          width: 130,
                                          height: 40,
                                          color: MyTheme.primary_Colour,
                                          child: Column(
                                            children: [
                                              Text(
                                                _featuredCategoryList[index]
                                                    .name,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: MyTheme.white),
                                              ),
                                              Row(
                                                children: [
                                                  /*  RatingBar(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),*/

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    child: RatingBarIndicator(
                                                      rating: 2.75,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.white,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 12.0,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 10, 5),
                                                    child: Text(
                                                      "\$3440",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: MyTheme.white),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ))),
                      ),
                      /*  Positioned(
                  right: 3,
                  top: 3,
                  child: Row(
                    children: [
                      Text('1h.30m.12s', style: SFSemiBold.copyWith(color: ColorResources.getPrimaryColor(context), fontSize: Dimensions.FONT_SIZE_LARGE)),
                      SizedBox(width: 5,),
                      Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorResources.getPrimaryColor(context)
                          ),
                          child: Icon(Icons.person_add_alt_1, color: ColorResources.getBackgroundColor(context),))
                    ],
                  ),
                )*/
                    ],
                  )
                ]));
          });
    } else if (!_isCategoryInitial && _featuredCategoryList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).home_screen_no_category_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  buildHomeGroupBuyingProduct(context) {
    if (_isProductInitial && _featuredProductList.length == 0) {
      return Row(
        children: [
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
          Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: ShimmerHelper().buildBasicShimmer(
                  height: 120.0,
                  width: (MediaQuery.of(context).size.width - 32) / 3)),
        ],
      );
    } else if (_featuredProductList.length > 0) {
      //snapshot.hasData
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _featuredProductList.length,
          // itemExtent: 130,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return CategoryProducts(
                                  category_id: _featuredCategoryList[index].id,
                                  category_name:
                                      _featuredCategoryList[index].name,
                                );
                              }));
                            },
                            child: Container(
                                // clipBehavior: Clip.antiAlias,
                                height: 100,
                                width: 150,
                                decoration: BoxDecoration(
                                  // color: MyTheme.primary_Colour,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: MyTheme.primary_Colour
                                          .withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          width: 130,
                                          height: 60,
                                          color: MyTheme.white,
                                          child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/placeholder.png',
                                              image: AppConfig.BASE_PATH +
                                                  _featuredCategoryList[index]
                                                      .banner,
                                            ),
                                          )),

                                      /*ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16),
                                        bottom: Radius.zero),
                                    )),*/

                                      Container(
                                          width: 130,
                                          height: 40,
                                          color: MyTheme.primary_Colour,
                                          child: Column(
                                            children: [
                                              Text(
                                                _featuredCategoryList[index]
                                                    .name,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: MyTheme.white),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    child: RatingBarIndicator(
                                                      rating: 2.75,
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.white,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 12.0,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                  ),
                                                  Expanded(child: Container()),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 10, 5),
                                                    child: Text(
                                                      "3440",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: MyTheme.white),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ))),
                        /* Positioned(
                      right: 0,
                      top: 0,
                      child: Row(
                        children: [
                          Text('1h.30m.12s', style: SFSemiBold.copyWith(color: ColorResources.getPrimaryColor(context), fontSize: Dimensions.FONT_SIZE_LARGE)),
                          SizedBox(width: 5,),
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResources.getPrimaryColor(context)
                              ),
                              child: Icon(Icons.person_add_alt_1, color: ColorResources.getBackgroundColor(context),))
                        ],
                      ),
                    )*/
                      ],
                    ),
                  ],
                ));

            /*return ProductCard(
                id: _featuredProductList[index].id,
                image: _featuredProductList[index].thumbnail_image,
                name: _featuredProductList[index].name,
                main_price: _featuredProductList[index].main_price,
                stroked_price: _featuredProductList[index].stroked_price,
                has_discount: _featuredProductList[index].has_discount);*/

/*
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CategoryProducts(
                      category_id: _featuredCategoryList[index].id,
                      category_name: _featuredCategoryList[index].name,
                    );
                  }));
                },
                 child: Container(
                   // clipBehavior: Clip.antiAlias,
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                     // color: MyTheme.primary_Colour,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: MyTheme.primary_Colour.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],

                    ),


                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(

                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: 130,
                              height: 60,
                              color: MyTheme.white,
                              child:  Padding(
                                padding: EdgeInsets.all(5),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/placeholder.png',
                                  image: AppConfig.BASE_PATH +
                                      _featuredCategoryList[index].banner,


                                ),
                              )),

                          */
/*ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                    bottom: Radius.zero),
                                )),*/ /*

                          Container(
                            width: 130,
                            height: 40,
                            color: MyTheme.primary_Colour,
                            child: Column(
                              children: [
                                Text(
                                  _featuredCategoryList[index].name,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 14, color: MyTheme.white),
                                ),
                                Row(
                                  children: [
                                  */
/*  RatingBar(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),*/ /*


                                    Padding(padding: EdgeInsets.only(left: 5),
                                    child: RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.white,
                                      ),
                                      itemCount: 5,
                                      itemSize: 12.0,
                                      direction: Axis.horizontal,
                                    ),),

                                    Expanded(child: Container()),
                                    Padding(padding: EdgeInsets.fromLTRB(5, 0, 10, 5),
                                    child: Text("3440",style: TextStyle(fontSize: 12, color: MyTheme.white),),)
                                  ],
                                )
                              ],
                            )
                          ),
                        ],
                      ),
                    )
                )
              ),
            );
*/
          });
    } else if (!_isProductInitial && _featuredProductList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).home_screen_no_category_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  buildHomeMenuRow(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CategoryList(
                    is_top_category: true,
                  );
                }));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 5 - 4,
                child: Column(
                  children: [
                    Container(
                        // All Category Container
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: MyTheme.primary_Colour,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: MyTheme.light_grey, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset("assets/all_category.png"),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "All Category",
                        //  AppLocalizations.of(context).home_screen_top_categories,
                        textAlign: TextAlign.center,
                        style: LatoBold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TodaysDealProducts();
                }));
              },
              child: Container(
                // Group Buying Container
                height: 100,
                width: MediaQuery.of(context).size.width / 5 - 4,
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: MyTheme.primary_Colour,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: MyTheme.light_grey, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(Images.group,
                            height: 30,
                            width: 30,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text("Group Buying",
                            // AppLocalizations.of(context).home_screen_todays_deal,
                            textAlign: TextAlign.center,
                            style: LatoBold)),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FlashDealList();
                }));
              },
              child: Container(
                //Brand Container
                height: 100,
                width: MediaQuery.of(context).size.width / 5 - 4,
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: MyTheme.primary_Colour,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: MyTheme.light_grey, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(Images.flash_sale),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text("Flash sale",
                            //AppLocalizations.of(context).home_screen_flash_deal,
                            textAlign: TextAlign.center,
                            style: LatoBold)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  WhichFilter('brands', AppLocalizations.of(OneContext().context).filter_screen_brands);
                  return Filter();
                }));
              },
              child: Container(
                //Brand Container
                height: 100,
                width: MediaQuery.of(context).size.width / 5 - 4,
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: MyTheme.primary_Colour,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: MyTheme.light_grey, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(Images.all_brand),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text("ALL Brand",
                            //AppLocalizations.of(context).home_screen_flash_deal,
                            textAlign: TextAlign.center,
                            style: LatoBold)),
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CategoryList(
                    is_top_category: true,
                  );
                }));
              },
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 5 - 4,
                child: Column(
                  children: [
                    Container(
                        // All Category Container
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: MyTheme.primary_Colour,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: MyTheme.light_grey, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(Images.student),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Student",
                        //  AppLocalizations.of(context).home_screen_top_categories,
                        textAlign: TextAlign.center,
                        style: LatoBold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Filter(
                    selected_filter: "Coupon",
                  );
                }));
              },
              child: Container(
                // Top  Seller
                height: 100,
                width: MediaQuery.of(context).size.width / 5 - 4,
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: MyTheme.primary_Colour,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: MyTheme.light_grey, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(Images.coupon),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text("Coupon",
                            //AppLocalizations.of(context).home_screen_brands,
                            textAlign: TextAlign.center,
                            style: LatoBold)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  WhichFilter('sellers', AppLocalizations.of(OneContext().context).filter_screen_sellers);
                  return Filter(
                    selected_filter: "Top seller",
                  );
                }));
              },
              child: Container(
                // Top  Seller
                height: 100,
                width: MediaQuery.of(context).size.width / 5 - 4,
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: MyTheme.primary_Colour,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: MyTheme.light_grey, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/top_seller.png"),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text("Top Seller",
                            //AppLocalizations.of(context).home_screen_brands,
                            textAlign: TextAlign.center,
                            style: LatoBold)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TopSellingProducts();
                }));
              },
              child: Container(
                // Top Selling
                height: 100,
                width: MediaQuery.of(context).size.width / 5 - 4,
                child: Column(
                  children: [
                    Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: MyTheme.primary_Colour,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: MyTheme.light_grey, width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/top_selling.png"),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text("Top Selling",
                            //AppLocalizations.of(context).home_screen_top_sellers,
                            textAlign: TextAlign.center,
                            style: LatoBold
                        )),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  buildHomeCarouselSlider(context) {
    if (_isCarouselInitial && _carouselImageList.length == 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Shimmer.fromColors(
          baseColor: MyTheme.shimmer_base,
          highlightColor: MyTheme.shimmer_highlighted,
          child: Container(
            height: 120,
            width: double.infinity,
            color: Colors.white,
          ),
        ),
      );
    } else if (_carouselImageList.length > 0) {
      return CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 2.67,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInCubic,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current_slider = index;
              });
            }),
        items: _carouselImageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Stack(
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder_rectangle.png',
                            image: AppConfig.BASE_PATH + i,
                            fit: BoxFit.fill,
                          ))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _carouselImageList.map((url) {
                        int index = _carouselImageList.indexOf(url);
                        return Container(
                          width: 7.0,
                          height: 7.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current_slider == index
                                ? MyTheme.white
                                : Color.fromRGBO(112, 112, 112, .3),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      );
    } else if (!_isCarouselInitial && _carouselImageList.length == 0) {
      return Container(
          height: 100,
          child: Center(
              child: Text(
            AppLocalizations.of(context).home_screen_no_carousel_image_found,
            style: TextStyle(color: MyTheme.font_grey),
          )));
    } else {
      // should not be happening
      return Container(
        height: 100,
      );
    }
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child: widget.show_back_button
            ? Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                    onPressed: () {
                      if (!widget.go_back) {
                        return;
                      }
                      return Navigator.of(context).pop();
                    }),
              )
            : Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 0.0),
                  child: Container(
                    child: Image.asset(
                      'assets/hamburger.png',
                      height: 16,
                      //color: MyTheme.dark_grey,
                      color: MyTheme.primary_Colour,
                    ),
                  ),
                ),
              ),
      ),
      title: Center(
        child: Image.asset(Images.logo, height: 36, width: 120,),
      ),
      elevation: 0.0,
      // titleSpacing: 0,
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return MessengerList();
            }));
          },
          child: Visibility(
            visible: true,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                Images.chat,
                height: 30,
                color: MyTheme.primary_Colour,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            ToastComponent.showDialog(
                AppLocalizations.of(context).common_coming_soon, context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Visibility(
            visible: true,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                Images.notifications,
                height: 30,
                color: MyTheme.primary_Colour,
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildHomeSearchBox(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: MyTheme.primary_Colour,
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
            hintText: AppLocalizations.of(context).home_screen_search,
            hintStyle: TextStyle(fontSize: 12.0, color: MyTheme.white),
            fillColor: MyTheme.primary_Colour,
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
                    right: 5,
                    top: 4,
                    bottom: 4,
                    child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.search,
                            color: MyTheme.primary_Colour,
                            size: 20,
                          ),
                        ))),
              ],
            ),
            contentPadding: EdgeInsets.all(0.0)),
      ),
    );
  }

  Container buildProductLoadingContainer() {
    return Container(
      height: _showProductLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalProductData == _featuredProductList.length
            ? AppLocalizations.of(context).common_no_more_products
            : AppLocalizations.of(context).common_loading_more_products),
      ),
    );
  }
}
