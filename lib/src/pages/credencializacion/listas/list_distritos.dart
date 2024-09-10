import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:custom_dropdown_2/custom_dropdown2.dart';

class ListDistritosPage extends StatefulWidget {
  const ListDistritosPage({super.key});

  @override
  State<ListDistritosPage> createState() => _ListDistritosPageState();
}

class _ListDistritosPageState extends State<ListDistritosPage> {
  TextEditingController buscar = TextEditingController();
  TextEditingController distrito = TextEditingController();
  TextEditingController region = TextEditingController();

  Dio dio = Dio();

  String idUpdate = "";
  String regionSelected = "";
  String idregionSelected = "";
  String iddistritoSelected = "";

  TextEditingController controller = TextEditingController();

  Response listDistritos = Response(requestOptions: RequestOptions());
  Response listRegiones = Response(requestOptions: RequestOptions());
  Response regionUpdate = Response(requestOptions: RequestOptions());
  Response newListDistritos = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());

  Future apiGetDistritos() async {
    apiGetRegiones();

    listDistritos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/distritos');

    return listDistritos.data;
  }

  void elementSelected(region) {
    for (var i = 0; i < listRegiones.data.length; i++) {
      if (listRegiones.data[i]['id_region'] == region) {
        setState(() {
          regionSelected = listRegiones.data[i]['region'];
          idregionSelected = listRegiones.data[i]['id_region'];

          controller.text = listRegiones.data[i]['region'];
        });
      }
    }
  }

  void regSelected(region) {
    for (var i = 0; i < listRegiones.data.length; i++) {
      if (listRegiones.data[i]['region'] == region) {
        setState(() {
          regionSelected = listRegiones.data[i]['region'];
          idregionSelected = listRegiones.data[i]['id_region'];

          controller.text = listRegiones.data[i]['region'];
        });
      }
    }
  }

  Future apiGetRegiones() async {
    listRegiones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/regiones');

    return listRegiones.data;
  }

  Future<bool> apiUpdateDistrito(id, BuildContext context) async {
    regionUpdate = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/distrito/update/$id',
        data: {"distrito": distrito.text, "id_municipio": idregionSelected});
    if (regionUpdate.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future apiGetDistritosAfterAddOrModify() async {
    newListDistritos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/distritos');
    if (newListDistritos.statusCode == 200) {
      setState(() {
        listDistritos.data = newListDistritos.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/distritos/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listDistritos.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  late final Future getDistritos = apiGetDistritos();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDistritos,
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
                              "EDITAR DISTRITO",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(15),
                                  color: Styles.rojo),
                            ),
                            SizedBox(
                              width: Adaptive.w(19),
                            ),
                            Text(
                              "DISTRITO",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(14),
                                  color: Styles.rojo),
                            ),
                            SizedBox(
                              width: Adaptive.w(20),
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
                              width: Adaptive.w(40),
                              child: TextFormField(
                                controller: distrito,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyleArtesano("DISTRITO"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            SizedBox(
                                width: Adaptive.w(40),
                                child: CustomDropDownII.search(
                                  controller: controller,
                                  hintText: 'REGION',
                                  selectedStyle: TextStyle(color: Styles.rojo),
                                  errorText: 'Sin resultados',
                                  onChanged: (p0) {
                                    regSelected(p0);
                                  },
                                  borderSide: BorderSide(color: Styles.rojo),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  items: [
                                    for (var item in listRegiones.data)
                                      item['region']
                                  ],
                                )),
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
                                        if (idregionSelected != "") {
                                          if (await apiUpdateDistrito(
                                              idUpdate, context)) {
                                            apiGetDistritosAfterAddOrModify();
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.green,
                                                Icons.done,
                                                'Distrito actualizado',
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
                                              'Selecciona un distrito antes',
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
                                for (var item in listDistritos.data)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        idUpdate = item['id_distrito'];
                                        distrito.text = item['distrito'];
                                        iddistritoSelected =
                                            item['id_distrito'];
                                        elementSelected(item['id_region']);
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
                                                  item['distrito'],
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
