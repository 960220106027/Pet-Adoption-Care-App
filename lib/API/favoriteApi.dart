   import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;
import 'package:petadoption/Model/CategoryModel.dart';
import 'package:petadoption/Model/FavoriteModel.dart';
import 'package:petadoption/Model/PetModel.dart';



class FavoriteProvider with ChangeNotifier {
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

  List<FavoriteDetails> _products = [];
  List<FavoriteDetails> get products {
    return [..._products];
  }

  Future getAllFavouriteData({required BuildContext context}) async {
    try {
      _isLoading = true;
      
      var response = await https.get(
        Uri.parse(
           "http://campus.sicsglobal.co.in/Project//PetAdoption_New/api/viewfavpets.php?aid=1&petid=3",)
      );

      print(
          "http://campus.sicsglobal.co.in/Project//PetAdoption_New/api/viewfavpets.php?aid=1&petid=3");

      print(response.body);

      if (response.statusCode == 200) {
        _isLoading = false;
        _products = [];
        var extractedData = json.decode(response.body);
        
        final List<dynamic> favourites = extractedData['petDetails'];
        for (var i = 0; i < favourites.length; i++) {
          _products.add(
           FavoriteDetails(
            favId: favourites[i]['fav_id'].toString(),
              petid: favourites[i]['id'].toString(),
              name: favourites[i]['name'].toString(),
              species: favourites[i]['species'].toString(),
              breed: favourites[i]['breed'].toString(),
              age: favourites[i]['age'].toString(),
              weight: favourites[i]['weight'].toString(),
              dob: favourites[i]['dob'].toString(),
              microchipid: favourites[i]['microchipid'].toString(),
              sex: favourites[i]['sex'].toString(),
              color: favourites[i]['color'].toString(),
              aid: favourites[i]['aid'].toString(),
              diet: favourites[i]['diet'].toString(),
              behaviour: favourites[i]['behaviour'].toString(),
              status: favourites[i]['status'].toString(),
              notes: favourites[i]['notes'].toString(),
              addeddate: favourites[i]['addeddate'].toString(),
              photo: favourites[i]['photo'].toString(),
                

               
            
             
           

              
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
            
