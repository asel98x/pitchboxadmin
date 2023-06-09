import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pitchboxadmin/backend/model/industry.dart';
import 'package:pitchboxadmin/backend/services/industryService.dart';
import 'package:pitchboxadmin/backend/utility/IndustryInterface.dart';


class IndustryController {
  final IndustryInterface _industryService = IndustryService();

  Future<void> addIndustry(String name, File? image, BuildContext context) async {
    try {
      // Upload the image to Firebase Storage and get its URL
      String imgUrl = '';
      if (image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('industry_images/${DateTime.now().millisecondsSinceEpoch}');
        final uploadTask = storageRef.putFile(image);
        final snapshot = await uploadTask.whenComplete(() {});
        imgUrl = await snapshot.ref.getDownloadURL();
      }

      // Create the Industry object
      final industry = Industry(
        id: '',
        name: name,
        imgUrl: imgUrl,
      );

      // Add the industry to Firebase Firestore
      _industryService.addIndustry(industry);

      // Go back to the previous screen
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Error adding industry: $e');
    }
  }


  Future<List<Industry>> getIndustries() async {
    return await _industryService.getIndustries();
  }

  Future<List<Industry>> getIndustry(String industryName) async {
    return await _industryService.getIndustry(industryName);
  }

  Future<void> updateIndustry(String id, String name, File? image,String imgUrl) async {
    try{
      if (image != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('industry_images/${DateTime.now().millisecondsSinceEpoch}');
        final uploadTask = storageRef.putFile(image);
        final snapshot = await uploadTask.whenComplete(() {});
        imgUrl = await snapshot.ref.getDownloadURL();

        Industry industry = Industry(
          id: id,
          name: name,
          imgUrl: imgUrl,
        );
        await _industryService.updateIndustry(industry);

      }else{
        Industry industry = Industry(
          id: id,
          name: name,
          imgUrl: imgUrl,
        );
        await _industryService.updateIndustry(industry);
      }
    }catch(e){
      debugPrint('Error updating industry: $e');
    }

  }

  Future<void> deleteIndustry(String industryId) async {
    await _industryService.deleteIndustry(industryId);
  }

  Future<List<String>> getIndustryNames() async {
    return await _industryService.getIndustryNames();
  }
}
