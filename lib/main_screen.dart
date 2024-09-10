
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:vrouter/vrouter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: Adaptive.w(50),
            height: Adaptive.h(100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adaptive.w(50),
                  height: Adaptive.h(80),
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/fondo_rojo.png"), fit: BoxFit.fitWidth)),
                  child: Column(children: [
                 Image.asset("assets/images/leyenda_instituto.png", width: Adaptive.w(30),),
                Text("REGISTRO ESTATAL DE ARTESANOS", 
                textAlign: TextAlign.center,
                style: TextStyle(
                  
                  color: Colors.white, 
                fontSize: Styles.titutlo1,
                fontWeight: FontWeight.bold,
                letterSpacing: 8),
                ),
                SizedBox(height: Adaptive.h(3),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(color: Colors.white,
                  width: Adaptive.w(10),height: Adaptive.h(.3),),
                  Image.asset("assets/images/pleca_x.png", width: Adaptive.w(2),),
                  Container(color: Colors.white,
                  width: Adaptive.w(10),height: Adaptive.h(.3),),

                ],),
                SizedBox(height: Adaptive.h(8),),
                
                InkWell(
                  onTap: () {
                    context.vRouter.to("/loginCredencial");
                  },
                  child: Container(
                    decoration: Styles().containerHome,
                    width: Adaptive.w(25),
                    height: Adaptive.h(7),
                    child: const Center(
                        child: Text("CREDENCIALIZACION",
                            textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                InkWell(
                  onTap: () {
                    context.vRouter.to("/loginCapacitacion");
                    },
                  child: Container(
                    decoration: Styles().containerHome,                    
                    width: Adaptive.w(25),
                    height: Adaptive.h(7),
                    child: const Center(
                        child: Text(
                      "CAPACITACION / APOYOS",
                      textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)
                    )),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: Styles().containerHome,
                    width: Adaptive.w(25),
                    height: Adaptive.h(7),
                    child: const Center(
                        child: Text("COMERCIALIZACION", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ),
                SizedBox(
                  height: Adaptive.h(2),
                ),
                InkWell(
                  onTap: () {
                    context.vRouter.to("/loginFerias");
                  },
                  child: Container(
                    decoration: Styles().containerHome,
                    width: Adaptive.w(25),
                    height: Adaptive.h(7),
                    child: const Center(
                        child: Text("CONCURSOS, FERIAS Y EXPOSICIONES",
                            textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                  ),
                ),
                  ],),
                  ),
               SizedBox(
                width: Adaptive.w(50),
                height: Adaptive.h(20),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Image.asset("assets/images/logo_artesanias.png", width: Adaptive.w(25),),
                   ],
                 ),
               )
              ],
            ),
          ),
          Column(
            children: [
            Image.asset("assets/images/portada_home.jpg", width: Adaptive.w(50), height: Adaptive.h(100),
            fit: BoxFit.fitHeight,)
          ],)
        ],
      ),
    );
  }
}


