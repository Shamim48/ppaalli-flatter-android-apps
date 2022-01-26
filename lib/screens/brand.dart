import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/repositories/brand_repository.dart';
import 'package:active_ecommerce_flutter/ui_elements/AppBar_Common.dart';
import 'package:active_ecommerce_flutter/ui_elements/brand_square_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_theme.dart';

class AllBrand extends StatefulWidget {
  const AllBrand({Key key}) : super(key: key);

  @override
  _AllBrandState createState() => _AllBrandState();
}

class _AllBrandState extends State<AllBrand> {

  List<dynamic> _brandList = [];
  bool _isBrandInitial = true;
  int _brandPage = 1;
  int _totalBrandData = 0;
  bool _showBrandLoadingContainer = false;

  String _searchKey="";
  ScrollController _brandScrollController = ScrollController();

  ScrollController _scrollController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchBrandData();

    _brandScrollController.addListener(() {
      if (_brandScrollController.position.pixels ==
          _brandScrollController.position.maxScrollExtent) {
        setState(() {
          _brandPage++;
        });
        _showBrandLoadingContainer = true;
        fetchBrandData();
      }
    });


  }

  Future<void> _onBrandListRefresh() async {
    resetBrandList();
    fetchBrandData();
  }

  fetchBrandData() async {
    var brandResponse =
    await BrandRepository().getBrands(page: _brandPage, name: _searchKey);
    _brandList.addAll(brandResponse.brands);
    _isBrandInitial = false;
    _totalBrandData = brandResponse.meta.total;
    _showBrandLoadingContainer = false;
    setState(() {});
  }

  resetBrandList() {
    _brandList.clear();
    _isBrandInitial = true;
    _totalBrandData = 0;
    _brandPage = 1;
    _showBrandLoadingContainer = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithBackAndTitle(context, "All Brand"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: buildBrandList(),

      ),
    );
  }

  Container buildBrandLoadingContainer() {
    return Container(
      height: _showBrandLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalBrandData == _brandList.length
            ? AppLocalizations.of(context).common_no_more_brands
            : AppLocalizations.of(context).common_loading_more_brands),
      ),
    );
  }

  Container buildBrandList() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: buildBrandScrollableList(),
          )
        ],
      ),
    );
  }

  buildBrandScrollableList() {
    if (_isBrandInitial && _brandList.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildSquareGridShimmer(scontroller: _scrollController));
    } else if (_brandList.length > 0) {
      return RefreshIndicator(
        color: Colors.white,
        backgroundColor: MyTheme.primaryColor,
        onRefresh: _onBrandListRefresh,
        child: SingleChildScrollView(
          controller: _brandScrollController,
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
                itemCount: _brandList.length,
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1),
                padding: EdgeInsets.all(10),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // 3
                  return BrandSquareCard(
                    id: _brandList[index].id,
                    image: _brandList[index].logo,
                    name: _brandList[index].name,
                  );
                },
              )
            ],
          ),
        ),
      );
    } else if (_totalBrandData == 0) {
      return Center(child: Text(AppLocalizations.of(context).common_no_brand_is_available));
    } else {
      return Container(); // should never be happening
    }
  }


}
