import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListAccionesConsultorScreen extends StatefulWidget {
  const ListAccionesConsultorScreen({super.key});

  @override
  State<ListAccionesConsultorScreen> createState() =>
      _ListAccionesConsultorScreenState();
}

class _ListAccionesConsultorScreenState
    extends State<ListAccionesConsultorScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController buscarRegisters = TextEditingController();

  TextEditingController area = TextEditingController();
  TextEditingController nombbre = TextEditingController();
  TextEditingController capacitador = TextEditingController();
  TextEditingController objetivo = TextEditingController();
  TextEditingController poblacion = TextEditingController();
  TextEditingController duracion = TextEditingController();
  TextEditingController nivel = TextEditingController();
  TextEditingController trimestre = TextEditingController();
  TextEditingController programa = TextEditingController();
  TextEditingController annio = TextEditingController();

  TextEditingController areaE = TextEditingController();
  TextEditingController nombbreE = TextEditingController();
  TextEditingController capacitadorE = TextEditingController();
  TextEditingController objetivoE = TextEditingController();
  TextEditingController poblacionE = TextEditingController();
  TextEditingController duracionE = TextEditingController();
  TextEditingController nivelE = TextEditingController();
  TextEditingController trimestreE = TextEditingController();
  TextEditingController programaE = TextEditingController();
  TextEditingController annioE = TextEditingController();

  String programaid = "";
  String trimestreid = "";

  String programaidE = "";
  String trimestreidE = "";
  String accionId = "";
  String hintPrograma = "";
  String hintTrimestre = "";
  String hintNivel = "";
  String nivelEdit = "";

  Dio dio = Dio();

  Response listTrimestres = Response(requestOptions: RequestOptions());
  Response listProgramas = Response(requestOptions: RequestOptions());
  Response newListAcciones = Response(requestOptions: RequestOptions());

  Response listAccionesSearch = Response(requestOptions: RequestOptions());

  Response listAcciones = Response(requestOptions: RequestOptions());

  Response resultSearch = Response(requestOptions: RequestOptions());
  Response addAccion = Response(requestOptions: RequestOptions());
  Response editAccion = Response(requestOptions: RequestOptions());

  bool actualizando = false;
  bool agregando = false;

  Future apiSearch(BuildContext context) async {
    setState(() {
      getSearch = true;
    });
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/acciones/search',
        queryParameters: {'buscar': buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listAcciones.data = resultSearch.data;
      });

      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.green, Icons.done, 'LISTA ACTUALIZADA', context);
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }
    setState(() {
      getSearch = false;
    });
  }

  Future apiGetAcciones() async {
    listAcciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/acciones/home');

    return listAcciones.data;
  }

  Future apiGetTrimestres() async {
    listTrimestres =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/trimestres');

    return listTrimestres.data;
  }

  Future apiGetProgramas() async {
    listProgramas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/programas');

    return listProgramas.data;
  }

  void idElementSelected(element, lista, tipo) {
    switch (tipo) {
      case 'programa':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_programa'] == element) {
            setState(() {
              programaid = lista.data[i]['id'];
            });
          }
        }
        break;
      case 'trimestre':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['meses'] == element) {
            setState(() {
              trimestreid = lista.data[i]['id'];
            });
          }
        }
        break;
      default:
    }
  }

  void idElementUpdate(element, lista, tipo) {
    switch (tipo) {
      case 'programa':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_programa'] == element) {
            setState(() {
              programaidE = lista.data[i]['id'];
            });
          }
        }
        break;
      case 'trimestre':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['meses'] == element) {
            setState(() {
              trimestreidE = lista.data[i]['id'];
            });
          }
        }
        break;
      default:
    }
  }

  Future apiSearchRegisters(BuildContext context) async {
    setState(() {
      getRegisters = true;
    });

    listAccionesSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/acciones/search',
        queryParameters: {"buscar": buscarRegisters.text});

    if (listAccionesSearch.statusCode == 200) {
      listAcciones.data = listAccionesSearch.data;
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.green, Icons.done, 'Lista actualizada', context);
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }

    setState(() {
      getRegisters = false;
    });

    return resultSearch.data;
  }

  bool getSearch = false;
  bool getRegisters = false;

  late final Future getAcciones = apiGetAcciones();

  late final Future getTrimestres = apiGetTrimestres();
  late final Future getProgramas = apiGetProgramas();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAcciones,
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
                              child: TextFormField(
                                controller: buscarRegisters,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) {
                                  apiSearchRegisters(context);
                                },
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          apiSearchRegisters(context);
                                        },
                                        child: getRegisters == false
                                            ? const Icon(Icons.search)
                                            : const Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              )),
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
                                        'BUSCAR ACCION POR NOMBRE :')),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(3),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Adaptive.w(2)),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: Adaptive.w(20),
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
                                  width: Adaptive.w(15),
                                  child: Text(
                                    "PROGRAMA",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(22),
                                  child: Text(
                                    "CAPACITADOR",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(5),
                                  child: Text(
                                    "NIVEL",
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
                                    "TRIMESTRE",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(12),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(6),
                                  child: Text(
                                    "AÑO",
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
                            for (var item in listAcciones.data)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Adaptive.w(1)),
                                child: ExpansionTile(
                                  title: Row(
                                    children: [
                                      SizedBox(
                                          width: Adaptive.w(20),
                                          child: Text(
                                            item['nombre'],
                                            maxLines: 1,
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
                                            item['nombre_programa'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(22),
                                          child: Text(
                                            item['capacitador'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(5),
                                          child: Text(
                                            item['nivel'],
                                            maxLines: 1,
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
                                            item['meses'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(6),
                                          child: Text(
                                            item['annio'],
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(12),
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  ],
                )
              : Image.asset("assets/images/cargando.gif");
        });
  }
}
