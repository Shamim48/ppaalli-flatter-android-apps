import 'package:active_ecommerce_flutter/utill/styles.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {


  bool _selectedIndex = true;

  void toggle(){
    _selectedIndex = !_selectedIndex;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Text('All Category', style: TextStyle(fontSize: 20, color: Colors.red),),
          SizedBox(height: 15,),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: 130,
                    height: double.infinity,
                    margin: EdgeInsets.only(top: 3, left: 8, bottom: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all( color: Theme.of(context).primaryColor,width: 1),
                    ),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 10,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            toggle();
                            setState(() {
                            });
                          },
                          child: CategoryItem(
                            title: 'Item',
                            index: _selectedIndex,
                          ),
                        );
                      },
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1/1.4,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10),
                      itemCount: 16,
                      padding: EdgeInsets.all(12),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200], width: 1),
                                borderRadius: BorderRadius.circular(12),
                                //boxShadow: [BoxShadow(color: Colors.grey[300], spreadRadius: 0.5, blurRadius: 0.1)],
                              ),
                              child: Image.network('https://media.istockphoto.com/photos/running-shoes-picture-id1249496770?b=1&k=20&m=1249496770&s=170667a&w=0&h=_SUv4odBqZIzcXvdK9rqhPBIenbyBspPFiQOSDRi-RI=',
                                fit: BoxFit.scaleDown,height: 100, width: 100,),
                            ),
                            SizedBox(height:5,),
                            Text('Shoes',)
                          ],
                        );
                      },

                    ),
                  ),
                ]),
          ),
        ],
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
