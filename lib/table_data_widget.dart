import 'package:flutter/material.dart';
import './styles.dart';

class TableData extends StatelessWidget {
  final List<String> heads ;
  final List data ;
  final  List type ;
  final String title ;
  const TableData(

  {
  this.heads,
  this.data ,
  this.type,
  this.title,
  this.showCheckBox = false 
  }
  ) ;
  final showCheckBox ;
  @override
  Widget build(BuildContext context) {
    return Container(
       margin:  const EdgeInsets.all(0.0),
       padding: EdgeInsets.zero,
       decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],),
    height: MediaQuery.of(context).size.height * 0.70,
    child: table(context , heads , type , data));
  }

  
Widget table(context ,List<String> heads , type , data){
  List<DataColumn> dataCol = [];
  heads.forEach((element) {
    dataCol.add( DataColumn(label: Text(element)),);
   });
  
  return  ListView(
    padding: EdgeInsets.zero,
    physics: NeverScrollableScrollPhysics(),
        children: [
         
          PaginatedDataTable(
            showCheckboxColumn: showCheckBox ,
            
            header:  Container(width : double.infinity , child : Text(title, textAlign: TextAlign.right, style: boldLargeTextStyle(Colors.black),)),
            rowsPerPage: /*data.length >5 ? 5 : data.length*/ 5,
            columns: dataCol,/* [
              DataColumn(label: Text("employee name".tr())),
              DataColumn(label: Text( "employee nu" .tr())),
              DataColumn(label: Text("date".tr())),
              DataColumn(label: Text("order state".tr())),
              DataColumn(label: Text("edit".tr())),
              DataColumn(label: Text("post status".tr())),
            ],*/
            source: _DataSource(context , heads.length , type , data),
          ),
        ],
      );
}
}
class _Row {
  _Row(
   this.valueA,
    this.valueB,
    this.valueC,
    this.valueD,
    this.valueE,
    this.valueF
  );

  final Text valueA;
  final Text valueB;
  final Text valueC; 
  final Text valueD;
  final IconButton valueE;
  final IconData valueF;


  bool selected = false;
}

class _DataSource extends DataTableSource {
  final int length ;
  final List _type ;
  final List data ;
  _DataSource(this.context , this.length, this._type , this.data) {

    _rows = <_Row>[
     _Row(Text('Cell A1'), Text('CellB1'), Text('CellC1'),  Text("1") , IconButton(icon: Icon(Icons.edit), onPressed: (){}) ,  Icons.person),
     _Row(Text('Cell A2'), Text('CellB2'), Text('CellC2'),  Text("2") , IconButton(icon: Icon(Icons.edit), onPressed: (){}) ,  Icons.person),
     _Row(Text('Cell A3'), Text('CellB3'), Text('CellC3'),  Text("3") , IconButton(icon: Icon(Icons.edit), onPressed: (){}) ,  Icons.person),
     _Row(Text('Cell A4'), Text('CellB4'), Text('CellC4'),  Text("4") , IconButton(icon: Icon(Icons.edit), onPressed: (){}) ,  Icons.person),
     _Row(Text('Cell A5'), Text('CellB5'), Text('CellC5'),  Text("5") , IconButton(icon: Icon(Icons.edit), onPressed: (){}) ,  Icons.person),
  ];
  }

  final BuildContext context;
  List<_Row> _rows;
  int _selectedCount = 0;


  @override
  DataRow getRow(int index) {
    
    assert(index >= 0);
    //if (index >= _rows.length) return null;
    if (index >= _type.length) return null;
    final type = _type[index];

    return DataRow.byIndex(
      index: index,
      selected: type.selected,
      onSelectChanged: (value) {
        if (type.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          type.selected = value;
          notifyListeners();
        }
      },
      cells: type.getWidgets(),
     // cells: [DataCell((row.valueA)), DataCell((row.valueB)),DataCell((row.valueC)),DataCell(row.valueD),DataCell(row.valueE),DataCell(Icon(row.valueF))] ,
    );
  }


  @override
  DataRow getRow_h(int index) {
    List<DataCell> cells = [];
    assert(index >= 0);
   if (index >= _rows.length) return null;
    final row = _rows[index];

      data[index].forEach((element) {
          cells.add(DataCell(Text(element.toString())));
         });
      cells.add(DataCell(IconButton(icon: Icon(Icons.edit), onPressed: (){})));

         print(index);
       //  print(data);

    return DataRow.byIndex(
      
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
     // cells: cells,
      cells: [DataCell((row.valueA)), DataCell((row.valueB)),DataCell((row.valueC)),DataCell(row.valueD),DataCell(row.valueE),DataCell(Icon(row.valueF))] ,
    );
  }

  @override
  int get rowCount => _type.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
