import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListRamasScreen extends StatefulWidget {
  const ListRamasScreen({super.key});

  @override
  State<ListRamasScreen> createState() => _ListRamasScreenState();
}

class _ListRamasScreenState extends State<ListRamasScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController rama = TextEditingController();
  TextEditingController descripcion = TextEditingController();

  Dio dio = Dio();

  Response listRamas = Response(requestOptions: RequestOptions());
  Response newlistRamas = Response(requestOptions: RequestOptions());
  Response resultSearch = Response(requestOptions: RequestOptions());
  Response ramaUpdate = Response(requestOptions: RequestOptions());
  String idUpdate = "";

  Future apiGetRamas() async {
    listRamas = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/ramas');

    return listRamas.data;
  }

  Future apiGetRamasAfterModify() async {
    newlistRamas = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/ramas');
    if (newlistRamas.statusCode == 200) {
      setState(() {
        listRamas.data = newlistRamas.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future<bool> apiUpdateRama(id, BuildContext context) async {
    ramaUpdate = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/rama/update/$id',
        data: {"nombre_rama": rama.text, "descripcion": descripcion.text});
    if (ramaUpdate.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future apiSearch(BuildContext context) async {
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/ramas/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listRamas.data = resultSearch.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
  }

  late final Future getRamas = apiGetRamas();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRamas,
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
                                Navigator.of(context).pushNamed("listTecnicas");
                              },
                              label: Text(
                                "LISTA DE TECNICAS",
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
                            width: Adaptive.w(49),
                            child: Text(
                              "EDITAR RAMA ARTESANAL",
                              style: TextStyle(
                                  color: Styles.crema2,
                                  fontSize: Adaptive.sp(12),
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(40),
                            child: Text(
                              "NOMBRE",
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
                                controller: rama,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration: Styles()
                                    .inputStyleArtesano("RAMA ARTESANAL"),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(5),
                            ),
                            SizedBox(
                              width: Adaptive.w(40),
                              child: TextFormField(
                                controller: descripcion,
                                maxLines: 10,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration: Styles().inputStyleArtesano(""),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Este campo no puede estar vacío";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(5),
                            ),
                            SizedBox(
                                width: Adaptive.w(40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    OutlinedButton(
                                        onPressed: () async {
                                          if (await apiUpdateRama(
                                              idUpdate, context)) {
                                            apiGetRamasAfterModify();
                                            // ignore: use_build_context_synchronously
                                            Message().mensaje(
                                                Colors.green,
                                                Icons.done,
                                                'Rama artesanal actualizada',
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
                        width: Adaptive.w(1),
                      ),
                      SizedBox(
                        width: Adaptive.w(45),
                        height: Adaptive.h(55),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              for (var item in listRamas.data)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Adaptive.w(1)),
                                  child: ExpansionTile(
                                    leading: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            rama.text = item['nombre_rama'];
                                            descripcion.text =
                                                item['descripcion'];
                                            idUpdate = item['id_rama'];
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Styles.rojo,
                                        )),
                                    title: Row(
                                      children: [
                                        SizedBox(
                                            width: Adaptive.w(30),
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
                                                    item['descripcion'],
                                                    style: TextStyle(
                                                        color: Styles.crema2,
                                                        fontSize:
                                                            Adaptive.sp(11),
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
