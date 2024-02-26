import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository {
  CollectionReference<CategoryModel> categoryRef =
      FirebaseService.db.collection("categories").withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) {
              return CategoryModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );
  Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if (!hasData) {
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>> getCategory(String categoryId) async {
    try {
      print(categoryId);
      final response = await categoryRef.doc(categoryId).get();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  List<CategoryModel> makeCategory() {
    return [
      CategoryModel(
          categoryName: "Cat Memes",
          status: "active",
          imageUrl:"https://i.kym-cdn.com/entries/icons/original/000/026/489/crying.jpg"),
      CategoryModel(
          categoryName: "Hollywood Memes",
          status: "active",
          imageUrl:"https://scontent.fktm3-1.fna.fbcdn.net/v/t39.30808-6/295385506_184525597275402_8176385018274536193_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=783fdb&_nc_ohc=0PasndCR5OkAX_5CgMx&_nc_ht=scontent.fktm3-1.fna&oh=00_AfAj0U2B0qO7yLPD8Mnt0X6XNBqbpDPMuAlUZbda4UO21Q&oe=65E26448"),
      CategoryModel(
          categoryName: "Florida Memes",
          status: "active",
          imageUrl:"https://scontent.fktm3-1.fna.fbcdn.net/v/t39.30808-6/304950637_424356499685804_7234999871514278489_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=b3pYExtw28YAX9RVzq0&_nc_ht=scontent.fktm3-1.fna&oh=00_AfDzaF1GuLPdYtQy-deu8A_JFbUh-F2YcCZzW0Jd4KEYuw&oe=65E26D97"),
      CategoryModel(
          categoryName: "Relatable Memes",
          status: "active",
          imageUrl:"https://cdn.memes.com/up/84091731666882333/i/1666970808113.png"),
    ];
  }
}
