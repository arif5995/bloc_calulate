import 'file:///D:/FlutterApp/Latihan/bloc_caculate/bloc_calulate/lib/bloc/bloc.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Bloc _bloc = Bloc(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLOC CALCULATE"),
      ),
      body: SafeArea(
          child: Center(
            child: StreamBuilder<int>(
              stream: _bloc.counterObservable,
              builder: (context, snapshot) {
                return Text(
                  "${snapshot.data}",
                  style: Theme.of(context).textTheme.display2,
                );
              },
            ),
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            heroTag: null,
            onPressed: (){
              _bloc.increment();
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            heroTag: null,
            onPressed: (){
              _bloc.decrement();
            },
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}