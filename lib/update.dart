import 'package:flutter/material.dart';
import 'package:productapp/databases_instance.dart';
import 'package:productapp/product_model.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel? productModel;

  const UpdateScreen({super.key, this.productModel});

  @override
  State<UpdateScreen> createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  DatabasesInstance databasesInstance = DatabasesInstance();
  TextEditingController insertNameProduct = TextEditingController();
  TextEditingController insertCategoryProduct = TextEditingController();

  @override
  void initState() {
    databasesInstance.checkDatabase();
    insertNameProduct.text = widget.productModel!.name ?? '';
    insertCategoryProduct.text = widget.productModel!.category ?? '';
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
                  await databasesInstance.update(widget.productModel!.id!, {
                    'name': insertNameProduct.text,
                    'category': insertCategoryProduct.text,
                    'create_at': DateTime.now().toString(),
                  });
                  Navigator.pop(context);
                },
                child: Text('Update')),
          )
        ]),
      ),
    );
  }
}
