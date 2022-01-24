import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/dummy_data/featured_categories.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:active_ecommerce_flutter/screens/category_products.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:active_ecommerce_flutter/ui_elements/AppBar_Common.dart';
import 'package:active_ecommerce_flutter/ui_sections/drawer.dart';
import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

class CategoryList extends StatefulWidget {
  CategoryList(
      {Key key,
      this.parent_category_id = 0,
      this.parent_category_name = "",
      this.is_base_category = false,
      this.is_top_category = false})
      : super(key: key);

  final int parent_category_id;
  final String parent_category_name;
  final bool is_base_category;
  final bool is_top_category;

  int categoryId=4;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _selectedIndex = true;



  var _categoryList=[];
  var _subCategoryList=[];

  bool _isCategoryInitial=true;
  bool _isSubCategoryInitial=true;

  void toggle(){
    _selectedIndex = !_selectedIndex;
  }
  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchSubCategories(widget.categoryId);
  }

  fetchCategories() async {
    var categoryResponse = await CategoryRepository().getCategory();
    _categoryList.addAll(categoryResponse.categories);
    _isCategoryInitial = false;
    setState(() {});
  }

 fetchSubCategories(int categoryId) async {
    var categoryResponse = await CategoryRepository().getSubCategory(categoryId);
    _subCategoryList=[];
    _subCategoryList.addAll(categoryResponse.categories);
    print("Sub Category:"+_subCategoryList.length.toString());
    _isSubCategoryInitial = false;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          backgroundColor: Colors.white,
          appBar: buildCommonAppBar(statusBarHeight,context),
          body: Column(
            children: [
              SizedBox(height: 15,),
              Text('All Category', style: LatoHeavy.copyWith(fontSize: 20, color: MyTheme.primary_Colour),),
              SizedBox(height: 15,),
              SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: buildCategory(),
                //buildHomeFeaturedProduct(context),
              ),
              SizedBox(height: 15,),
              Expanded(
                child: buildCategoryList(),
              ),
            ],
          ),

/*
          Container(
            height: double.infinity,
            width: double.infinity,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
               // SizedBox(width: 10,),

                Padding(
                  padding: EdgeInsets.only(left: 10,top: 10,bottom: 100),
                  child: Container(
                    // height: double.infinity,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: MyTheme.primary_Colour
                      )
                    ),
                    child: ListView.builder(
                      itemCount: featuredCategoryList.length,
                        itemBuilder: (context,index){
                      return Padding(padding: EdgeInsets.all(5),
                      child:  Row(
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: MyTheme.primary_Colour,
                              borderRadius: BorderRadius.circular(180),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 90,
                            child: Text( '${featuredCategoryList[index].name}',
                              style: LatoMedium.copyWith(color: Colors.black, overflow: TextOverflow.clip,  fontSize: 14),

                              //TextStyle(color: Colors.black,  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                         */
/* Expanded(
                            child: Container(),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                          )*//*

                        ],
                      ),);
                    }),
                  ),
                ),

                Expanded(child: Padding(
                    padding: EdgeInsets.all(3),
                    child: buildCategoryList()
                ) ),

              ],
            )

            */
/*CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                      buildCategoryList(),
                      Container(
                        height: widget.is_base_category ? 60 : 90,
                      )
                    ]))
              ],

            ),*//*


          )
*/
        /*Stack(children: [
            Positioned(
              left: 5,
              top: 5,
              right: 5,
              child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [


              ],
            ),),

             Align(
              alignment: Alignment.bottomCenter,
              child: widget.is_base_category || widget.is_top_category
                  ? Container(
                      height: 0,
                    )
                  : buildBottomContainer(),
            )
          ])*/

        /*Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [

                  Container(width: 200,)

                ],
              ),
              SizedBox(width: 10,),
            ],
          )*/
        /*Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text(
                "ALL CATEGORIES",
                style: LatoHeavy.copyWith(fontSize: 20, color: MyTheme.primary_Colour),
              ),),

            ],
          )*/
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: widget.is_base_category
          ? GestureDetector(
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
              child: Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 0.0),
                  child: Container(
                    child: Image.asset(
                      'assets/hamburger.png',
                      height: 16,
                      color: MyTheme.dark_grey,
                    ),
                  ),
                ),
              ),
            )
          : Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
      title: Text(
        "ALL CATEGORIES",
        style: LatoHeavy.copyWith(fontSize: 20, color: MyTheme.primary_Colour),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  String getAppBarTitle() {
    String name = widget.parent_category_name == ""
        ? (widget.is_top_category ? AppLocalizations.of(context).category_list_screen_top_categories : AppLocalizations.of(context).category_list_screen_categories)
        : widget.parent_category_name;

    return name;
  }

  buildCategoryList() {

    if (_isSubCategoryInitial && _subCategoryList.length==0) {
      //snapshot.hasError
      print("Sub category list error");
      return Container(
        height: 10,
      );
    } else if (_subCategoryList.length>0) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1/1.4,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10),
        itemCount: _subCategoryList.length,
        padding: EdgeInsets.all(12),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Filter(link: _subCategoryList[index].links.products,);
              }));
            },
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: MyTheme.white,
                   // border: Border.all(color: Colors.grey[200], width: 1),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: MyTheme.dark_grey.withOpacity(0.2), spreadRadius: 1.5, blurRadius: 1)],

                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FadeInImage.assetNetwork( placeholder: 'assets/placeholder.png',
                      image: AppConfig.BASE_PATH +
                          _subCategoryList[index].banner,
                      fit: BoxFit.scaleDown,height: 100, width: 100,),
                  ),
                ),
                SizedBox(height:5,),
                Text(_subCategoryList[index].name,style: LatoMedium.copyWith(color: Colors.black), overflow: TextOverflow.ellipsis,)
              ],
            ),
          );
        },

      );
      /*GridView.builder(

                  scrollDirection: Axis.vertical,
                 // physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      childAspectRatio: .8/1,
                      crossAxisSpacing: 5),
                  itemCount: categoryResponse.categories.length,
                  itemBuilder: (context, index) {
                    return  Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                         Expanded(child: Container(
                           width: 80,
                           height: 80,
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(10),
                               boxShadow: [
                                 BoxShadow(
                                     color: Colors.black.withOpacity(.2),
                                     spreadRadius: .5,
                                     blurRadius: 2,
                                     offset: Offset(0, .3))
                               ]),
                           child: Center(
                               child: Padding(
                                 padding: EdgeInsets.all(5),
                                 child: FadeInImage.assetNetwork(
                                   placeholder: 'assets/placeholder.png',
                                   image: AppConfig.BASE_PATH +
                                       categoryResponse.categories[index].banner,
                                   fit: BoxFit.cover,
                                  *//* height: 70,
                                   width: 70,*//*
                                 ),
                               )
                           ),
                         ),

                         ),
                           // SizedBox(height: 5,),
                          //  Text(categoryResponse.categories[index].name,style: LatoMedium.copyWith(color: Colors.black), overflow: TextOverflow.ellipsis,),
                             Expanded(child:  Center(child: Text(categoryResponse.categories[index].name, overflow: TextOverflow.ellipsis,),),)

                          ],
                        )
                    );
                  });*/
      /*SingleChildScrollView(
              child: ListView.builder(
                itemCount: categoryResponse.categories.length,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
                    child: buildCategoryItemCard(categoryResponse, index),
                  );
                },
              ),
            );
            */
    } else {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: MyTheme.shimmer_base,
                    highlightColor: MyTheme.shimmer_highlighted,
                    child: Container(
                      height: 60,
                      width: 60,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 8.0),
                        child: Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * .7,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * .5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }


  }
   buildCategory() {
    if (_isCategoryInitial && _categoryList.length==0) {
      //snapshot.hasError
      print("category list error");
      return Container(
        height: 10,// 01923531404
      );
    } else if (_categoryList.length>0) {

      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categoryList.length,
          itemExtent: 90,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                setState(() {
                  widget.categoryId=_categoryList[index].id;
                  fetchSubCategories(_categoryList[index].id);
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
                          color:  MyTheme.white,
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
                        child: FadeInImage.assetNetwork( placeholder: 'assets/placeholder.png',
                          image: AppConfig.BASE_PATH +
                              _categoryList[index].banner,
                          fit: BoxFit.scaleDown,height: 50, width: 50,),),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10),
                      child: Text(_categoryList[index].name, style: LatoHeavy,),
                    )
                  ],
                ),
              ),
            );
          });

    } else {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                  top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: MyTheme.shimmer_base,
                    highlightColor: MyTheme.shimmer_highlighted,
                    child: Container(
                      height: 60,
                      width: 60,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, bottom: 8.0),
                        child: Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * .7,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Shimmer.fromColors(
                          baseColor: MyTheme.shimmer_base,
                          highlightColor: MyTheme.shimmer_highlighted,
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * .5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

  }

  Card buildCategoryItemCard(categoryResponse, index) {
    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
            width: 80,
            height: 80,
            child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(16), right: Radius.zero),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: AppConfig.BASE_PATH +
                      categoryResponse.categories[index].banner,
                  fit: BoxFit.cover,
                ))),
        Container(
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 8, 0),
                child: Text(
                  categoryResponse.categories[index].name,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: MyTheme.font_grey,
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(32, 8, 8, 4),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (categoryResponse
                                .categories[index].number_of_children >
                            0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CategoryList(
                              parent_category_id:
                                  categoryResponse.categories[index].id,
                              parent_category_name:
                                  categoryResponse.categories[index].name,
                            );
                          }));
                        } else {
                          ToastComponent.showDialog(
                              AppLocalizations.of(context).category_list_screen_no_subcategories, context,
                              gravity: Toast.CENTER,
                              duration: Toast.LENGTH_LONG);
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context).category_list_screen_view_subcategories,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: categoryResponse
                                        .categories[index].number_of_children >
                                    0
                                ? MyTheme.medium_grey
                                : MyTheme.light_grey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Text(
                      " | ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: MyTheme.medium_grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryProducts(
                            category_id: categoryResponse.categories[index].id,
                            category_name:
                                categoryResponse.categories[index].name,
                          );
                        }));
                      },
                      child: Text(
                        AppLocalizations.of(context).category_list_screen_view_products,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: MyTheme.medium_grey,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Container buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),

      height: widget.is_base_category ? 0 : 80,
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width - 32),
                height: 40,
                child: FlatButton(
                  minWidth: MediaQuery.of(context).size.width,
                  //height: 50,
                  color: MyTheme.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: Text(
                    AppLocalizations.of(context).category_list_screen_all_products_of + " " + widget.parent_category_name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CategoryProducts(
                        category_id: widget.parent_category_id,
                        category_name: widget.parent_category_name,
                      );
                    }));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final bool index;

  CategoryItem({@required this.title, this.index});

  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
            height: 20,
            width: 20,
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: index ? Colors.red : Colors.white)
            ),
            child: Container(
                height: 20,
                width: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ))
        ),
        Text(title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: LatoMedium.copyWith(
                fontSize: 12,
                color: Colors.black)),
      ]),
    );
  }
}
