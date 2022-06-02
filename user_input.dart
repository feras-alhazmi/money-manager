import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../shared/inputdecor.dart';

var textval = TextEditingController();
var amountval = TextEditingController();
var catoqery;

class User_input extends StatefulWidget {
  final Function addtext;
  User_input(this.addtext);

  @override
  State<User_input> createState() => _User_inputState();
}

class _User_inputState extends State<User_input> {
  
  DateTime _slectedDate = DateTime.now();
  List<String> catoqary = [
    "Food",
    "Transportation",
    "Education",
    "Health",
    "Other"
  ];

  var c;

  var amountval = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _submitData() {
      var text = textval.text;
      var amount = double.parse(amountval.text);
      if (text.isNotEmpty || amount > 0) {
        Navigator.of(context).pop();
        widget.addtext(text, amount, _slectedDate,catoqery);
      }
    }
  bool isNumeric(String s) {
 return double.tryParse(s) != null;
}

    void _DataPicker() {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2011),
              lastDate: DateTime.now())
          .then((PickedDate) {
        if (PickedDate == null) {
          return;
        }
        setState(() {
          _slectedDate = PickedDate;
        });
      });
    }

    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.96,
          height:  MediaQuery.of(context).size.height*0.1,
          child: TextField(
            maxLength: 15,
            controller: textval,
            decoration: inputdecor.copyWith(
                hintText: 'inter the item name', errorText: c),
            onSubmitted: (_) => _submitData(),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.96,
          height:  MediaQuery.of(context).size.height*0.1,
          child: TextField(
            maxLength: 5,
            controller: amountval,
            onChanged: (String k) {
              if (isNumeric(k)&&double.parse(k) > 0) {
                print(isNumeric(k));
                return;
              }else{
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('add a Positve number'),
                    content: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  );
                },
              );
            }},
            decoration: inputdecor.copyWith(
                border: OutlineInputBorder(),
                hintText: ' inter the amount',
                errorText: b),
            onSubmitted: (_) => _submitData(),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.96,
          height:  MediaQuery.of(context).size.height*0.1,
          child: DropdownButtonFormField(
            items: catoqary.map((type) {
              return DropdownMenuItem(value: type, child: Text("$type"));
            }).toList(),
            onChanged: (String? type) {
              setState(() {
                catoqery=type;
              });
            },
          ),
        ),
        Column(
          children: [
            ElevatedButton(
                onPressed: _submitData,
                child: Text('add new transaction'),
                style: ElevatedButton.styleFrom(onPrimary: Colors.black)),
            const SizedBox(
              width: 40,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  DateFormat.yMd().format(_slectedDate),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 100,
                ),
                ElevatedButton(
                    onPressed: _DataPicker,
                    child: const Text('Change the date',
                        style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(onSurface: Colors.purple)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
