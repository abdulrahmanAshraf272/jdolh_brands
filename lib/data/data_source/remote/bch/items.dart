import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:jdolh_brands/api_links.dart';
import 'package:jdolh_brands/core/class/crud.dart';

class ItemsData {
  Crud crud;
  ItemsData(this.crud);

  addItems({
    required String bchid,
    required String categoriesid,
    required String resoptionsid,
    required String title,
    required String price,
    required String dicount,
    required String discountPercentage,
    required String desc,
    required String withOptions,
    required String duration,
    required String alwaysAvailable,
    required String satTime,
    required String sunTime,
    required String monTime,
    required String tuesTime,
    required String wedTime,
    required String thursTime,
    required String friTime,
    required String ioptionSelected,
    required File file,
  }) async {
    var response = await crud.postDataWithFile(
        ApiLinks.addItems,
        {
          "bchid": bchid,
          "categoriesid": categoriesid,
          "resoptionsid": resoptionsid,
          "title": title,
          "price": price,
          "dicount": dicount,
          "discountPercentage": discountPercentage,
          "desc": desc,
          "withOptions": withOptions,
          "duration": duration,
          "alwaysAvailable": alwaysAvailable,
          "satTime": satTime,
          "sunTime": sunTime,
          "monTime": monTime,
          "tuesTime": tuesTime,
          "wedTime": wedTime,
          "thursTime": thursTime,
          "friTime": friTime,
          "ioptionSelected": ioptionSelected
        },
        file,
        'file');

    return response.fold((l) => l, (r) => r);
  }

  addItemOption(
      {required String itemId,
      required String title,
      required String priceDep,
      required String isBasic,
      required String isMultiselect,
      required String elementsIds}) async {
    var response = await crud.postData(ApiLinks.addItemOption, {
      "itemId": itemId,
      "title": title,
      "priceDep": priceDep,
      "isBasic": isBasic,
      "isMultiselect": isMultiselect,
      "elementsIds": elementsIds,
    });

    return response.fold((l) => l, (r) => r);
  }

  addItemOptionElement({
    required String itemoptionid,
    required String name,
    required String price,
  }) async {
    var response = await crud.postData(ApiLinks.addItemOptionElement, {
      "itemoptionid": itemoptionid,
      "name": name,
      "price": price,
    });

    return response.fold((l) => l, (r) => r);
  }

  deleteItemOptionElement({
    required String elementId,
  }) async {
    var response = await crud.postData(ApiLinks.deleteItemOptionElement, {
      "elementId": elementId,
    });

    return response.fold((l) => l, (r) => r);
  }

  getItems({
    required String bchid,
  }) async {
    var response = await crud.postData(ApiLinks.getItems, {
      "bchid": bchid,
    });

    return response.fold((l) => l, (r) => r);
  }

  getItemDetails(
      {required String resoptionIds,
      required String itemOptionsIds,
      required String categoryId}) async {
    var response = await crud.postData(ApiLinks.getItemDetails, {
      "resoptionIds": resoptionIds,
      "itemOptionsIds": itemOptionsIds,
      "categoryId": categoryId
    });

    return response.fold((l) => l, (r) => r);
  }

  getSelectedItemOptions({
    required String itemId,
  }) async {
    var response = await crud.postData(ApiLinks.getSelectedItemOptions, {
      "itemId": itemId,
    });

    return response.fold((l) => l, (r) => r);
  }

  getOptionElements({
    required String itemoptionid,
  }) async {
    var response = await crud.postData(ApiLinks.getOptionElements, {
      "itemoptionid": itemoptionid,
    });

    return response.fold((l) => l, (r) => r);
  }

  editItemOption(
      {required String itemoptionid,
      required String title,
      required String priceDep,
      required String isBasic,
      required String isMultiselect}) async {
    var response = await crud.postData(ApiLinks.editItemOption, {
      "itemoptionid": itemoptionid,
      "title": title,
      "priceDep": priceDep,
      "isBasic": isBasic,
      "isMultiselect": isMultiselect
    });

    return response.fold((l) => l, (r) => r);
  }

  editItem({
    required String itemId,
    required String resoptionsid,
    required String categoriesid,
    required String title,
    required String price,
    required String dicount,
    required String discountPercentage,
    required String desc,
    required String withOptions,
    required String duration,
    required String alwaysAvailable,
    required String satTime,
    required String sunTime,
    required String monTime,
    required String tuesTime,
    required String wedTime,
    required String thursTime,
    required String friTime,
  }) async {
    var response = await crud.postData(ApiLinks.editItem, {
      "itemId": itemId,
      "resoptionsid": resoptionsid,
      "categoriesid": categoriesid,
      "title": title,
      "price": price,
      "dicount": dicount,
      "discountPercentage": discountPercentage,
      "desc": desc,
      "withOptions": withOptions,
      "duration": duration,
      "alwaysAvailable": alwaysAvailable,
      "satTime": satTime,
      "sunTime": sunTime,
      "monTime": monTime,
      "tuesTime": tuesTime,
      "wedTime": wedTime,
      "thursTime": thursTime,
      "friTime": friTime,
    });

    return response.fold((l) => l, (r) => r);
  }

  editItemImage({required String itemId, required File file}) async {
    var response = await crud.postDataWithFile(
        ApiLinks.editItemImage,
        {
          "itemId": itemId,
        },
        file,
        'file');

    return response.fold((l) => l, (r) => r);
  }
}
