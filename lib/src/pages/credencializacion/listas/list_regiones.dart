import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListRegionesPage extends StatefulWidget {
  const ListRegionesPage({super.key});

  @override
  State<ListRegionesPage> createState() => _ListRegionesPageState();
}

class _ListRegionesPageState extends State<ListRegionesPage> {
  TextEditingController buscar = TextEditingController();
  TextEditingController region = TextEditingController();

  Dio dio = Dio();

  String idUpdate = "";

  TextEditingController controller = TextEditingController();

  Response listRegiones = Response(requestOptions: RequestOptions());
  Response newListRegiones = Response(requestOptions: RequestOptions());
  Response regionUpdate = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());

  Future apiGetRegiones() async {
    listRegiones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/regiones');

    return listRegiones.data;
  }

  Future<bool> apiUpdateRegion(id, BuildContext context) async {
    regionUpdate = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/region/update/$id', data: {
      "region": region.text,
    });
    if (regionUpdate.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future apiGetRegionesAfterAddOrModify() async {
    newListRegiones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/regiones');
    if (newListRegiones.statusCode == 200) {
      setState(() {
        listRegiones.data = newListRegiones.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/regiones/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listRegiones.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  late final Future getRegiones = apiGetRegiones();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRegiones,
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
                          ElevatedButton.icon(
                              icon: const Icon(Icons.settings),
                              style: Styles.buttonListArtesano,
                              onPressed: () {
                                Navigator.of(context).pushNamed("herramientas");
                              },
                              label: Text(
                                "HERRAMIENTAS",
                                style: TextStyle(fontSize: Adaptive.sp(11)),
                              )),
                          Expanded(child: Container()),
                          SizedBox(
                            width: Adaptive.w(3),
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
                              onFieldSubmitted: (value) {
                                apiSearch(context);
                              },
                              onChanged: (value) {},
                              decoration: Styles().inputStyleSearch(
                                  "BUSCAR", const Icon(Icons.search)),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Adaptive.w(5)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Adaptive.w(7),
                            ),
                            Text(
                              "EDITAR REGION",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(15),
                                  color: Styles.rojo),
                            ),
                            SizedBox(
                              width: Adaptive.w(20),
                            ),
                            Text(
                              "ID",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(14),
                                  color: Styles.rojo),
                            ),
                            SizedBox(
                              width: Adaptive.w(25),
                            ),
                            Text(
                              "REGION",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(14),
                                  color: Styles.rojo),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Adaptive.h(1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Adaptive.w(2)),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Adaptive.w(35),
                              child: TextFormField(
                                controller: region,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyleArtesano("REGION"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(10),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  OutlinedButton(
                                      onPressed: () async {
                                        if (idUpdate != "") {
                                          if (await apiUpdateRegion(
                                              idUpdate, context)) {
                                            apiGetRegionesAfterAddOrModify();
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.green,
                                                Icons.done,
                                                'Región actualizada',
                                                context);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.red,
                                                Icons.error,
                                                'Error, inténtalo de nuevo',
                                                context);
                                          }
                                        } else {
                                          // ignore: use_build_context_synchronously
                                          Message().mensaje(
                                              Colors.red,
                                              Icons.error,
                                              'Selecciona un municipio antes',
                                              context);
                                        }
                                      },
                                      child: const Text("ACTUALIZAR")),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: Adaptive.w(2),
                        ),
                        SizedBox(
                          width: Adaptive.w(50),
                          height: Adaptive.h(50),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                for (var item in listRegiones.data)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        idUpdate = item['id_region'];
                                        region.text = item['region'];
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: Adaptive.h(3),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: Adaptive.w(25),
                                                child: Text(
                                                  item['id_region'],
                                                  style: TextStyle(
                                                      fontSize: Adaptive.sp(11),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                            SizedBox(
                                              width: Adaptive.w(1),
                                            ),
                                            SizedBox(
                                                width: Adaptive.w(20),
                                                child: Text(
                                                  item['region'],
                                                  style: TextStyle(
                                                      fontSize: Adaptive.sp(11),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Adaptive.h(2),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Image.asset("assets/images/cargando.gif");
      },
    );
  }
}
