import 'package:flutter/material.dart';
import 'package:json_dio_sqflite/service_database/service_database.dart';
import 'package:json_dio_sqflite/services/service_api.dart';

import 'models/service_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Service> users = [];
  bool isLoading = false;
  Future refreshUsers() async {
    setState(() => isLoading = true);

    this.users = await ServiceDatabase.instance.readAllUser();

    setState(() => isLoading = false);
  }

  Future updateUsers(Service service) async {
    await ServiceDatabase.instance.update(service);
  }

  Future createUserDb(Service service) async {
    await ServiceDatabase.instance.create(service);
  }

  @override
  void initState() {
    refreshUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return users.length > 0 ?  fromDatabase():fromApi();
  }

  Scaffold fromApi() {
    return Scaffold(
      appBar: AppBar(
        title: Text('From API'),
      ),
      body: FutureBuilder<List<Service>>(
        future: ServiceApi().fetchServiceApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  createUserDb(snapshot.data[index]);
                  return Card(
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
                        ],
                      ),
                    ),
                  );
                });
        },
      ),
    );
  }

  Scaffold fromDatabase() {
    return Scaffold(
      appBar: AppBar(
        title: Text('From Database'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Name :${users[index].name}'),
                          Text('User name :${users[index].username}'),
                          Text('Email :${users[index].email}'),
                          Text('Phno :${users[index].phone}'),
                        ],
                      )),
                );
              }),
    );
  }
}
