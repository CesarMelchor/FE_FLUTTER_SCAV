import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListAgrupacionesConScreen extends StatefulWidget {
  const ListAgrupacionesConScreen({super.key});

  @override
  State<ListAgrupacionesConScreen> createState() =>
      _ListAgrupacionesConScreenState();
}

class _ListAgrupacionesConScreenState extends State<ListAgrupacionesConScreen> {
  TextEditingController buscar = TextEditingController();

  Dio dio = Dio();

  Response listAgrupaciones = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());
  Response dataAgrupacion = Response(requestOptions: RequestOptions());

  Future apiGetAgrupaciones() async {
    listAgrupaciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/organizaciones');

    return listAgrupaciones.data;
  }

  Future apigetAgrupacion(id, BuildContext context) async {
    dataAgrupacion = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/organizacion/detail',
        queryParameters: {"organizacion": id});
    // ignore: use_build_context_synchronously
    _showData(context);

    return dataAgrupacion.data;
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/organizaciones/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listAgrupaciones.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  late final Future getAgrupaciones = apiGetAgrupaciones();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAgrupaciones,
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
                              controller: buscar,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (value) {
                                apiSearch(context);
                              },
                              decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        apiSearch(context);
                                      },
                                      child: const Icon(Icons.search)),
                                  focusColor: Colors.black,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12))),
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  floatingLabelStyle: TextStyle(
                                      color: Styles.rojo,
                                      fontWeight: FontWeight.bold),
                                  label: const Text(
                                      'FOLIO, NOMBRE O REPRESENTANTE')),
                            ),
                          ),
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
                                  fontSize: Adaptive.sp(11),
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(30),
                            child: Text(
                              "NOMBRE REPRESENTANTE",
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
                              "NOMBRE ORGANIZACION",
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
                              "CORREO",
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
                      for (var item in listAgrupaciones.data)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Adaptive.w(1)),
                          child: ExpansionTile(
                            trailing: IconButton(
                                onPressed: () async {
                                  await apigetAgrupacion(
                                      item['id_organizacion'], context);
                                },
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Styles.rojo,
                                )),
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
                                    width: Adaptive.w(30),
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
                                      item['nombre_organizacion'],
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
                                      item['correo'] ?? 'NA',
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(11),
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            ),
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

  _showData(BuildContext context) {
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              width: Adaptive.w(80),
              height: Adaptive.h(10),
              color: Styles.rojo,
              child: const Center(
                child: Text("INFORMACIÓN DE AGRUPACIÓN",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: Adaptive.w(80),
                height: Adaptive.h(65),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  SelectableText(
                                    'ID : ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Styles.rojo),
                                  ),
                                  SelectableText(
                                      dataAgrupacion.data['id_organizacion'] ??
                                          'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText(
                                    'NOMBRE REPRESENTANTE : ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SelectableText(
                                      dataAgrupacion.data['representante'] ??
                                          'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('NOMBRE ORGANIZACION : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(dataAgrupacion
                                          .data['nombre_organizacion'] ??
                                      'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            Container(
                              color: Styles.crema,
                              height: Adaptive.h(0.5),
                              width: Adaptive.w(35),
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  SelectableText('RFC : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Styles.rojo)),
                                  SelectableText(
                                      dataAgrupacion.data['rfc'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('CALLE : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['calle'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('NUM EXTERIOR : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['num_exterior'] ??
                                          'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('NUM INTERIOR : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['num_interior'] ??
                                          'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('CP : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['cp'] ?? 'NA')
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  SelectableText('REGION : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Styles.rojo)),
                                  SelectableText(
                                      dataAgrupacion.data['region'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('DISTRITO : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['distrito'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('MUNICIPIO : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['municipio'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('LOCALIDAD : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['localidad'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            Container(
                              color: Styles.crema,
                              height: Adaptive.h(0.5),
                              width: Adaptive.w(35),
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  SelectableText('TELEFONO FIJO : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Styles.rojo)),
                                  SelectableText(
                                      dataAgrupacion.data['tel_fijo'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('CELULAR : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['tel_celular'] ??
                                          'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('CORREO : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['correo'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('HOMBRES : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['hombres'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('MUJERES : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['mujeres'] ?? 'NA')
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                children: [
                                  const SelectableText('TIPO DE ORG : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SelectableText(
                                      dataAgrupacion.data['tipo_org'] ?? 'NA')
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Container(
                      color: Styles.crema,
                      height: Adaptive.h(0.5),
                      width: Adaptive.w(70),
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Container(
                      color: Styles.crema,
                      width: Adaptive.w(80),
                      height: Adaptive.h(15),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SelectableText('DESCRIPCION : ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SelectableText(dataAgrupacion.data['descripcion']),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                    child: const Text("Cerrar"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        },
        barrierColor: Colors.white70);
  }
}
