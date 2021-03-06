import 'package:expense_manager/chart.dart';
import 'package:expense_manager/widgets/newtransaction.dart';
import 'package:expense_manager/widgets/transation_list.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/transation.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp]);
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
            accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
          button: TextStyle(color: Colors.white)
        )

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];
  bool _showChart=false;
  List<Transaction> get _recentTransaction{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7))
      );
    }).toList();
  }
  void _addNewTransaction(String txTitle, double txAmount,DateTime choosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id==id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // to avoid multiple multiple object creationg
    final mediaquery=MediaQuery.of(context);
    final isLandscape=mediaquery.orientation==Orientation.landscape;
    final appBar=AppBar(
      title: Text('Flutter App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    final txListWidget=Container(
        height: (mediaquery.size.height
            -appBar.preferredSize.height
            -MediaQuery.of(context).padding.top)*0.7,
        child: TransactionList(_userTransactions,_deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape)Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(value: _showChart,onChanged: (val){
                  setState(() {
                    _showChart=val;
                  });
                },)
              ],
            ),
            if(!isLandscape)Container(
                width: double.infinity,
                height: (mediaquery.size.height
                    -appBar.preferredSize.height
                    -MediaQuery.of(context).padding.top)*0.3,
                child: Chart(_recentTransaction)
            ),
            if(!isLandscape)txListWidget,
            if(isLandscape)_showChart?Container(
              width: double.infinity,
              height: (mediaquery.size.height
                  -appBar.preferredSize.height
              -mediaquery.padding.top)*0.7,
              child: Chart(_recentTransaction)
            ):
            txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}