import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;
import 'package:petadoption/Model/PetModel.dart';



class PetProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get islOading {
    return _isLoading;
  }

  final bool _loadingSpinner = false;
  bool get loadingSpinner {
    return _loadingSpinner;
  }

  bool _isSelect = false;

  bool get isSelect {
    return _isSelect;
  }

  final bool _isError = false;

  bool get isError {
    return _isError;
  }

  List<PetDetails> _products = [];
  List<PetDetails> get products {
    return [..._products];
  }

  Future getAllPetData({required BuildContext context}) async {
    try {
      _isLoading = true;
      
      var response = await https.get(
        Uri.parse(
           "http://campus.sicsglobal.co.in/Project/PetAdoption_New/api/viewallpets.php",)
      );

      print(
          "http://campus.sicsglobal.co.in/Project/PetAdoption_New/api/viewallpets.php");

      print(response.body);

      if (response.statusCode == 200) {
        _isLoading = false;
        _products = [];
        var extractedData = json.decode(response.body);
        
        final List<dynamic> petDetails = extractedData['petDetails'];
        for (var i = 0; i < petDetails.length; i++) {
          _products.add(
           PetDetails(
              petid: petDetails[i]['petid'].toString(),
              name: petDetails[i]['name'].toString(),
               species: petDetails[i]['species'].toString(),
                breed: petDetails[i]['breed'].toString(),
                age: petDetails[i]['age'].toString(),
                  sex: petDetails[i]['sex'].toString(),
                  color: petDetails[i]['color'].toString(),
                  weight: petDetails[i]['weight'].toString(),
                 dob: petDetails[i]['dob'].toString(),
                 microchipid: petDetails[i]['microchipid'].toString(),
                 aid: petDetails[i]['aid'].toString(),
                 diet: petDetails[i]['diet'].toString(),
                 behaviour: petDetails[i]['behaviour'].toString(),
                 status: petDetails[i]['status'].toString(),
                 notes: petDetails[i]['notes'].toString(),
                 addeddate: petDetails[i]['addeddate'].toString(),
                 price: petDetails[i]['price'].toString(),
                 photo: petDetails[i]['photo'].toString(),

               
            
             
           

              
            ),
          );
        }
        ;

        print('product details' + _products.toString());
        _isLoading = false;
        print('products loading completed --->' + 'loading data');
        notifyListeners();
      } else {
        _isLoading = true;
        notifyListeners();
      }
    } on HttpException catch (e) {
      
      print('error in product prod -->>' + e.toString());
      print('Product Data is one by one loaded the product' + e.toString());
      _isLoading = false;

      _isSelect = false;
      notifyListeners();
    }
  }
 
}