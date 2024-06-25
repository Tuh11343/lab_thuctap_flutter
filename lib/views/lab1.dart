import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab/controllers/lab_controller.dart';

import '../models/product.dart';
import '../models/product_type.dart';
import '../widgets/message.dart';
import '../widgets/product_view.dart';

class Lab1View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Lab1ViewState();
  }
}

class Lab1ViewState extends State<Lab1View> {
  LabController labController = LabController();

  void add(){
    setState(() {
      labController.add(Product(name: '',productTypeList: [
        ProductType(name: 'Vinataba', inputList: [0, 0]),
        ProductType(name: 'Vidana Black', inputList: [0, 0]),
        ProductType(name: 'Amore', inputList: [0, 0]),
      ]));
    });
  }

  void delete(int index){
    setState(() {
      labController.delete(index);
    });
  }

  void productChanged(int productIndex, String value){
    labController.setProductChoose(productIndex, value);
  }

  void importChanged(int productIndex,int productTypeIndex,int value){
    labController.importChanged(productIndex, productTypeIndex, value);
  }

  void exportChanged(int productIndex,int productTypeIndex,int value){
    labController.exportChanged(productIndex, productTypeIndex, value);
  }

  void _showValuesDialog(BuildContext context) {
    messageSnackBar(
        context, 'So luong:${labController.productChooseList.length}');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('All Values'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
                itemCount: labController.productChooseList.length,
                shrinkWrap: true,
                itemBuilder: (context, productIndex) {
                  return Row(
                    children: [
                      Text(
                        productIndex.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 4,
                        child: Text(
                          labController.productChooseList[productIndex],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 4,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: labController
                              .productTypeList[productIndex].length,
                          shrinkWrap: true,
                          itemBuilder: (context, productTypeIndex) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Text(
                                    productTypeIndex.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Import:${labController.productTypeList[productIndex][productTypeIndex].inputList[0]}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        'Export:${labController.productTypeList[productIndex][productTypeIndex].inputList[1]}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    labController.productChooseList.add('');
    labController.productTypeList.add([
      ProductType(name: 'Vinataba', inputList: [0, 0]),
      ProductType(name: 'Vidana Black', inputList: [0, 0]),
      ProductType(name: 'Amore', inputList: [0, 0]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: labController.productChooseList.length,
          itemBuilder: (context, index) {
            return ProductWidget(
              index: index,
              productList: [
                'Test Nhân Viên 1',
                'Test Nhân Viên 2',
                'Test Nhân Viên 3'
              ],
              productTypeList: [
                ProductType(name: 'Vinataba', inputList: [0, 0]),
                ProductType(name: 'Vidana Black', inputList: [0, 0]),
                ProductType(name: 'Amore', inputList: [0, 0]),
              ],
              importChanged: importChanged,
              exportChanged: exportChanged,
              productChanged: productChanged,
              add: add,
              delete: delete,
              labController: labController,
            );
          },
        ),
      ),
      ElevatedButton(
        onPressed: () {
          _showValuesDialog(context);
        },
        child: const Text('Confirm'),
      ),
    ])));
  }
}
