import 'package:flutter/material.dart';
import 'package:json_dio_sqflite/services/service_api.dart';

import 'models/service_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder<List<Service>>(
        future: ServiceApi().fetchServiceApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(10.0),
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Name :${snapshot.data[index].name}'),
                        Text('User name :${snapshot.data[index].username}'),
                        Text('Email :${snapshot.data[index].email}'),
                        Text('Phno :${snapshot.data[index].phone}'),
                        Text('City :${snapshot.data[index].address.city}'),
                      ],
                    )),
              ),
            );
        },
      )),
    );
  }
}
