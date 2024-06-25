import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab/widgets/text_field.dart';
import '../controllers/lab_controller.dart';
import '../models/product_type.dart';

class ProductTypeWidget extends StatefulWidget {
  int productIndex;
  int productTypeIndex;
  ProductType productType;
  Function(int productIndex,int productTypeIndex,int value) importChanged;
  Function(int productIndex,int productTypeIndex,int value) exportChanged;


  ProductTypeWidget(
      {super.key,
      required this.productType,
        required this.importChanged,
        required this.exportChanged,
      required this.productIndex,
      required this.productTypeIndex});

  @override
  State<StatefulWidget> createState() {
    return ProductTypeWidgetState();
  }
}

class ProductTypeWidgetState extends State<ProductTypeWidget> {
  void _importChanged(int value) {
    widget.importChanged(widget.productIndex,widget.productTypeIndex,value);
  }

  void _exportChanged(int value) {
    widget.exportChanged(widget.productIndex,widget.productTypeIndex,value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          widget.productTypeIndex.toString(),
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          width: 10,
        ),
        //Index
        Flexible(
          flex: 5,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              widget.productType.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),

        //Import and export
        Flexible(
          flex: 2,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                    height: 50,
                    width: 50,
                    child: MyTextField(
                        inputChanged: _importChanged, isNumber: true)),
                SizedBox(
                    height: 50,
                    width: 50,
                    child: MyTextField(
                        inputChanged: _exportChanged, isNumber: true)),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
