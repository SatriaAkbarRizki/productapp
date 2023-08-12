import 'package:flutter/material.dart';
import 'package:productapp/create.dart';
import 'package:productapp/databases_instance.dart';
import 'package:productapp/product_model.dart';
import 'package:productapp/update.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  DatabasesInstance? databasesInstance;

  Future<void> _refresh() async {
    setState(() {});
  }

  Future<void> _initDatabases() async {
    await databasesInstance!.checkDatabase();
    setState(() {});
  }

  Future deleteItem(int id) async {
    await databasesInstance!.delete(id);
    setState(() {});
  }

  @override
  void initState() {
    databasesInstance = DatabasesInstance();
    _initDatabases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Barang'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateScreen()),
              ).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: Colors.green,
        onRefresh: _refresh,
        child: databasesInstance != null
            ? FutureBuilder<List<ProductModel>?>(
                future: databasesInstance!.all(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length == 0) {
                      return Center(
                        child: Text('Data tidak ada'),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].name ?? 'Null'),
                          subtitle:
                              Text(snapshot.data![index].category ?? 'Null'),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateScreen(
                                            productModel: snapshot.data![index],
                                          )));
                            },
                            icon: Icon(Icons.edit_rounded),
                          ),
                          leading: IconButton(
                            onPressed: () {
                              deleteItem(snapshot.data![index].id!);
                            },
                            icon: Icon(Icons.delete_rounded),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text('Terjadi kesalahan saat memuat data'),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    );
                  }
                },
              )
            : Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
      ),
    );
  }
}
