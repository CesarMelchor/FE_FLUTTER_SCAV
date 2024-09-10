import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/styles.dart';

class ListTalleresScreen extends StatefulWidget {
  const ListTalleresScreen({super.key});

  @override
  State<ListTalleresScreen> createState() => _ListTalleresScreenState();
}

class _ListTalleresScreenState extends State<ListTalleresScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController detailBaja = TextEditingController();

  String credencial = 'NO';
  String baja = 'NO';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: Adaptive.h(1),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Adaptive.w(2),
                ),
                SizedBox(
                  width: Adaptive.w(35),
                  child: TextFormField(
                    controller: buscar,
                    inputFormatters: [
                      CapitalLetters(),
                    ],
                    onChanged: (value) {},
                    decoration: Styles()
                        .inputStyleSearch("BUSCAR", const Icon(Icons.search)),
                  ),
                ),
                Expanded(child: Container()),
                ElevatedButton.icon(
                    icon: const Icon(Icons.diversity_2),
                    style: Styles.buttonAddArtesano,
                    onPressed: () {
                      Navigator.of(context).pushNamed("addTaller");
                    },
                    label: Text(
                      "AGREGAR TALLER",
                      style: TextStyle(fontSize: Adaptive.sp(11)),
                    )),
              ],
            ),
          ],
        ),
        SizedBox(
          height: Adaptive.h(3),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(2)),
          child: Row(
            children: [
              SizedBox(
                  width: Adaptive.w(20),
                  child: Text(
                    "NOMBRE",
                    style: TextStyle(
                        color: Styles.crema2,
                        fontSize: Adaptive.sp(12),
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                width: Adaptive.w(1),
              ),
              SizedBox(
                  width: Adaptive.w(25),
                  child: Text(
                    "REPRESENTANTE",
                    style: TextStyle(
                        color: Styles.crema2,
                        fontSize: Adaptive.sp(12),
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                width: Adaptive.w(1),
              ),
              SizedBox(
                  width: Adaptive.w(25),
                  child: Text(
                    "DESCRIPCION",
                    style: TextStyle(
                        color: Styles.crema2,
                        fontSize: Adaptive.sp(12),
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                width: Adaptive.w(1),
              ),
              SizedBox(
                  width: Adaptive.w(15),
                  child: Text(
                    "REGION",
                    style: TextStyle(
                        color: Styles.crema2,
                        fontSize: Adaptive.sp(12),
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: Adaptive.h(2),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Adaptive.w(1)),
          child: ExpansionTile(
            title: Row(
              children: [
                SizedBox(
                    width: Adaptive.w(20),
                    child: Text(
                      "NOMBRE DE TALLER",
                      style: TextStyle(
                          color: Styles.crema2,
                          fontSize: Adaptive.sp(12),
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  width: Adaptive.w(1),
                ),
                SizedBox(
                    width: Adaptive.w(25),
                    child: Text(
                      "CESAR MELCHOR GARCIA",
                      style: TextStyle(
                          color: Styles.crema2,
                          fontSize: Adaptive.sp(12),
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  width: Adaptive.w(1),
                ),
                SizedBox(
                    width: Adaptive.w(25),
                    child: Text(
                      "DESCRIPCION DE UN TALLER",
                      style: TextStyle(
                          color: Styles.crema2,
                          fontSize: Adaptive.sp(12),
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  width: Adaptive.w(1),
                ),
                SizedBox(
                    width: Adaptive.w(15),
                    child: Text(
                      "VALLES CENTRALES",
                      style: TextStyle(
                          color: Styles.crema2,
                          fontSize: Adaptive.sp(12),
                          fontWeight: FontWeight.w500),
                    )),
              ],
            ),
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Adaptive.h(3),
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                          style: Styles.buttonViewEditArt,
                          onPressed: () {
                            Navigator.of(context).pushNamed("viewEditTaller");
                          },
                          icon: const Icon(Icons.edit),
                          label: Text(
                            "VER Y EDITAR INFORMACION",
                            style: TextStyle(fontSize: Adaptive.sp(11)),
                          )),
                      SizedBox(
                        width: Adaptive.w(2),
                      ),
                      ElevatedButton.icon(
                          onPressed: () {},
                          style: Styles.buttonViewEditArt,
                          icon: const Icon(Icons.badge),
                          label: Text("GENERAR CREDENCIAL",
                              style: TextStyle(fontSize: Adaptive.sp(11)))),
                      SizedBox(
                        width: Adaptive.w(2),
                      ),
                      Text("ENTREGA CREDENCIAL",
                          style: TextStyle(
                              fontSize: Adaptive.sp(12),
                              color: Styles.crema2,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: Adaptive.w(.2),
                      ),
                      Radio(
                        value: 'SI',
                        groupValue: credencial,
                        activeColor: Styles.rojo,
                        onChanged: (val) {
                          setState(() {
                            credencial = 'SI';
                          });
                        },
                      ),
                      Text("SI", style: TextStyle(fontSize: Adaptive.sp(11))),
                      Radio(
                        value: 'NO',
                        groupValue: credencial,
                        activeColor: Styles.rojo,
                        onChanged: (val) {
                          setState(() {
                            credencial = 'NO';
                          });
                        },
                      ),
                      Text("NO", style: TextStyle(fontSize: Adaptive.sp(11))),
                      SizedBox(
                        width: Adaptive.w(2),
                      ),
                      Text("DAR DE BAJA",
                          style: TextStyle(
                              fontSize: Adaptive.sp(12),
                              color: Styles.crema2,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: Adaptive.w(.2),
                      ),
                      Radio(
                        value: 'SI',
                        groupValue: baja,
                        activeColor: Styles.rojo,
                        onChanged: (val) {
                          setState(() {
                            baja = 'SI';
                          });
                        },
                      ),
                      Text("SI", style: TextStyle(fontSize: Adaptive.sp(11))),
                      Radio(
                        value: 'NO',
                        groupValue: baja,
                        activeColor: Styles.rojo,
                        onChanged: (val) {
                          setState(() {
                            baja = 'NO';
                          });
                        },
                      ),
                      Text("NO", style: TextStyle(fontSize: Adaptive.sp(11))),
                      SizedBox(
                        width: Adaptive.w(1),
                      ),
                      SizedBox(
                        width: Adaptive.w(27),
                        child: TextFormField(
                          enabled: baja == 'SI' ? true : false,
                          controller: detailBaja,
                          inputFormatters: [
                            CapitalLetters(),
                          ],
                          onChanged: (value) {},
                          decoration:
                              Styles().inputStyleArtesano("MOTIVO DE BAJA"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Adaptive.h(2),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
