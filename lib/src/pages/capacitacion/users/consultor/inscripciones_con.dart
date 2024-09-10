import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListInscripcionesConsultorScreen extends StatefulWidget {
  const ListInscripcionesConsultorScreen({super.key});

  @override
  State<ListInscripcionesConsultorScreen> createState() =>
      _ListInscripcionesConsultorScreenState();
}

class _ListInscripcionesConsultorScreenState
    extends State<ListInscripcionesConsultorScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController buscarRegisters = TextEditingController();
  TextEditingController observaciones = TextEditingController();
  TextEditingController solicitud = TextEditingController();
  TextEditingController accion = TextEditingController();
  TextEditingController rama = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController etnia = TextEditingController();
  TextEditingController programa = TextEditingController();

  TextEditingController solicitudE = TextEditingController();
  TextEditingController observacionesE = TextEditingController();
  bool searching = false;
  bool agregando = false;
  bool editando = false;

  String accioid = "";
  String idartesano = "";
  String inscripcionIdE = "";
  String ramaB = "";
  String municipioB = "";
  String regionB = "";
  String etniaB = "";
  String programaB = "";
  String nombreB = "";

  Dio dio = Dio();

  Response listInscripciones = Response(requestOptions: RequestOptions());
  Response newListInscripciones = Response(requestOptions: RequestOptions());

  Response listInscripcionesSearch = Response(requestOptions: RequestOptions());

  Response listAcciones = Response(requestOptions: RequestOptions());

  Response listMunicipios = Response(requestOptions: RequestOptions());
  Response listRegiones = Response(requestOptions: RequestOptions());
  Response listRamas = Response(requestOptions: RequestOptions());
  Response listEtnias = Response(requestOptions: RequestOptions());
  Response listProgramas = Response(requestOptions: RequestOptions());

  Response resultSearch = Response(requestOptions: RequestOptions());
  Response addInscripcion = Response(requestOptions: RequestOptions());
  Response editInscripcion = Response(requestOptions: RequestOptions());

  Future apiGetAcciones() async {
    listAcciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/acciones');

    return listAcciones.data;
  }

  Future apiGetInscripciones() async {
    listInscripciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/inscripciones');

    return listInscripciones.data;
  }

  void idAccionSelected(accion, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre'] == accion) {
        setState(() {
          accioid = lista.data[i]['id'];
        });
      }
    }
  }

  Future apiSearchRegisters(BuildContext context) async {
    setState(() {
      getRegisters = true;
    });
    listInscripcionesSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/inscripciones/search',
        queryParameters: {
          "nombre": buscarRegisters.text,
          "municipio": municipioB,
          "region": regionB,
          "rama": ramaB,
          "etnia": etniaB,
          "programa": programaB,
        });

    if (listInscripcionesSearch.statusCode == 200) {
      listInscripciones.data = listInscripcionesSearch.data;
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

  late final Future getInscripciones = apiGetInscripciones();

  Future apiGetMunicipios() async {
    listMunicipios =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/municipios');

    return listMunicipios.data;
  }

  Future apiGetProgramas() async {
    listProgramas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/programas');

    return listProgramas.data;
  }

  Future apiGetGrupos() async {
    listEtnias = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/etnias');

    return listEtnias.data;
  }

  Future apiGetRegiones() async {
    listRegiones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/regiones');

    return listRegiones.data;
  }

  Future apiGetRamas() async {
    listRamas = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/ramas');

    return listRamas.data;
  }

  late final Future getAcciones = apiGetAcciones();
  late final Future getMunicipios = apiGetMunicipios();
  late final Future getRegiones = apiGetRegiones();
  late final Future getRamas = apiGetRamas();
  late final Future getEtnias = apiGetGrupos();
  late final Future getProgramas = apiGetProgramas();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getInscripciones,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Adaptive.w(2),
                            ),
                            SizedBox(
                              width: Adaptive.w(20),
                              height: Adaptive.h(5),
                              child: TextFormField(
                                controller: buscarRegisters,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    nombreB = value;
                                  });
                                },
                                cursorWidth: 2,
                                cursorHeight: 1,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(11),
                                ),
                                decoration: InputDecoration(
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
                                  label: Text(
                                    'NOMBRE:',
                                    style: TextStyle(fontSize: Adaptive.sp(11)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(1),
                            ),
                            SizedBox(
                              width: Adaptive.w(12),
                              height: Adaptive.h(5),
                              child: FutureBuilder(
                                future: getRegiones,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII(
                                          hintStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          listItemStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          controller: region,
                                          hintText: 'Region',
                                          selectedStyle: TextStyle(
                                              color: Styles.rojo,
                                              fontSize: Adaptive.sp(9)),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            setState(() {
                                              regionB = p0;
                                            });
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item in listRegiones.data)
                                              item['region']
                                          ],
                                        )
                                      : Padding(
                                          padding:
                                              EdgeInsets.all(Adaptive.w(1.15)),
                                          child: LinearProgressIndicator(
                                            color: Styles.rojo,
                                          ),
                                        );
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(1),
                            ),
                            SizedBox(
                              width: Adaptive.w(15),
                              height: Adaptive.h(5),
                              child: FutureBuilder(
                                future: getMunicipios,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          hintStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          listItemStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          controller: municipio,
                                          hintText: 'Municipio',
                                          selectedStyle: TextStyle(
                                              color: Styles.rojo,
                                              fontSize: Adaptive.sp(9)),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            setState(() {
                                              municipioB = p0;
                                            });
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item
                                                in listMunicipios.data)
                                              item['municipio']
                                          ],
                                        )
                                      : Padding(
                                          padding:
                                              EdgeInsets.all(Adaptive.w(1.15)),
                                          child: LinearProgressIndicator(
                                            color: Styles.rojo,
                                          ),
                                        );
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(1),
                            ),
                            SizedBox(
                              width: Adaptive.w(12),
                              height: Adaptive.h(5),
                              child: FutureBuilder(
                                future: getRamas,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII(
                                          hintStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          listItemStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          controller: rama,
                                          hintText: 'Rama',
                                          selectedStyle: TextStyle(
                                              color: Styles.rojo,
                                              fontSize: Adaptive.sp(9)),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            setState(() {
                                              ramaB = p0;
                                            });
                                          },
                                          borderSide: BorderSide(
                                            color: Styles.rojo,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item in listRamas.data)
                                              item['nombre_rama']
                                          ],
                                        )
                                      : Padding(
                                          padding:
                                              EdgeInsets.all(Adaptive.w(1.15)),
                                          child: LinearProgressIndicator(
                                            color: Styles.rojo,
                                          ),
                                        );
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(1),
                            ),
                            SizedBox(
                              width: Adaptive.w(11),
                              height: Adaptive.h(5),
                              child: FutureBuilder(
                                future: getEtnias,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII(
                                          hintStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          listItemStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          controller: etnia,
                                          hintText: 'Etnia',
                                          selectedStyle: TextStyle(
                                              color: Styles.rojo,
                                              fontSize: Adaptive.sp(9)),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            setState(() {
                                              etniaB = p0;
                                            });
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item in listEtnias.data)
                                              item['nombre_etnia']
                                          ],
                                        )
                                      : Padding(
                                          padding:
                                              EdgeInsets.all(Adaptive.w(1.15)),
                                          child: LinearProgressIndicator(
                                            color: Styles.rojo,
                                          ),
                                        );
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(1),
                            ),
                            SizedBox(
                              width: Adaptive.w(12),
                              height: Adaptive.h(5),
                              child: FutureBuilder(
                                future: getProgramas,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII(
                                          hintStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          listItemStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          controller: programa,
                                          hintText: 'Programa',
                                          selectedStyle: TextStyle(
                                              color: Styles.rojo,
                                              fontSize: Adaptive.sp(9)),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            setState(() {
                                              programaB = p0;
                                            });
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item in listProgramas.data)
                                              item['nombre_programa']
                                          ],
                                        )
                                      : Padding(
                                          padding:
                                              EdgeInsets.all(Adaptive.w(1.15)),
                                          child: LinearProgressIndicator(
                                            color: Styles.rojo,
                                          ),
                                        );
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(1),
                            ),
                            IconButton(
                                tooltip: 'Limpiar filtros',
                                onPressed: () {
                                  setState(() {
                                    region = TextEditingController();
                                    municipio = TextEditingController();
                                    rama = TextEditingController();
                                    etnia = TextEditingController();
                                    programa = TextEditingController();
                                  });
                                },
                                icon: Icon(
                                  Icons.restart_alt,
                                  color: Styles.rojo,
                                )),
                            getRegisters == false
                                ? IconButton(
                                    tooltip: 'Realizar búsqueda',
                                    onPressed: () {
                                      apiSearchRegisters(context);
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      color: Styles.rojo,
                                    ))
                                : SizedBox(
                                    width: Adaptive.w(2),
                                    height: Adaptive.h(2),
                                    child: CircularProgressIndicator(
                                      color: Styles.rojo,
                                    )),
                          ],
                        ),
                        SizedBox(
                          height: Adaptive.h(2),
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
                                        fontSize: Adaptive.sp(11),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(15),
                                  child: Text(
                                    "CURP",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(11),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(22),
                                  child: Text(
                                    "ACCION",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(11),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(5),
                                  child: Text(
                                    "AÑO",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(11),
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
                                        fontSize: Adaptive.sp(11),
                                        fontWeight: FontWeight.w600),
                                  )),
                              SizedBox(
                                width: Adaptive.w(1),
                              ),
                              SizedBox(
                                  width: Adaptive.w(6),
                                  child: Text(
                                    "TRIMESTRE",
                                    style: TextStyle(
                                        color: Styles.crema2,
                                        fontSize: Adaptive.sp(11),
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(1),
                        ),
                        Column(
                          children: [
                            for (var item in listInscripciones.data)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Adaptive.w(1)),
                                child: ExpansionTile(
                                  trailing: IconButton(
                                      onPressed: () async {
                                        setState(() {
                                          observacionesE.text =
                                              item['observaciones'];
                                          solicitudE.text = item['solicitud'];
                                          inscripcionIdE = item['id'];
                                        });

                                        _viewInscripcion(context, item);
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
                                            item['nombre'] +
                                                ' ' +
                                                item['primer_apellido'] +
                                                ' ' +
                                                item['segundo_apellido'],
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(11),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(15),
                                          child: Text(
                                            item['curp'],
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(11),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(22),
                                          child: Text(
                                            item['nombreaccion'],
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(11),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(5),
                                          child: Text(
                                            item['annioaccion'],
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(11),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(15),
                                          child: Text(
                                            item['nombreprograma'],
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(11),
                                                fontWeight: FontWeight.w600),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      SizedBox(
                                          width: Adaptive.w(6),
                                          child: Text(
                                            item['trimestreid'],
                                            style: TextStyle(
                                                color: Styles.crema2,
                                                fontSize: Adaptive.sp(11),
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

  _viewInscripcion(BuildContext context, item) {
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
                child: Text("CONSULTA DE REGISTRO DE INSCRIPCIÓN",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: Adaptive.w(80),
                height: Adaptive.h(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          SelectableText(item['id_artesano'] ?? 'NA')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Adaptive.w(40),
                      child: Row(
                        children: [
                          const SelectableText(
                            'NOMBRE : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SelectableText(item['nombre'] +
                                  ' ' +
                                  item['primer_apellido'] +
                                  ' ' +
                                  item['segundo_apellido'] ??
                              'NA')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Adaptive.w(40),
                      child: Row(
                        children: [
                          const SelectableText('CURP : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText(item['curp'] ?? 'NA')
                        ],
                      ),
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
                    SizedBox(
                      width: Adaptive.w(40),
                      child: Row(
                        children: [
                          const SelectableText('ACCION : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText(item['nombreaccion'] ?? 'NA')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Adaptive.w(40),
                      child: Row(
                        children: [
                          const SelectableText('PROGRAMA : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText(item['nombreprograma'] ?? 'NA')
                        ],
                      ),
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
                    SizedBox(
                      width: Adaptive.w(40),
                      child: Row(
                        children: [
                          const SelectableText('RAMA ARTESANAL : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText(item['nombre_rama'] ?? 'NA')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Adaptive.w(40),
                      child: Row(
                        children: [
                          const SelectableText('MUNICIPIO : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText(item['municipio'] ?? 'NA')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: Adaptive.w(80),
                child: editando == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: const Text("CERRAR"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      )
                    : Center(
                        child: SizedBox(
                            width: Adaptive.w(2),
                            height: Adaptive.h(2),
                            child: CircularProgressIndicator(
                              color: Styles.rojo,
                            )),
                      ),
              ),
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          );
        },
        barrierColor: Colors.white70);
  }
}
