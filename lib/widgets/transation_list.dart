import 'package:flutter/material.dart';
import '../model/transation.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  // final List<Transation> userTransations=[
  //   Transation(id: 't1',title: 'shoe',amount: 60,date: DateTime.now()),
  //   Transation(id: 't1',title: 'shoe',amount: 60,date: DateTime.now()),
  //   Transation(id: 't1',title: 'shoe',amount: 60,date: DateTime.now()),
  //
  // ];
  final Function deleteTx;
  final List<Transaction> transactions;
  TransactionList(this.transactions,this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder:(context, index) {
          return
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(radius: 30,child:
                Padding(
                  padding: EdgeInsets.all(6),
                    child: FittedBox(child: Text('\$${transactions[index].amount}'))),),
                title: Text(transactions[index].title),
                subtitle: Text(DateFormat.yMMMMEEEEd().format(transactions[index].date)),
                trailing: MediaQuery.of(context).size.width>500?
                      FlatButton.icon(onPressed: (){deleteTx(transactions[index].id);},
                          icon: Icon(Icons.delete), label: Text("delete"),)
                      :IconButton(
                  icon: Icon(Icons.delete),color: Colors.red[500],
                  onPressed: (){deleteTx(transactions[index].id);},
                )
              ),
            );
        },
        itemCount: transactions.length,
        );
  }
}
