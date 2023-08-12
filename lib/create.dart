import 'package:flutter/material.dart';
import 'package:productapp/databases_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => CreateScreenState();
}

class CreateScreenState extends State<CreateScreen> {
  DatabasesInstance databasesInstance = DatabasesInstance();
  TextEditingController insertNameProduct = TextEditingController();
  TextEditingController insertCategoryProduct = TextEditingController();

  @override
  void initState() {
    databasesInstance.checkDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nambah Barang'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Nama Product'),
          TextField(
            controller: insertNameProduct,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Category'),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: insertCategoryProduct,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: () async {
                  await databasesInstance.insert({
                    'name': insertNameProduct.text,
                    'category': insertCategoryProduct.text,
                    'create_at': DateTime.now().toString(),
                    'update_at': DateTime.now().toString()
                  });
                  Navigator.pop(context);
                },
                child: Text('Submit')),
          )
        ]),
      ),
    );
  }
}
