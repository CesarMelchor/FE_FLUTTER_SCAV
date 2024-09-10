import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:custom_dropdown_2/custom_dropdown2.dart';

class ListMunicipiiosPage extends StatefulWidget {
  const ListMunicipiiosPage({super.key});

  @override
  State<ListMunicipiiosPage> createState() => _ListMunicipiiosPageState();
}

class _ListMunicipiiosPageState extends State<ListMunicipiiosPage> {
  TextEditingController buscar = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController distrito = TextEditingController();
  TextEditingController estrategia = TextEditingController();

  Dio dio = Dio();

  String idUpdate = "";
  String distritoSelected = "";
  String iddistritoSelected = "";
  String idmunicipioSelected = "";
  String hintEstrategia = "";
  String estrategiaEdit = "";

  TextEditingController controller = TextEditingController();

  Response listMunicipios = Response(requestOptions: RequestOptions());
  Response listDistritos = Response(requestOptions: RequestOptions());
  Response distritoUpdate = Response(requestOptions: RequestOptions());
  Response newListMunicipios = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());

  Future apiGetMunicipios() async {
    apiGetDistritos();

    listMunicipios =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/municipios');

    return listMunicipios.data;
  }

  void elementSelected(distrito) {
    for (var i = 0; i < listDistritos.data.length; i++) {
      if (listDistritos.data[i]['id_distrito'] == distrito) {
        setState(() {
          distritoSelected = listDistritos.data[i]['distrito'];
          iddistritoSelected = listDistritos.data[i]['id_distrito'];

          controller.text = listDistritos.data[i]['distrito'];
        });
      }
    }
  }

  void districtSelected(distrito) {
    for (var i = 0; i < listDistritos.data.length; i++) {
      if (listDistritos.data[i]['distrito'] == distrito) {
        setState(() {
          distritoSelected = listDistritos.data[i]['distrito'];
          iddistritoSelected = listDistritos.data[i]['id_distrito'];

          controller.text = listDistritos.data[i]['distrito'];
        });
      }
    }
  }

  Future apiGetDistritos() async {
    listDistritos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/distritos');

    return listDistritos.data;
  }

  bool cargando = false;

  Future<bool> apiUpdateMunicipio(id, BuildContext context) async {
    setState(() {
      cargando = true;
    });
    distritoUpdate = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/municipio/update/$id',
        data: {
          "municipio": municipio.text,
          "id_distrito": iddistritoSelected,
          "tipo": estrategiaEdit
        });
    if (distritoUpdate.statusCode == 200) {
      setState(() {
        cargando = false;
      });
      return true;
    } else {
      setState(() {
        cargando = false;
      });
      return false;
    }
  }

  Future apiGetMunicipiosAfterAddOrModify() async {
    newListMunicipios =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/municipios');
    if (newListMunicipios.statusCode == 200) {
      setState(() {
        listMunicipios.data = newListMunicipios.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/municipios/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listMunicipios.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  late final Future getMunicipios = apiGetMunicipios();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMunicipios,
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
                              "EDITAR MUNICIPIO",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(15),
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
                            ),
                            SizedBox(
                              width: Adaptive.w(18),
                            ),
                            Text(
                              "DISTRITO",
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
                                controller: municipio,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyleArtesano("MUNICIPIO"),
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
                                  hintText: 'DISTRITO',
                                  selectedStyle: TextStyle(color: Styles.rojo),
                                  errorText: 'Sin resultados',
                                  onChanged: (p0) {
                                    districtSelected(p0);
                                  },
                                  borderSide: BorderSide(color: Styles.rojo),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  items: [
                                    for (var item in listDistritos.data)
                                      item['distrito']
                                  ],
                                )),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: CustomDropDownII(
                                controller: estrategia,
                                hintText: hintEstrategia,
                                selectedStyle: TextStyle(color: Styles.rojo),
                                errorText: 'Sin resultados',
                                onChanged: (p0) {
                                  setState(() {
                                    estrategiaEdit = p0;
                                  });
                                },
                                borderSide: BorderSide(color: Styles.rojo),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                items: const [
                                  'E100',
                                  'INTEROCEANICO',
                                  '470',
                                  'LIBRAMIENTO SUR'
                                ],
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
                                  cargando == false
                                      ? OutlinedButton(
                                          onPressed: () async {
                                            if (iddistritoSelected != "") {
                                              if (await apiUpdateMunicipio(
                                                  idmunicipioSelected,
                                                  context)) {
                                                apiGetMunicipiosAfterAddOrModify();
                                                // ignore: use_build_context_synchronously
                                                Message().mensaje(
                                                    Colors.green,
                                                    Icons.done,
                                                    'Municipio actualizado',
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
                                          child: const Text("ACTUALIZAR"))
                                      : SizedBox(
                                          width: Adaptive.w(2),
                                          height: Adaptive.w(2),
                                          child: CircularProgressIndicator(
                                            color: Styles.rojo,
                                          )),
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
                                for (var item in listMunicipios.data)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        idUpdate = item['id_municipio'];
                                        municipio.text = item['municipio'];
                                        estrategia.text = item['tipo'];
                                        estrategiaEdit = item['tipo'];
                                        idmunicipioSelected =
                                            item['id_municipio'];
                                        elementSelected(item['id_distrito']);
                                      });
                                    },
                                    child: Container(
                                      color: item['tipo'] == 'INTEROCEANICO'
                                          ? const Color.fromARGB(255, 140, 0, 0)
                                          : item['tipo'] == 'LIBRAMIENTO SUR'
                                              ? const Color.fromARGB(
                                                  255, 189, 32, 0)
                                              : item['tipo'] == 'E100'
                                                  ? const Color.fromARGB(
                                                      255, 250, 30, 14)
                                                  : const Color.fromARGB(
                                                      255, 255, 190, 15),
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
                                                    item['municipio'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptive.sp(11),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                              SizedBox(
                                                width: Adaptive.w(1),
                                              ),
                                              SizedBox(
                                                  width: Adaptive.w(20),
                                                  child: Text(
                                                    item['distrito'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            Adaptive.sp(11),
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
