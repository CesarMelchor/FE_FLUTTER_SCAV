import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListOrganizacionesScreen extends StatefulWidget {
  const ListOrganizacionesScreen({super.key});

  @override
  State<ListOrganizacionesScreen> createState() =>
      _ListOrganizacionesScreenState();
}

class _ListOrganizacionesScreenState extends State<ListOrganizacionesScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController detailBaja = TextEditingController();

  String credencial = 'NO';
  String baja = 'NO';

  Dio dio = Dio();

  Response listOrganizaciones = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());

  Future apiGetOrganizaciones() async {
    listOrganizaciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/agrupacionesAll');

    return listOrganizaciones.data;
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/organizaciones/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listOrganizaciones.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  late final Future getOrganizaciones = apiGetOrganizaciones();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOrganizaciones,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ListView(
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
                            height: Adaptive.h(5),
                            child: TextFormField(
                              cursorWidth: 2,
                              cursorHeight: 15,
                              style: TextStyle(
                                fontSize: Adaptive.sp(11),
                              ),
                              controller: buscar,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onFieldSubmitted: (value) {
                                apiSearch(context);
                              },
                              onChanged: (value) {},
                              decoration: Styles().inputStyleSearch(
                                  "NOMBRE O REPRESENTANTE",
                                  const Icon(Icons.search)),
                            ),
                          ),
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
                    height: Adaptive.h(2),
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
                                  fontSize: Adaptive.sp(11),
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
                                  fontSize: Adaptive.sp(11),
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
                                  fontSize: Adaptive.sp(11),
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
                                  fontSize: Adaptive.sp(11),
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
                      for (var item in listOrganizaciones.data)
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
                                          fontSize: Adaptive.sp(11),
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
                                          fontSize: Adaptive.sp(11),
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
                                          fontSize: Adaptive.sp(11),
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(
                                  width: Adaptive.w(1),
                                ),
                                SizedBox(
                                    width: Adaptive.w(15),
                                    child: Text(
                                      item['region'] ?? 'No definido',
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(11),
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            ),
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Adaptive.w(2),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: '',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Alta: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['created_at']}   ->   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: 'Distrito: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['distrito']}   ->   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: 'Municipio: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['municipio']}   ->   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: 'Localidad: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text: "${item['localidad']}",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(1),
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
              )
            : Image.asset("assets/images/cargando.gif");
      },
    );
  }
}
