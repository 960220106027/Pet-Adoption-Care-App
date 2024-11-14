import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:petadoption/API/CategoryApi.dart';
import 'package:petadoption/API/CategoryDetailApi.dart';
import 'package:petadoption/API/PetshopApi.dart';

import 'package:petadoption/Screens/ProfileScreen/profile%20screen.dart';

import 'package:petadoption/Screens/homeScreen/colors.dart';
import 'package:petadoption/Widget/PetWidget.dart';
import 'package:petadoption/Widget/categorylistWidget.dart';
import 'package:provider/provider.dart';


class HomeScreen1 extends StatefulWidget {
  static const routename='all_pets_screen';
  static const routeename='all_categories_screen';
  static const routesname='all_categoriesdetail_screen';

  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
   @override
  void initState() {
    Provider.of<PetProvider>(context, listen: false)
        .getAllPetData(context: context);
  
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pet=Provider.of<PetProvider>(context);
    final category=Provider.of<CategoryProvider>(context);
    final detailcategory = Provider.of<CategoryDetailProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
        
       
        title: Text(
          "Pets Adoption & care",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/female.png"),
            ),
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: pinkish.withOpacity(0.8),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              
                decoration: BoxDecoration(color: pink.withOpacity(0.8),),
                accountName: Text("Anusha",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                accountEmail: Text("anusha@gmail.com",style: TextStyle(color: Colors.black,fontSize: 18,),),
                currentAccountPicture: CircleAvatar(radius: 60,backgroundImage: AssetImage("assets/female.png"),),
                
                ),
                ListTile(
               leading: IconButton(onPressed: () {
                 
               }, icon: Icon(Icons.pets),),
               title: Text("My Adoptions"),
                
              ),
              ListTile(
               leading: IconButton(onPressed: () {
                 
               }, icon: Icon(Icons.chat),),
               title: Text("FA&Q"),
                
              ),
               ListTile(
               leading: IconButton(onPressed: () {
                 
               }, icon: Icon(Icons.logout,color: Colors.red,),),
               title: Text("Logout",style: TextStyle(color: Colors.red),),
                
              ),
          ],
          
        ),
        
        
      ),
      backgroundColor: pinkish,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               TextFormField(
           decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90),
                      ),
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(90)),
                      hintText: "Search",
                      prefixIconColor: Colors.black,
                      hintStyle: TextStyle(color: Colors.black)),
        ),
              Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                
                height: size.height*0.12,
                
                child: ListView.builder(
                 
                  itemCount: category.products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ListCategoryWidget( id: category.products[index].id,
                        name: category.products[index].name,
                        photo: category.products[index].photo,);
                  },
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text("All Pets", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: size.height * 0.02),
               pet.loadingSpinner
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Loading'),
                          CircularProgressIndicator(
                            color:Colors.black,
                          ),
                          const SizedBox(

                            width: 10,
                          ),
                       
                        ],
                      )
                    : pet.products.isEmpty
                        ? Text('No Pets...')
                        : SizedBox(

                          height: size.height * 0.9,
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              mainAxisSpacing: 15,crossAxisSpacing: 15),
                              scrollDirection: Axis.vertical,
                              
                              
                              itemCount: pet.products.length,
                              itemBuilder: (context, intex) {
                                return PetWidget(
                                  id: pet.products[intex].petid,
                                  name: pet.products[intex].name,
                                  photo: pet.products[intex].photo,
                                  
                             
                             
                                 
                                
                                );
                              },
                            ),
                          ),]
      )    
              
              
             
            
        
          ),
      
        ),
      );
    
  }
}