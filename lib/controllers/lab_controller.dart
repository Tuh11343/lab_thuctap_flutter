import 'package:flutter/cupertino.dart';
import 'package:lab/models/product.dart';

import '../models/product_type.dart';

class LabController{
  List<String> productChooseList = [];
  List<List<ProductType>> productTypeList = [];

  void init() {}

  void add(Product product) {
    try {
      productChooseList.add(product.name);
      productTypeList.add(product.productTypeList);
    } catch (e) {
      debugPrint('Exception from add:${e}');
    }
  }

  void delete(int index) {
    try {
      productChooseList.removeAt(index);
      productTypeList.removeAt(index);
    } catch (e) {
      debugPrint('Exception from delete:${e}');
    }
  }

  void setProductChoose(int productIndex, String value) {
    try {
      productChooseList[productIndex] = value;
    } catch (e) {
      debugPrint('Error from get values:${e}');
    }
  }

  void importChanged(int productIndex, int productTypeIndex, int value) {
    try {
      productTypeList[productIndex][productTypeIndex].inputList[0] = value;
    } catch (e) {
      debugPrint('Error from get values:${e}');
    }
  }

  void exportChanged(int productIndex, int productTypeIndex, int value) {
    try {
      productTypeList[productIndex][productTypeIndex].inputList[1] = value;
    } catch (e) {
      debugPrint('Error from get values:${e}');
    }
  }

  List<Product> getValues() {
    try {
      List<Product> resultList = [];
      for (int i = 0; i < productChooseList.length; i++) {
        List<ProductType> productTypeResultList = [];
        for (int j = 0; j < productTypeList[i].length; j++) {
          productTypeResultList.add(ProductType(
              name: productTypeList[i][j].name,
              inputList: productTypeList[i][j].inputList));
        }
        resultList.add(Product(
            name: productChooseList[i],
            productTypeList: productTypeResultList));
      }

      return resultList;
    } catch (e) {
      debugPrint('Error from get values:${e}');
      return List.empty();
    }
  }
}
