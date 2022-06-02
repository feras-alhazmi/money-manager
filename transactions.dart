import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/data.dart';

class Tran extends StatefulWidget {
  final List<Mydata> transaction;
  Tran(this.transaction);

  @override
  State<Tran> createState() => _TranState();
}

class _TranState extends State<Tran> {
  late Mydata x;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 530,
      child: widget.transaction.isEmpty
          ? Column(children: [
              SizedBox(height: 30),
              Text(
                'No data available',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 30),
              Container(
                  height: 400,
                  width: double.infinity,
                  child: Image(image: AssetImage('assets/money1.png')))
            ])
          : ListView.builder(
              itemBuilder: (cntx, index) {
                void undoDelete(index,tran){
                setState(() {
                   widget.transaction.insert(index,tran);});}
                final item = widget.transaction[index].title;
                return Dismissible(
                    key: Key(item),
                    onDismissed: (direction) {
                      setState(() {
                        x=widget.transaction[index];
                        widget.transaction.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('$item dismissed'),
                          action: SnackBarAction(
                            label: "Undo ",
                            onPressed: (){
                              undoDelete(index,x);

                            },
                          ),
                          ));
                    },
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        children: [
                          SizedBox(width:MediaQuery.of(context).size.width*0.03 ,),
                          Icon(
                            Icons.delete,
                            color: Colors.white,),
                          SizedBox(width:MediaQuery.of(context).size.width*0.84 ,),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    child: Card(
                        child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 3)),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '\$${widget.transaction[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w700),
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  // decoration: BoxDecoration(
                                  //     border: Border(
                                  //         top: BorderSide(
                                  //             color: Colors.black, width: 2))),
                                  child: Text(
                                    widget.transaction[index].title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  )),
                              //SizedBox(width: 10,),
                              Container(
                                  child: Text(
                                DateFormat('(y-MMMM-d) H:mm')
                                    .format(widget.transaction[index].date),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                textAlign: TextAlign.left,
                              ))
                            ]),
                            SizedBox(width: MediaQuery.of(context).size.width*0.32,),
                            Text(
                            widget.transaction[index].id,
                            style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                            )
                      ]),
                    )));
              },
              itemCount: widget.transaction.length,
            ),
    );
  }
}
