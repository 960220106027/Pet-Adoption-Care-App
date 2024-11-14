import 'package:flutter/material.dart';
import 'package:petadoption/Screens/PetDetailScreen/Detailscreen.dart';
import 'package:petadoption/Screens/homeScreen/colors.dart';

class PetWidget extends StatefulWidget {
  final String id;
  final String name;
  final String photo;
  const PetWidget({super.key,required this.name,required this.photo,required this.id});

  @override
  State<PetWidget> createState() => _PetWidgetState();
}

class _PetWidgetState extends State<PetWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailPage(id: widget.id,)));
      },
      child: Card(
        elevation: 5,
        color: pink,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height:size.height*0.18,
                width:size.width*0.42,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.photo,),fit: BoxFit.cover),borderRadius: BorderRadius.circular(10)),
              ),
              SizedBox(height:size.height*0.01,),
              Text(widget.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
               SizedBox(height:size.height*0.01,),
              Row(
                children: [
                  IconButton(onPressed: (){}, icon:Icon(Icons.favorite,size: 30,color: Colors.white,)),
                  ElevatedButton(
                    
                    style: ElevatedButton.styleFrom(backgroundColor:pinkish,),
                    onPressed: (){}, child:Text('Buy Now',style: TextStyle(color:pink,fontWeight: FontWeight.bold,fontSize: 16),),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}