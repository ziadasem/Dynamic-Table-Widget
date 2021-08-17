import 'package:dynamicTable/table_data_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  
  //mockup data
  final List data1 = [ ["Cell 11" , "Cell 12" , "Cell 13" , "Cell 14" , true] , ["Cell 21" , "Cell 22" , "Cell 23" , "Cell 24", true] ,
  ["Cell 31" , "Cell 32" , "Cell 33" , "Cell 34", true] ,["Cell 41" , "Cell 42" , "Cell 43" , "Cell 44" , false] ] ;

  final List data2 = [ ["element 11" , "element 12" , "element 13"] , ["element 21" , "element 22" , "element 23" ,] ,
  ["element 31" , "element 32" , "element 33" ] ,["element 41" , "element 42" , "element 43" ] ] ;

  final List<String> heads1 = ["Col 1" , "Col 2" , "Col 3" , "icon button " , "Icon"];
  final List<String> heads2 = ["text 1" , "text 2" , "Table2 3" ];

  @override
  Widget build(BuildContext context) {
  List<_RowX> x = []; //generate dynamic elements
  List<_RowX2> y = [];

    data1.forEach((element) {  //generate widgets for first table
      x.add(_RowX ( 
        Text(element[0]) ,  Text(element[1]),  Text(element[2]), 
        IconButton(icon: Icon(Icons.remove_red_eye), onPressed: (){
         _scaffoldkey.currentState.showSnackBar(SnackBar(
            content: Text(element[3]),
          ));},) ,

         Icon(element[4] ?Icons.done : Icons.cancel))); });

     data2.forEach((element) {  //generate widgets for second table
      y.add(_RowX2 ( 
        Text(element[0]) ,  Text(element[1]),  Text(element[2]), ));
        });

     return Scaffold(
       key: _scaffoldkey,
      appBar: AppBar(
    title: Text("dynamic tables"),
      ),
      body: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //pass table heads then the data then widgets then table title
           TableData(heads :heads1,  data: data1,type: x, title : "first table" ), 
           SizedBox(height: 10,),
           //you can enable or disable checkbox
           TableData(heads :heads2,  data: data2,type: y, title : "second table" , showCheckBox: true,),
          ],
        ),
      ),
    );
  }
}

// design widgets to be filled in each row for first table
class _RowX {
  _RowX(
   this.valueA,
    this.valueB,
    this.valueC,
    this.valueF,
    this.valueG
  );

  final Text valueA;
  final Text valueB;
  final Text valueC; 
  final IconButton valueF;
  final Icon valueG ;
  List<DataCell> getWidgets(){
    //we have three text widgets, icon button and icon
    return [ DataCell(valueA) , DataCell(valueB) , DataCell(valueC)  , DataCell(valueF) ,  DataCell(valueG)];
  }
  bool selected = false;
}

class _RowX2 {
  _RowX2(
   this.valueA,
    this.valueB,
    this.valueC,
  );

  final Text valueA;
  final Text valueB;
  final Text valueC; 
      //we have three text widgets
  List<DataCell> getWidgets(){
    return [ DataCell(valueA) , DataCell(valueB) , DataCell(valueC)  ];
  }
  bool selected = false;
}