import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab/widgets/product_type_view.dart';

import '../controllers/lab_controller.dart';
import '../models/product_type.dart';

class ProductWidget extends StatefulWidget {
  int index;
  List<String> productList;
  List<ProductType> productTypeList;
  Function(int productIndex,int productTypeIndex,int value) importChanged;
  Function(int productIndex,int productTypeIndex,int value) exportChanged;
  Function(int productIndex,String value) productChanged;
  Function() add;
  Function(int index) delete;
  LabController labController;


  ProductWidget(
      {super.key,
      required this.index,
      required this.productTypeList,
      required this.productList,
      required this.importChanged,
      required this.exportChanged,required this.productChanged,required this.add,required this.delete,required this.labController});

  @override
  State<StatefulWidget> createState() {
    return ProductWidgetState();
  }
}

class ProductWidgetState extends State<ProductWidget> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    debugPrint('Product Build lại:${widget.index}');
    dropdownValue = widget.productList.first;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.productChanged(widget.index,widget.productList.first);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.index.toString(),
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
              flex: 6,
              fit: FlexFit.loose,
              child: SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  value: dropdownValue,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                      widget.productChanged(widget.index,value);
                    });
                  },
                  items: widget.productList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              )),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            flex: 6,
            child: SizedBox(
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.productTypeList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ProductTypeWidget(
                      productIndex: widget.index,
                      productTypeIndex: index,
                      productType: widget.productTypeList[index],
                      importChanged: widget.importChanged,
                      exportChanged: widget.exportChanged,
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                //Add Button
                ElevatedButton(
                  onPressed: () {
                    widget.add();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size.fromRadius(17),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Icon(
                    Icons.add_circle_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //Delete Button
                ElevatedButton(
                  onPressed: () {
                    widget.delete(widget.index);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    minimumSize: const Size.fromRadius(17),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Icon(
                    Icons.remove_circle_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
