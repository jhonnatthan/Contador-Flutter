import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int contador = 0;

  getCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt('counter') ?? 0;

    this.setState(() {
      contador = counter;
    });
  }

  decrementCounter() async {
    int newValue = contador - 1;

    if (newValue >= 0) {
      this.setState(() {
        contador = newValue;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('counter', newValue);
    }
  }

  incrementCounter() async {
    int newValue = contador + 1;

    this.setState(() {
      contador = newValue;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', newValue);
  }

  void initState() {
    super.initState();
    getCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contador"),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        '$contador',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 75,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(right: 5),
                                    child: RaisedButton(
                                      onPressed: decrementCounter,
                                      child: Text('Decrementar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      color: Colors.deepPurple,
                                    ))),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: RaisedButton(
                                      onPressed: incrementCounter,
                                      child: Text('Incrementar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                      color: Colors.deepPurple,
                                    )))
                          ],
                        )),
                  ],
                ))));
  }
}
