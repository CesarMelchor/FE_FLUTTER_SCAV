import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/data/offline.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class OrganizacionesOfflineScreen extends StatefulWidget {
  const OrganizacionesOfflineScreen({super.key});

  @override
  State<OrganizacionesOfflineScreen> createState() =>
      _OrganizacionesOfflineScreenState();
}

class _OrganizacionesOfflineScreenState
    extends State<OrganizacionesOfflineScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController detailBaja = TextEditingController();

  String credencial = 'NO';
  String baja = 'NO';

  Dio dio = Dio();

  List organizaciones = [];

  Future apiGetOrganizaciones() async {
    organizaciones = Offline.organizacionesList;

    return organizaciones;
  }

  @override
  void initState() {
    super.initState();
    apiGetOrganizaciones();
  }

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
                          Expanded(child: Container()),
                          ElevatedButton.icon(
                              icon: const Icon(Icons.format_list_bulleted),
                              style: Styles.buttonAddArtesano,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("listArtesanos");
                              },
                              label: Text(
                                "PERSONAS ARTESANAS",
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
                              "FOLIO",
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
                  Column(
                    children: [
                      for (var item in organizaciones)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Adaptive.w(1)),
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                SizedBox(
                                    width: Adaptive.w(20),
                                    child: Text(
                                      item['id_organizacion'],
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
                                      item['nombre_organizacion'],
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
                                      item['representante'],
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
                                      item['id_region'] ?? 'No definido',
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
                                            setState(() {
                                              GlobalVariable
                                                      .idOrganizacionEditCred =
                                                  item['id_organizacion'];
                                            });
                                            Navigator.of(context).pushNamed(
                                                "viewEditOrganizacion");
                                          },
                                          icon: const Icon(Icons.edit),
                                          label: Text(
                                            "VER Y EDITAR INFORMACION",
                                            style: TextStyle(
                                                fontSize: Adaptive.sp(11)),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(2),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                    ],
                  )
                ],
              
    );
  }
}
