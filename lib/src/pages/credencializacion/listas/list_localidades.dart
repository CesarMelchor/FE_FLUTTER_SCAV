import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:custom_dropdown_2/custom_dropdown2.dart';

class ListLocalidadesPage extends StatefulWidget {
  const ListLocalidadesPage({super.key});

  @override
  State<ListLocalidadesPage> createState() => _ListLocalidadesPageState();
}

class _ListLocalidadesPageState extends State<ListLocalidadesPage> {
  TextEditingController buscar = TextEditingController();
  TextEditingController localidad = TextEditingController();
  TextEditingController municipio = TextEditingController();

  Dio dio = Dio();

  String idUpdate = "";
  String municipioSelected = "";
  String idmunicipioSelected = "";
  String idlocalidadSelected = "";

  TextEditingController controller = TextEditingController();

  Response listLocalidades = Response(requestOptions: RequestOptions());
  Response listMunicipios = Response(requestOptions: RequestOptions());
  Response municipioUpdate = Response(requestOptions: RequestOptions());
  Response newListLocalidades = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());

  Future apiGetLocalidades() async {
    apiGetMunicipios();

    listLocalidades =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/localidades');

    return listLocalidades.data;
  }

  void elementSelected(municipio) {
    for (var i = 0; i < listMunicipios.data.length; i++) {
      if (listMunicipios.data[i]['id_municipio'] == municipio) {
        setState(() {
          municipioSelected = listMunicipios.data[i]['municipio'];
          idmunicipioSelected = listMunicipios.data[i]['id_municipio'];

          controller.text = listMunicipios.data[i]['municipio'];
        });
      }
    }
  }

  void muniSelected(municipio) {
    for (var i = 0; i < listMunicipios.data.length; i++) {
      if (listMunicipios.data[i]['municipio'] == municipio) {
        setState(() {
          municipioSelected = listMunicipios.data[i]['municipio'];
          idmunicipioSelected = listMunicipios.data[i]['id_municipio'];

          controller.text = listMunicipios.data[i]['municipio'];
        });
      }
    }
  }

  Future apiGetMunicipios() async {
    listMunicipios =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/municipios');

    return listMunicipios.data;
  }

  Future<bool> apiUpdateLocalidad(id, BuildContext context) async {
    municipioUpdate = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/localidad/update/$id',
        data: {
          "localidad": localidad.text,
          "id_municipio": idmunicipioSelected
        });
    if (municipioUpdate.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future apiGetLocalidadesAfterAddOrModify() async {
    newListLocalidades =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/localidades');
    if (newListLocalidades.statusCode == 200) {
      setState(() {
        listLocalidades.data = newListLocalidades.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/localidades/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listLocalidades.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  late final Future getLocalidades = apiGetLocalidades();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLocalidades,
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
                              "EDITAR LOCALIDAD",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(15),
                                  color: Styles.rojo),
                            ),
                            SizedBox(
                              width: Adaptive.w(18),
                            ),
                            Text(
                              "LOCALIDAD",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(14),
                                  color: Styles.rojo),
                            ),
                            SizedBox(
                              width: Adaptive.w(18),
                            ),
                            Text(
                              "MUNICIPIO",
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
                                controller: localidad,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyleArtesano("LOCALIDAD"),
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
                                  hintText: 'MUNICIPIO',
                                  selectedStyle: TextStyle(color: Styles.rojo),
                                  errorText: 'Sin resultados',
                                  onChanged: (p0) {
                                    muniSelected(p0);
                                  },
                                  borderSide: BorderSide(color: Styles.rojo),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  items: [
                                    for (var item in listMunicipios.data)
                                      item['municipio']
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
                                        if (idmunicipioSelected != "") {
                                          if (await apiUpdateLocalidad(
                                              idUpdate, context)) {
                                            apiGetLocalidadesAfterAddOrModify();
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.green,
                                                Icons.done,
                                                'Localidad actualizada',
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
                                              'Selecciona una localidad antes',
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
                                for (var item in listLocalidades.data)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        idUpdate = item['id_localidad'];
                                        localidad.text = item['localidad'];
                                        idlocalidadSelected =
                                            item['id_localidad'];
                                        elementSelected(item['id_municipio']);
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
                                                  item['localidad'],
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
                                                  item['municipio'],
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
