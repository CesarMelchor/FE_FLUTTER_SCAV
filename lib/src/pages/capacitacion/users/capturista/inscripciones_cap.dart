import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ListInscripcionesCapturistaScreen extends StatefulWidget {
  const ListInscripcionesCapturistaScreen({super.key});

  @override
  State<ListInscripcionesCapturistaScreen> createState() =>
      _ListInscripcionesCapturistaScreenState();
}

class _ListInscripcionesCapturistaScreenState
    extends State<ListInscripcionesCapturistaScreen> {
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

  bool isEnabled(annioAction, trimestre) {
    String annio = DateFormat("yyyy").format(DateTime.now());
    String mes = DateFormat("MM").format(DateTime.now());
    int annioN;
    int mesN;
    annioN = int.parse(annio);
    mesN = int.parse(mes);

    if (int.parse(annioAction) == annioN) {
      switch (int.parse(trimestre)) {
        case 1:
          if (mesN >= 1 && mesN <= 3) {
            return true;
          } else {
            return false;
          }
        case 2:
          if (mesN >= 4 && mesN <= 6) {
            return true;
          } else {
            return false;
          }
        case 3:
          if (mesN >= 7 && mesN <= 9) {
            return true;
          } else {
            return false;
          }
        case 4:
          if (mesN >= 10 && mesN <= 12) {
            return true;
          } else {
            return false;
          }
        default:
          return false;
      }
    } else {
      return false;
    }
  }

  Future apiAddInscripcion(BuildContext context) async {
    setState(() {
      agregando = true;
    });
    addInscripcion = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/inscripcion/create', data: {
      "id_artesano": idartesano,
      "solicitud": solicitud.text,
      "observaciones": observaciones.text,
      "id_accion": accioid,
      "created_at": GlobalVariable.currentDate,
      "updated_at": GlobalVariable.currentDate,
    });

    if (addInscripcion.statusCode == 200) {
      setState(() {
        buscar.text = '';
        accioid = '';
        idartesano = '';
        accion = TextEditingController();
        solicitud = TextEditingController();
        observaciones = TextEditingController();
        agregando = false;
      });
      return true;
    } else {
      setState(() {
        agregando = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Message()
          .mensaje(Colors.amber, Icons.warning, 'Registro repetido', context);
      return false;
    }
  }

  Future apiAEditInscripcion(BuildContext context) async {
    setState(() {
      editando = true;
    });
    editInscripcion = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/inscripcion/update/$inscripcionIdE',
        data: {
          "solicitud": solicitudE.text,
          "observaciones": observacionesE.text,
          "updated_at": GlobalVariable.currentDate,
        });

    if (editInscripcion.statusCode == 200) {
      setState(() {
        solicitudE = TextEditingController();
        observacionesE = TextEditingController();
        inscripcionIdE = "";
        editando = false;
      });
      return true;
    } else {
      setState(() {
        editando = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Message()
          .mensaje(Colors.amber, Icons.warning, 'Registro repetido', context);
      return false;
    }
  }

  Future apiGetAcciones() async {
    listAcciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/acciones');

    return listAcciones.data;
  }

  Future apiGetAccionesAfterChanges() async {
    newListInscripciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/inscripciones');
    if (newListInscripciones.statusCode == 200) {
      setState(() {
        listInscripciones.data = newListInscripciones.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
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

  Future apiGetArtesanoByCurp(BuildContext context) async {
    setState(() {
      getSearch = true;
    });
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/artesano/detail/curp',
        queryParameters: {"curp": buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        idartesano = resultSearch.data['id_artesano'];
      });
      // ignore: use_build_context_synchronously
      _createInscripcion(context);
    } else {
      // ignore: use_build_context_synchronously
      Message()
          .mensaje(Colors.amber, Icons.warning, 'CURP no encontrada', context);
    }
    setState(() {
      getSearch = false;
    });
    return resultSearch.data;
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
                            IconButton(
                                tooltip: 'Descargar reporte excel',
                                onPressed: () async {
                                  launchUrlString(
                                      '${GlobalVariable.baseUrlApi}scav/v1/inscripciones/reporte?municipio=$municipioB&nombre=$nombreB&region=$regionB&rama=$ramaB&etnia=$etniaB&programa=$programaB');
                                },
                                icon: Icon(
                                  Icons.save_alt,
                                  color: Styles.rojo,
                                )),
                          ],
                        ),
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
                              width: Adaptive.w(25),
                              height: Adaptive.h(5),
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) {
                                  apiGetArtesanoByCurp(context);
                                },
                                controller: buscar,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                cursorWidth: 1,
                                cursorHeight: 1,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(12),
                                ),
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          apiGetArtesanoByCurp(context);
                                        },
                                        child: getSearch == false
                                            ? Icon(
                                                Icons.person_add_alt,
                                                color: Styles.rojo,
                                              )
                                            : Padding(
                                                padding: EdgeInsets.all(
                                                    Adaptive.w(1)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      Adaptive.w(1)),
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Styles.rojo),
                                                ),
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
                                    label: Text(
                                      'CURP :',
                                      style:
                                          TextStyle(fontSize: Adaptive.sp(11)),
                                    )),
                              ),
                            ),
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
                                        if (isEnabled(item['annioaccion'],
                                            item['trimestreid'])) {
                                          setState(() {
                                            observacionesE.text =
                                                item['observaciones'];
                                            solicitudE.text = item['solicitud'];
                                            inscripcionIdE = item['id'];
                                          });

                                          _editInscripcion(context, item);
                                        } else {
                                          Message().mensaje(
                                              Colors.amber,
                                              Icons.warning,
                                              'No es posible editar este registro',
                                              context);
                                        }
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

  _createInscripcion(BuildContext context) {
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
                child: Text("REALIZAR REGISTRO DE INSCRIPCIÓN",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: Adaptive.w(80),
                height: Adaptive.h(95),
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
                          SelectableText(
                              resultSearch.data['id_artesano'] ?? 'NA')
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
                          SelectableText(resultSearch.data['nombre'] +
                                  ' ' +
                                  resultSearch.data['primer_apellido'] +
                                  ' ' +
                                  resultSearch.data['segundo_apellido'] ??
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
                          SelectableText(resultSearch.data['curp'] ?? 'NA')
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
                    FutureBuilder(
                      future: getAcciones,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return snapshot.hasData
                            ? SizedBox(
                                width: Adaptive.w(30),
                                child: CustomDropDownII.search(
                                  controller: accion,
                                  hintText: 'ACCIONES',
                                  selectedStyle: TextStyle(color: Styles.rojo),
                                  errorText: 'Sin resultados',
                                  onChanged: (p0) {
                                    idAccionSelected(p0, listAcciones);
                                  },
                                  borderSide: BorderSide(color: Styles.rojo),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  items: [
                                    for (var item in listAcciones.data)
                                      item['nombre']
                                  ],
                                ),
                              )
                            : const LinearProgressIndicator();
                      },
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(15),
                          child: TextFormField(
                            controller: solicitud,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("SOLICITUD :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(60),
                          child: TextFormField(
                            controller: observaciones,
                            maxLines: 5,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("OBSERVACIONES : "),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: Adaptive.w(80),
                child: agregando == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: const Text("GUARDAR"),
                              onPressed: () async {
                                if (await apiAddInscripcion(context) == true) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Inscripcion realizada', context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  apiGetAccionesAfterChanges();
                                }
                              }),
                          SizedBox(
                            width: Adaptive.w(5),
                          ),
                          ElevatedButton(
                              child: const Text("CANCELAR"),
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

  _editInscripcion(BuildContext context, item) {
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
                child: Text("ACTUALIZAR REGISTRO DE INSCRIPCIÓN",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: Adaptive.w(80),
                height: Adaptive.h(95),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(15),
                          child: TextFormField(
                            controller: solicitudE,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("SOLICITUD :"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(5),
                        ),
                        SizedBox(
                          width: Adaptive.w(60),
                          child: TextFormField(
                            controller: observacionesE,
                            maxLines: 5,
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("OBSERVACIONES : "),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )
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
                              child: const Text("ACTUALIZAR"),
                              onPressed: () async {
                                if (await apiAEditInscripcion(context) ==
                                    true) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Inscripcion actualizada', context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  apiGetAccionesAfterChanges();
                                }
                              }),
                          SizedBox(
                            width: Adaptive.w(5),
                          ),
                          ElevatedButton(
                              child: const Text("CANCELAR"),
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
