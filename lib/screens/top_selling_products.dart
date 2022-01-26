import 'package:active_ecommerce_flutter/screens/product_card.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopSellingProducts extends StatefulWidget {
  @override
  _TopSellingProductsState createState() => _TopSellingProductsState();
}

class _TopSellingProductsState extends State<TopSellingProducts> {
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: buildProductList(context),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.primary_Colour, size: 25,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        AppLocalizations.of(context).top_selling_products_screen_top_selling_products,
        style: LatoHeavy.copyWith(fontSize: 20, color: MyTheme.primaryColor, fontWeight: FontWeight.w900),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildProductList(context) {
    return FutureBuilder(
        future: ProductRepository().getBestSellingProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            //snapshot.hasError
            print("product error");
            print(snapshot.error.toString());
            return Container();
          } else if (snapshot.hasData) {
            var productResponse = snapshot.data;
            print(productResponse.toString());
            return SingleChildScrollView(
              child: GridView.builder(
                // 2
                //addAutomaticKeepAlives: true,
                itemCount: productResponse.data.length,
                controller: _scrollController,
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
                  return ProductCard(
                    id: productResponse.data[index].id,
                    image: productResponse.data[index].thumbnailImage,
                    name: productResponse.data[index].name,
                    main_price: productResponse.data[index].basePrice,
                    rating: productResponse.data[index].rating,
                  );
                },
              ),
            );
          } else {
            return ShimmerHelper()
                .buildProductGridShimmer(scontroller: _scrollController);
          }
        });
  }
}
