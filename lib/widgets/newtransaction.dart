import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController=TextEditingController();

  final _amountController=TextEditingController();
  DateTime _selectedDate;

  void _submitData(){

    final enteredTitle=_titleController.text;
    final enteredamount=double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredamount<=0 ||_selectedDate==null){
      return;
    }
    widget.addTx(enteredTitle,enteredamount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _datepick(){
    showDatePicker(context: context, initialDate: DateTime.now(),
        firstDate: DateTime(2019), lastDate: DateTime.now())
        .then((pickedDate) {
          if(pickedDate==null)
            return;
          setState(() {
            _selectedDate=pickedDate;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10,right: 10,left: 10,
              bottom:MediaQuery.of(context).viewInsets.bottom+10 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_)=>_submitData(),
              ),
              TextField(decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_)=>_submitData(),
              ),
              Row(
                children:[
                  Expanded(child: Text(_selectedDate==null?"no date chosen":
                  "Picked Date${DateFormat.yMd().format(_selectedDate)}")
      ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text("Choosen Date",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: (){
                      _datepick();
                    },
                  )
                ]
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text("Add Transation"),
                onPressed: _submitData,
              )
            ],),
        ),),
    );
  }
}
