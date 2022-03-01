import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/group_buying_repository.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/screens/product_card.dart';
import 'package:active_ecommerce_flutter/screens/product_details.dart';
import 'package:active_ecommerce_flutter/ui_elements/group_buying_product_card.dart';
import 'package:active_ecommerce_flutter/utill/images.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StudentProduct extends StatefulWidget {
  const StudentProduct({Key key}) : super(key: key);

  @override
  _StudentProductState createState() => _StudentProductState();
}

class _StudentProductState extends State<StudentProduct> {

  var _stProductList = [];
  bool _isStProductInitial = true;
  int _totalStProductData = 0;
  bool _showProductLoadingContainer = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ScrollController _mainScrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAll();
  }

  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  fetchGroupBuyingProducts() async {
    var productResponse = await ProductRepository().getStudentProducts();
    _stProductList.addAll(productResponse.data);
    _isStProductInitial = false;
    _totalStProductData = _stProductList.length;
    _showProductLoadingContainer = false;
    setState(() {

    });
  }

  Future<void> _onRefresh() async {
    reset();
    fetchAll();
  }
  void fetchAll() {
    fetchGroupBuyingProducts();
  }
  reset() {
    _isStProductInitial=true;
    _stProductList.clear();

    setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: buildAppBar(context),
        backgroundColor: Colors.white,
        body: Stack(overflow: Overflow.visible, children: [
          buildProductList()
        ]),
      ),
    );
  }

  Container buildProductList() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: buildProductScrollableList(),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child: Builder(
          builder: (context) => Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 0.0),
            child: Container(
              child: Icon(Icons.arrow_back, size: 30, color: MyTheme.primary_Colour,)
            ),
          ),
        ),
      ),
      title: Text("Students Discount Product",
        style: LatoHeavy.copyWith(color: MyTheme.primary_Colour, fontSize: 22),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }


  buildProductScrollableList() {
    if (_isStProductInitial && _stProductList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildProductGridShimmer(scontroller: _mainScrollController));
    } else if (_stProductList.length > 0) {
      return RefreshIndicator(
        color: Colors.white,
        backgroundColor: MyTheme.primaryColor,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          controller: _mainScrollController,
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
                itemCount: _stProductList.length,
                controller: _mainScrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.618),
                padding: EdgeInsets.all(16),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // 3
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return ProductDetails(
                              id: _stProductList[index].id,
                            );
                          }));
                    },

                    child: ProductCard(
                      id: _stProductList[index].id,
                      image: _stProductList[index].thumbnailImage,
                      name: _stProductList[index].name,
                      main_price: _stProductList[index].basePrice,
                      rating: _stProductList[index].rating,
                    ),
                  );
                  /*ProductCard(
                      id: _productList[index].id,
                      image: _productList[index].thumbnailImage,
                      name: _productList[index].name,
                      main_price: _productList[index].basePrice,
                  );*/
                },
              )
            ],
          ),
        ),
      );
    } else if (_totalStProductData == 0) {
      return Center(child: Text( AppLocalizations.of(context).common_no_product_is_available));
    } else {
      return Container(); // should never be happening
    }
  }
}
