
import 'package:assignment_course/Auth/welcomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'transactions.dart';
import '../../widgets/user_input.dart';
import '../models/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chart.dart';       

class homescreen extends StatefulWidget {
  homescreen({
    Key? key,
  }) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  List<Mydata> data = [];

  void _Newtransaction(String title, double amount, DateTime ChosenDate, String type) {
    setState(() {
      print(data);
      data.insert(
          0,
          Mydata(
              title: title,
              amount: amount,
              id: type,
              date: ChosenDate));

    });
  }
  // void _update()async{
  //   await FirebaseFirestore.instance.collection('UsersData').doc(user_ID).set({'DataList':data});
  // }
void _startAuth(ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return WelcomePage();
        });
  }

 void _startTransaction(ctx) async{
  //  String user_ID=FirebaseAuth.instance.currentUser!.uid;
  //  await FirebaseFirestore.instance.collection('UsersData').doc(user_ID).set(<String, List<Mydata>>{
  //    'DataList':data
  //  });
  //  final shit= await FirebaseFirestore.instance.collection('UsersData').doc(user_ID).get();
  //   //final shit2=Provider.of<QuerySnapshot>(context);
  //  print(shit.data()!['DataList']);
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {}, child: User_input(_Newtransaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'money manger app ',
            style: TextStyle(fontSize: 15),
          ),
          leading:  ElevatedButton(
                  onPressed: () {_startAuth(context);},
                  child: Icon(
                    Icons.account_box_rounded,
                    size: 26.0,
                  ),
                ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      data= data.reversed.toList();
                    });
                  },
                  child: Icon(
                    Icons.more_vert,
                    size: 26.0,
                  ),
                )),
          ],
        ),
        body: Column(
          children: [
            //Chart(data),
            Tran(data),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.amber,
            //Color: Colors.amber,
            child: Icon(Icons.add),
            onPressed: () => _startTransaction(context)));
  }
}
