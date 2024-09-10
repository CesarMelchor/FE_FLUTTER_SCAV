import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/styles.dart';

class HerramientasPage extends StatefulWidget {
  const HerramientasPage({super.key});

  @override
  State<HerramientasPage> createState() => _HerramientasPageState();
}

class _HerramientasPageState extends State<HerramientasPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        
        InkWell(
          onTap: () {
                                Navigator.of(context).pushNamed("usuarios");
          },
          child: Container(
            width: Adaptive.w(30),
            height: Adaptive.h(20),
            decoration: Styles().containerToolsCred,
            child: Center(child: Text("USUARIOS", 
            style: TextStyle(fontSize: Adaptive.sp(14), color: Colors.white),)),),
        ),
        
        InkWell(
          onTap: () {
            
                                Navigator.of(context).pushNamed("municipios");
          },
          child: Container(
            width: Adaptive.w(30),
            height: Adaptive.h(20),
            decoration: Styles().containerToolsCred,
            child: Center(child: Text("MUNICIPIOS", 
            style: TextStyle(fontSize: Adaptive.sp(14), color: Colors.white),)),),
        ),
      ],),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        
        
     InkWell(
          onTap: () {
                                Navigator.of(context).pushNamed("regiones");
          },
          child: Container(
            width: Adaptive.w(30),
            height: Adaptive.h(20),
            decoration: Styles().containerToolsCred,
            child: Center(child: Text("REGIONES", 
            style: TextStyle(fontSize: Adaptive.sp(14), color: Colors.white),)),),
        ),
       
        InkWell(
          onTap: () {
            
                                Navigator.of(context).pushNamed("localidades");
          },
          child: Container(
            width: Adaptive.w(30),
            height: Adaptive.h(20),
            decoration: Styles().containerToolsCred,
            child: Center(child: Text("LOCALIDADES", 
            style: TextStyle(fontSize: Adaptive.sp(14), color: Colors.white),)),),
        ),
        
       InkWell(
          onTap: () {
            
                                Navigator.of(context).pushNamed("distritos");
          },
          child: Container(
            width: Adaptive.w(30),
            height: Adaptive.h(20),
            decoration: Styles().containerToolsCred,
            child: Center(child: Text("DISTRITOS", 
            style: TextStyle(fontSize: Adaptive.sp(14), color: Colors.white),)),),
        ),
      ],)
    ],);
  }
}