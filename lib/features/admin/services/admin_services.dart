import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic("drokjxrhi", "jqd4sh1w");
      List<String> imagesUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imagesUrl.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        category: category,
        price: price,
        quantity: quantity,
        images: imagesUrl,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          "Content-Type": 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.user.token
        },
        body: product.toJson(),
      );
      print("Adding product the database");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product added successfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  //Get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context, { required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          "Content-Type": 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return productList;
  }

  //Delete Product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          "Content-Type": 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.user.token
        },
        body: jsonEncode({
          "id" : product.id,
        }),
      );
      print("Adding product the database");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
