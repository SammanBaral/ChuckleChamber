
import 'package:chuckle_chamber/models/product_model.dart';
import 'package:chuckle_chamber/repositories/product_repositories.dart';
import 'package:chuckle_chamber/services/firebase_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {

  FirebaseService.db = FakeFirebaseFirestore();
  ProductRepository repo = ProductRepository();
  test("add products", () async {
    var data  = ProductModel(
      categoryId: "1",
      productName: "sasa",
      id: "1",
      imagePath: "",
      imageUrl: "",
      userId: "1"
    );
    final res = await repo.addProducts(product: data);
    expect(res, false);
  });
}
