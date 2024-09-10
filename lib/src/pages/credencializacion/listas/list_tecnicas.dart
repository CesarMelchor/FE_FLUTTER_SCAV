import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListTecnicasScreen extends StatefulWidget {
  const ListTecnicasScreen({super.key});

  @override
  State<ListTecnicasScreen> createState() => _ListTecnicasScreenState();
}

class _ListTecnicasScreenState extends State<ListTecnicasScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController tecnica = TextEditingController();
  TextEditingController descripcion = TextEditingController();

  TextEditingController rama = TextEditingController();

  Dio dio = Dio();

  Response listTecnicas = Response(requestOptions: RequestOptions());
  Response newlistTecnicas = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());
  Response listRamas = Response(requestOptions: RequestOptions());
  Response tecnicaUpdate = Response(requestOptions: RequestOptions());
  String idUpdate = "";
  String ramaSelected = "";
  String idramaSelected = "";

  Future apiGetRamas() async {
    listRamas = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/ramas');

    return listRamas.data;
  }

  Future apiGetTecnicas() async {
    apiGetRamas();
    listTecnicas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/tecnicas');

    return listTecnicas.data;
  }

  Future apiGetTecnicasAfterModify() async {
    newlistTecnicas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/tecnicas');
    if (newlistTecnicas.statusCode == 200) {
      setState(() {
        listTecnicas.data = newlistTecnicas.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future<bool> apiUpdateTecnica(id, BuildContext context) async {
    tecnicaUpdate = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/tecnica/update/$idUpdate',
        data: {
          "id_rama": idramaSelected,
          "nombre_subrama": tecnica.text,
          "variedad": descripcion.text
        });
    if (tecnicaUpdate.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/tecnicas/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listTecnicas.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  void elementSelected(ramaS) {
    for (var i = 0; i < listRamas.data.length; i++) {
      if (listRamas.data[i]['id_rama'] == ramaS) {
        setState(() {
          ramaSelected = listRamas.data[i]['nombre_rama'];
          idramaSelected = listRamas.data[i]['id_rama'];
          rama.text = listRamas.data[i]['nombre_rama'];
        });
      }
    }
  }

  void tecniSelected(rama) {
    for (var i = 0; i < listRamas.data.length; i++) {
      if (listRamas.data[i]['nombre_rama'] == rama) {
        setState(() {
          ramaSelected = listRamas.data[i]['nombre_rama'];
          idramaSelected = listRamas.data[i]['id_rama'];

          rama.text = listRamas.data[i]['nombre_rama'];
        });
      }
    }
  }

  late final Future getTecnicas = apiGetTecnicas();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTecnicas,
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
                              icon: const Icon(Icons.add),
                              style: Styles.buttonListArtesano,
                              onPressed: () {
                                Navigator.of(context).pushNamed("addRama");
                              },
                              label: Text(
                                "AGREGAR RAMA / TECNICA",
                                style: TextStyle(fontSize: Adaptive.sp(11)),
                              )),
                          SizedBox(
                            width: Adaptive.w(3),
                          ),
                          ElevatedButton.icon(
                              icon: const Icon(Icons.format_list_bulleted),
                              style: Styles.buttonListTecnicas,
                              onPressed: () {
                                Navigator.of(context).pushNamed("listRamas");
                              },
                              label: Text(
                                "LISTA DE RAMAS",
                                style: TextStyle(fontSize: Adaptive.sp(11)),
                              )),
                          Expanded(child: Container()),
                          SizedBox(
                            width: Adaptive.w(45),
                            child: TextFormField(
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
                          SizedBox(
                            width: Adaptive.w(2),
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
                            width: Adaptive.w(50),
                            child: Text(
                              "EDITAR TECNICA ARTESANAL",
                              style: TextStyle(
                                  color: Styles.crema2,
                                  fontSize: Adaptive.sp(12),
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                            width: Adaptive.w(23),
                            child: Text(
                              "TECNICA ARTESANAL",
                              style: TextStyle(
                                  color: Styles.crema2,
                                  fontSize: Adaptive.sp(12),
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                            width: Adaptive.w(20),
                            child: Text(
                              "RAMA ARTESANAL",
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
                  Row(
                    children: [
                      SizedBox(
                        width: Adaptive.w(49),
                        height: Adaptive.h(55),
                        child: Column(
                          children: [
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: TextFormField(
                                controller: tecnica,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration: Styles()
                                    .inputStyleArtesano("TECNICA ARTESANAL"),
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
                              child: TextFormField(
                                controller: descripcion,
                                maxLines: 5,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration:
                                    Styles().inputStyleArtesano("DESCRIPCION"),
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
                                  controller: rama,
                                  hintText: 'RAMA ARTESANAL',
                                  selectedStyle: TextStyle(color: Styles.rojo),
                                  errorText: 'Sin resultados',
                                  onChanged: (p0) {
                                    tecniSelected(p0);
                                  },
                                  borderSide: BorderSide(color: Styles.rojo),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  items: [
                                    for (var item in listRamas.data)
                                      item['nombre_rama']
                                  ],
                                )),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            SizedBox(
                                width: Adaptive.w(40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () async {
                                          if (await apiUpdateTecnica(
                                              idUpdate, context)) {
                                            apiGetTecnicasAfterModify();
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.green,
                                                Icons.done,
                                                'Técnica artesanal actualizada',
                                                context);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.red,
                                                Icons.error,
                                                'Error al actualizar',
                                                context);
                                          }
                                        },
                                        child: const Text("Actualizar"))
                                  ],
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Adaptive.w(50),
                        height: Adaptive.h(55),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              for (var item in listTecnicas.data)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Adaptive.w(1)),
                                  child: ExpansionTile(
                                    leading: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            idUpdate = item['id_subrama'];
                                            idramaSelected = item['id_subrama'];
                                            tecnica.text =
                                                item['nombre_subrama'];
                                            descripcion.text = item['variedad'];
                                            elementSelected(item['id_rama']);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Styles.rojo,
                                        )),
                                    title: Row(
                                      children: [
                                        SizedBox(
                                            width: Adaptive.w(20),
                                            child: Text(
                                              item['nombre_subrama'],
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
                                              item['nombre_rama'],
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
                                              SizedBox(
                                                  width: Adaptive.w(40),
                                                  child: Text(
                                                    item['variedad'] ??
                                                        'No definido',
                                                    style: TextStyle(
                                                        color: Styles.crema2,
                                                        fontSize:
                                                            Adaptive.sp(12),
                                                        fontWeight:
                                                            FontWeight.w500),
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
}
