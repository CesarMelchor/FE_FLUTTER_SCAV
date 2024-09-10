import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class AddRamaScreen extends StatefulWidget {
  const AddRamaScreen({super.key});

  @override
  State<AddRamaScreen> createState() => _AddRamaScreenState();
}

class _AddRamaScreenState extends State<AddRamaScreen> {
  TextEditingController rama = TextEditingController();
  TextEditingController descripcionrama = TextEditingController();

  TextEditingController tecnica = TextEditingController();
  TextEditingController variedad = TextEditingController();
  TextEditingController ramaTecnica = TextEditingController();

  String idrama = "";

  void elementSelected(ramaSe) {
    for (var i = 0; i < listRamas.data.length; i++) {
      if (listRamas.data[i]['nombre_rama'] == ramaSe) {
        setState(() {
          idrama = listRamas.data[i]['id_rama'];
        });
      }
    }
  }

  Dio dio = Dio();

  Response newRama = Response(requestOptions: RequestOptions());
  Response newTecnica = Response(requestOptions: RequestOptions());
  Response listRamas = Response(requestOptions: RequestOptions());

  Future apiGetRamas() async {
    listRamas = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/ramas');

    return listRamas.data;
  }

  Future<bool> apiAddRama(BuildContext context) async {
    var segmento = rama.text;
    newRama = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/rama/create', data: {
      "id_rama": "RA_${segmento[0]}${segmento[1]}_",
      "nombre_rama": rama.text,
      "descripcion": descripcionrama.text,
      "activo": 1,
      "created_at": GlobalVariable.currentDate,
      "updated_at": GlobalVariable.currentDate,
    });
    if (newRama.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> apiAddTecnica(BuildContext context) async {
    var segmento = tecnica.text;
    newRama = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/tecnica/create', data: {
      "id_subrama": "RA_${segmento[0]}${segmento[1]}_",
      "id_rama": idrama,
      "nombre_subrama": tecnica.text,
      "descripcion": "",
      "variedad": variedad.text,
      "created_at": GlobalVariable.currentDate,
      "updated_at": GlobalVariable.currentDate,
      "activo": 1
    });
    if (newRama.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  late final Future getRamas = apiGetRamas();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRamas,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        ElevatedButton.icon(
                            icon: const Icon(Icons.format_list_bulleted),
                            style: Styles.buttonListArtesano,
                            onPressed: () {
                              Navigator.of(context).pushNamed("listRamas");
                            },
                            label: Text(
                              "LISTA DE RAMAS",
                              style: TextStyle(fontSize: Adaptive.sp(11)),
                            )),
                        SizedBox(
                          width: Adaptive.w(25),
                        ),
                        Text(
                          "AGREGAR RAMA / TECNICA ARTESANAL",
                          style: TextStyle(
                              color: Styles.crema2, fontSize: Adaptive.sp(14)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Adaptive.w(1), vertical: Adaptive.h(3)),
                      child: Container(
                        decoration: Styles().containerAdArtesano,
                        padding: EdgeInsets.symmetric(
                            horizontal: Adaptive.w(2), vertical: Adaptive.h(3)),
                        child: Column(
                          children: [
                            SizedBox(
                              child: Text(
                                "AÑADIR NUEVA RAMA",
                                style: TextStyle(
                                    color: Styles.rojo,
                                    fontSize: Adaptive.sp(14)),
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: Adaptive.w(30),
                                  child: TextFormField(
                                    controller: rama,
                                    inputFormatters: [
                                      CapitalLetters(),
                                    ],
                                    onChanged: (value) {},
                                    decoration:
                                        Styles().inputStyleArtesano("NOMBRE"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Adaptive.w(1),
                                ),
                                SizedBox(
                                  width: Adaptive.w(60),
                                  child: TextFormField(
                                    controller: descripcionrama,
                                    inputFormatters: [
                                      CapitalLetters(),
                                    ],
                                    onChanged: (value) {},
                                    decoration: Styles()
                                        .inputStyleArtesano("DESCRIPCIÓN"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Adaptive.h(6),
                            ),
                            Center(
                                child: OutlinedButton(
                                    style: Styles.buttonStyleCred,
                                    onPressed: () async {
                                      if (await apiAddRama(context)) {
                                        setState(() {
                                          rama.text = "";
                                          descripcionrama.text = "";
                                        });
                                        // ignore: use_build_context_synchronously
                                        Message().mensaje(
                                            Colors.green,
                                            Icons.done,
                                            'Rama agregada',
                                            context);
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        Message().mensaje(Colors.red,
                                            Icons.error, 'Error', context);
                                      }
                                    },
                                    child: const Text("GUARDAR"))),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            SizedBox(
                              child: Text(
                                "AÑADIR NUEVA TECNICA ARTESANAL",
                                style: TextStyle(
                                    color: Styles.rojo,
                                    fontSize: Adaptive.sp(14)),
                              ),
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: Adaptive.w(30),
                                  child: TextFormField(
                                    controller: tecnica,
                                    inputFormatters: [
                                      CapitalLetters(),
                                    ],
                                    onChanged: (value) {},
                                    decoration:
                                        Styles().inputStyleArtesano("NOMBRE"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Adaptive.w(1),
                                ),
                                SizedBox(
                                  width: Adaptive.w(30),
                                  child: TextFormField(
                                    controller: variedad,
                                    inputFormatters: [
                                      CapitalLetters(),
                                    ],
                                    onChanged: (value) {},
                                    decoration:
                                        Styles().inputStyleArtesano("VARIEDAD"),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Este campo no puede estar vacío";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: Adaptive.w(1),
                                ),
                                SizedBox(
                                    width: Adaptive.w(30),
                                    child: CustomDropDownII.search(
                                      controller: ramaTecnica,
                                      hintText: 'RAMA ARTESANAL',
                                      selectedStyle:
                                          TextStyle(color: Styles.rojo),
                                      errorText: 'Sin resultados',
                                      onChanged: (p0) {
                                        elementSelected(p0);
                                      },
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      items: [
                                        for (var item in listRamas.data)
                                          item['nombre_rama']
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: Adaptive.h(6),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                    style: Styles.buttonStyleCred,
                                    onPressed: () async {
                                      if (await apiAddTecnica(context)) {
                                        setState(() {
                                          tecnica.text = "";
                                          variedad.text = "";
                                          ramaTecnica.text = "";
                                        });
                                        // ignore: use_build_context_synchronously
                                        Message().mensaje(
                                            Colors.green,
                                            Icons.done,
                                            'Técnica agregada',
                                            context);
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        Message().mensaje(Colors.red,
                                            Icons.error, 'Error', context);
                                      }
                                    },
                                    child: const Text("GUARDAR")),
                              ],
                            ),
                            SizedBox(
                              height: Adaptive.h(3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Image.asset("assets/images/cargando.gif");
      },
    );
  }
}
