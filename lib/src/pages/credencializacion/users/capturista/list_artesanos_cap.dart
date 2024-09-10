import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:scav/src/utils/mobile.dart'
    if (dart.library.html) 'package:scav/src/utils/web.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ListArtesanosCapScreen extends StatefulWidget {
  const ListArtesanosCapScreen({super.key});

  @override
  State<ListArtesanosCapScreen> createState() => _ListArtesanosCapScreenState();
}

class _ListArtesanosCapScreenState extends State<ListArtesanosCapScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController detailBaja = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController distrito = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController localidad = TextEditingController();
  TextEditingController rama = TextEditingController();
  TextEditingController tecnica = TextEditingController();
  TextEditingController tipo = TextEditingController();
  TextEditingController annioC = TextEditingController();

  String credencial = 'NO';
  bool generateCredencial = false;
  bool generateReporte = false;
  bool getRenovados = false;
  bool getNuevos = false;
  bool getSearch = false;
  bool bajaRegistro = false;
  bool altRegistro = false;
  String regionB = "";
  String distritoB = "";
  String municipioB = "";
  String localidadB = "";
  String ramaB = "";
  String tecnicaB = "";
  String tipoB = "";

  String baja = 'NO';

  Dio dio = Dio();

  Response listArtesanos = Response(requestOptions: RequestOptions());
  Response listRegiones = Response(requestOptions: RequestOptions());
  Response listDistritos = Response(requestOptions: RequestOptions());
  Response listMunicipios = Response(requestOptions: RequestOptions());
  Response listLocalidades = Response(requestOptions: RequestOptions());
  Response listRamas = Response(requestOptions: RequestOptions());
  Response listTecnicas = Response(requestOptions: RequestOptions());

  Response resultSearch = Response(requestOptions: RequestOptions());

  Response dataArtesano = Response(requestOptions: RequestOptions());
  Response entregarCredencial = Response(requestOptions: RequestOptions());
  Response bajaArtesano = Response(requestOptions: RequestOptions());
  Response imageARtesano = Response(requestOptions: RequestOptions());

  Future apiGetArtesanos() async {
    listArtesanos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/artesanos/home');

    return listArtesanos.data;
  }

  Future apiCredencial(id, imagen) async {
    dataArtesano = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/artesanos/detailCredencial',
        queryParameters: {"artesano": id});

    if (dataArtesano.data['id_organizacion'].toString().startsWith('OR') ||
        dataArtesano.data['id_organizacion'].toString().startsWith('TF')) {
      _createPDFOrganizacion(dataArtesano, imagen);
      return dataArtesano.data;
    } else {
      _createPDF(dataArtesano, imagen);

      return dataArtesano.data;
    }
  }

  Future apiCredencialImage(id) async {
    imageARtesano = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/artesanos/image',
        queryParameters: {"artesano": id});

    if (imageARtesano.statusCode == 200) {
      launchUrlString(imageARtesano.data['mensaje']);
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.red, Icons.error,
          'Error al generar imagen, intenta de nuevo', context);
    }
  }

  List<String> annios = ['General'];

  String annio = 'General';

  Future apiEntregarCredencial(id, BuildContext context) async {
    Message().mensaje(Colors.blue, Icons.update, 'Actualizando...', context);

    entregarCredencial = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/artesano/credencial/$id');

    if (entregarCredencial.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future apiBajaArtesano(id, estado, BuildContext context) async {
    setState(() {
      bajaRegistro = true;
    });

    Message().mensaje(Colors.blue, Icons.update, 'Actualizando...', context);
    bajaArtesano = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/artesanos/baja/$id', data: {
      "activo": estado,
      "comentarios": detailBaja.text,
      "update_at": GlobalVariable.currentDate
    });

    if (bajaArtesano.statusCode == 200) {
      setState(() {
        bajaRegistro = false;
      });
      return true;
    } else {
      setState(() {
        bajaRegistro = false;
      });
      return false;
    }
  }

  Future apiSearch(BuildContext context) async {
    setState(() {
      getSearch = true;
    });
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/artesanos/search',
        queryParameters: {
          'buscar': buscar.text,
          'region': regionB,
          'distrito': distritoB,
          'municipio': municipioB,
          'localidad': localidadB,
          'rama': ramaB,
          'tecnica': tecnicaB,
          'tipo': tipoB
        });

    if (resultSearch.statusCode == 200) {
      setState(() {
        listArtesanos.data = resultSearch.data;
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

  void idSelected(elemto, lista, tipo) {
    switch (tipo) {
      case 'region':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['region'] == elemto) {
            regionB = lista.data[i]['id_region'];
          }
        }
        break;
      case 'distrito':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['distrito'] == elemto) {
            distritoB = lista.data[i]['id_distrito'];
          }
        }
        break;
      case 'municipio':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['municipio'] == elemto) {
            municipioB = lista.data[i]['id_municipio'];
          }
        }
        break;
      case 'localidad':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['localidad'] == elemto) {
            localidadB = lista.data[i]['id_localidad'];
          }
        }
        break;
      case 'rama':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_rama'] == elemto) {
            ramaB = lista.data[i]['id_rama'];
          }
        }
        break;
      case 'tecnica':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_subrama'] == elemto) {
            tecnicaB = lista.data[i]['id_subrama'];
          }
        }
        break;
      default:
    }
  }

  Future apiRenNue(BuildContext context, opcion) async {
    if (opcion == 1) {
      setState(() {
        getRenovados = true;
      });
    } else {
      setState(() {
        getNuevos = true;
      });
    }
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/artesanos/renoNue',
        queryParameters: {'opcion': opcion});

    if (resultSearch.statusCode == 200) {
      setState(() {
        listArtesanos.data = resultSearch.data;
      });

      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.green, Icons.done, 'LISTA ACTUALIZADA', context);
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning, 'Sin resultados', context);
    }

    if (opcion == 1) {
      setState(() {
        getRenovados = false;
      });
    } else {
      setState(() {
        getNuevos = false;
      });
    }
  }

  Future apiGetMunicipios() async {
    listMunicipios =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/municipios');

    return listMunicipios.data;
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

  Future apiGetDistritos() async {
    listDistritos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/distritos');

    return listDistritos.data;
  }

  Future apiGetLocalidades() async {
    listLocalidades =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/localidades/all');

    return listLocalidades.data;
  }

  Future apiGetTecnicas() async {
    listTecnicas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/tecnicas');

    return listTecnicas.data;
  }

  late final Future getMunicipios = apiGetMunicipios();
  late final Future getRegiones = apiGetRegiones();
  late final Future getRamas = apiGetRamas();
  late final Future getDistritos = apiGetDistritos();
  late final Future getLocalidades = apiGetLocalidades();
  late final Future getTecnicas = apiGetTecnicas();

  late final Future getArtesanos = apiGetArtesanos();

  @override
  Widget build(BuildContext context) {
    for (var i = 2016; i <= int.parse(GlobalVariable.currentYear); i++) {
      annios.add(i.toString());
    }

    return FutureBuilder(
      future: getArtesanos,
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
                            width: Adaptive.w(20),
                            height: Adaptive.h(5),
                            child: TextFormField(
                              cursorWidth: 2,
                              cursorHeight: 15,
                              style: TextStyle(
                                fontSize: Adaptive.sp(11),
                              ),
                              controller: buscar,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
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
                                  label: const Text('NOMBRE')),
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
                                          idSelected(
                                              p0, listRegiones, 'region');
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
                            width: Adaptive.w(12),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                              future: getDistritos,
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
                                        controller: distrito,
                                        hintText: 'Distrito',
                                        selectedStyle: TextStyle(
                                            color: Styles.rojo,
                                            fontSize: Adaptive.sp(9)),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          idSelected(
                                              p0, listDistritos, 'distrito');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: [
                                          for (var item in listDistritos.data)
                                            item['distrito']
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
                                          idSelected(
                                              p0, listMunicipios, 'municipio');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: [
                                          for (var item in listMunicipios.data)
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
                          Expanded(
                            child: Container(),
                          ),
                          ElevatedButton.icon(
                              icon: const Icon(Icons.format_list_bulleted),
                              style: Styles.buttonBothBorders,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("organizaciones");
                              },
                              label: Text(
                                "AGRUPACIONES / TALLERES",
                                style: TextStyle(fontSize: Adaptive.sp(11)),
                              )),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          ElevatedButton.icon(
                              icon: const Icon(Icons.person_add),
                              style: Styles.buttonAddArtesano,
                              onPressed: () {
                                Navigator.of(context).pushNamed("addArtesano");
                              },
                              label: Text(
                                "AGREGAR ARTESANO",
                                style: TextStyle(fontSize: Adaptive.sp(11)),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: Adaptive.h(1),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Adaptive.w(2),
                          ),
                          SizedBox(
                            width: Adaptive.w(12),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                              future: getLocalidades,
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
                                        controller: localidad,
                                        hintText: 'Localidad',
                                        selectedStyle: TextStyle(
                                            color: Styles.rojo,
                                            fontSize: Adaptive.sp(9)),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          idSelected(
                                              p0, listLocalidades, 'localidad');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: [
                                          for (var item in listLocalidades.data)
                                            item['localidad']
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
                              child: CustomDropDownII(
                                hintStyle: TextStyle(
                                  fontSize: Adaptive.sp(11),
                                ),
                                listItemStyle: TextStyle(
                                  fontSize: Adaptive.sp(11),
                                ),
                                controller: tipo,
                                hintText: 'Tipo',
                                selectedStyle: TextStyle(
                                    color: Styles.rojo,
                                    fontSize: Adaptive.sp(9)),
                                errorText: 'Sin resultados',
                                onChanged: (p0) {
                                  setState(() {
                                    tipoB = p0;
                                  });
                                },
                                borderSide: BorderSide(color: Styles.rojo),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                items: const ['Renovados', 'Nuevos'],
                              )),
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
                                    ? CustomDropDownII.search(
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
                                          idSelected(p0, listRamas, 'rama');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
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
                            width: Adaptive.w(12),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                              future: getTecnicas,
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
                                        controller: tecnica,
                                        hintText: 'Técnicas',
                                        selectedStyle: TextStyle(
                                            color: Styles.rojo,
                                            fontSize: Adaptive.sp(9)),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          idSelected(
                                              p0, listTecnicas, 'tecnica');
                                        },
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: [
                                          for (var item in listTecnicas.data)
                                            item['nombre_subrama']
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
                                  tecnica = TextEditingController();
                                  distrito = TextEditingController();
                                  localidad = TextEditingController();
                                  tipo = TextEditingController();
                                  regionB = "";
                                  distritoB = "";
                                  municipioB = "";
                                  localidadB = "";
                                  ramaB = "";
                                  tecnicaB = "";
                                  tipoB = "";
                                });
                              },
                              icon: Icon(
                                Icons.restart_alt,
                                color: Styles.rojo,
                              )),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          OutlinedLoadingButton(
                              isLoading: getSearch,
                              style: Styles().buttonSearchArtesanos(context),
                              loadingIcon: const Icon(Icons.search),
                              loadingLabel: const Text('Obteniendo datos...'),
                              onPressed: () async {
                                apiSearch(context);
                              },
                              child: Text(
                                "Buscar",
                                style: TextStyle(fontSize: Adaptive.sp(12)),
                              ))
                        ],
                      )
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
                            width: Adaptive.w(20),
                            child: Text(
                              "FOLIO",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(11),
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(30),
                            child: Text(
                              "NOMBRE",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(11),
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(15),
                            child: Text(
                              "VIGENCIA DE CREDENCIAL",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(11),
                                  fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(15),
                            child: Text(
                              "FECHA DE ENTREGA",
                              style: TextStyle(
                                  fontSize: Adaptive.sp(11),
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
                      for (var item in listArtesanos.data)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Adaptive.w(1)),
                          child: ExpansionTile(
                            title: Row(
                              children: [
                                SizedBox(
                                    width: Adaptive.w(20),
                                    child: Text(
                                      item['id_artesano'],
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(11),
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(
                                  width: Adaptive.w(1),
                                ),
                                SizedBox(
                                    width: Adaptive.w(30),
                                    child: Text(
                                      item['nombre'] +
                                          ' ' +
                                          item['primer_apellido'] +
                                          ' ' +
                                          item['segundo_apellido'],
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(11),
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(
                                  width: Adaptive.w(1),
                                ),
                                SizedBox(
                                    width: Adaptive.w(15),
                                    child: Text(
                                      "2022-2028",
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(11),
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(
                                  width: Adaptive.w(1),
                                ),
                                SizedBox(
                                    width: Adaptive.w(15),
                                    child: Text(
                                      item['fecha_entrega_credencial'] ??
                                          'Sin fecha',
                                      style: TextStyle(
                                          fontSize: Adaptive.sp(11),
                                          fontWeight: FontWeight.w500),
                                    )),
                              ],
                            ),
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Adaptive.w(2),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: '',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Alta: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['created_at']}   ->   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: 'Region: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['region']}   ->   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: 'Distrito: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['distrito']}   ->   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: 'Municipio: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['municipio']}   ->   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: 'Localidad: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text: "${item['localidad']}",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(1),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Adaptive.w(2),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: '',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Rama: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['nombre_rama']}   ->   ",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            TextSpan(
                                                text: 'Tecnica: ',
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight: FontWeight.w500,
                                                    color: Styles.rojo)),
                                            TextSpan(
                                                text:
                                                    "${item['nombre_subrama']}",
                                                style: TextStyle(
                                                    fontSize: Adaptive.sp(12),
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Adaptive.h(1),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                          style: Styles.buttonViewEditArt,
                                          onPressed: () {
                                            setState(() {
                                              GlobalVariable
                                                      .idArtesanoEditCred =
                                                  item['id_artesano'];
                                            });

                                            Navigator.of(context)
                                                .pushNamed("viewEditArtesano");
                                          },
                                          icon: const Icon(Icons.edit),
                                          label: Text(
                                            "VER Y EDITAR INFORMACION",
                                            style: TextStyle(
                                                fontSize: Adaptive.sp(11)),
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launchUrlString(
                                              '${GlobalVariable.baseUrlApi}scav/v1/artesanos/image?artesano=${item['id_artesano']}');
                                        },
                                        child: Text(
                                          "IMAGEN",
                                          style: TextStyle(
                                              color: Styles.rojo,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                          tooltip: "CREDENCIAL PDF CON IMAGEN",
                                          onPressed: () {
                                            apiCredencial(
                                                item['id_artesano'], true);
                                          },
                                          icon: Icon(
                                            Icons.picture_as_pdf,
                                            color: Styles.rojo,
                                          )),
                                      IconButton(
                                          tooltip: "CREDENCIAL PDF EN TEXTO",
                                          onPressed: () {
                                            apiCredencial(
                                                item['id_artesano'], false);
                                          },
                                          icon: Icon(
                                            Icons.document_scanner,
                                            color: Styles.rojo,
                                          )),
                                      SizedBox(
                                        width: Adaptive.w(1),
                                      ),
                                      Text("ENTREGA CREDENCIAL",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(11),
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        width: Adaptive.w(.2),
                                      ),
                                      Radio(
                                        value: 'SI',
                                        groupValue: credencial,
                                        activeColor: Styles.rojo,
                                        onChanged: (val) async {
                                          setState(() {
                                            credencial = 'SI';
                                          });
                                          _entregaCredencial(context, item);
                                        },
                                      ),
                                      Text("SI",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(11))),
                                      Radio(
                                        value: 'NO',
                                        groupValue: credencial,
                                        activeColor: Styles.rojo,
                                        onChanged: (val) {
                                          setState(() {
                                            credencial = 'NO';
                                          });
                                        },
                                      ),
                                      Text("NO",
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(11))),
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
                  )
                ],
              )
            : Image.asset("assets/images/cargando.gif");
      },
    );
  }

  _entregaCredencial(BuildContext context, item) {
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
                child: Text("¿Desea marcar la crencencial como entregada?",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            actions: <Widget>[
              SizedBox(
                width: Adaptive.w(80),
                child: bajaRegistro == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              child: const Text("Guardar"),
                              onPressed: () async {
                                if (await apiEntregarCredencial(
                                        item['id_artesano'], context) ==
                                    true) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Credencial entregada', context);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.red, Icons.error,
                                      'Error al entregar credencial', context);
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
        barrierDismissible: false,
        barrierColor: Colors.white70);
  }
}

Future<void> _createPDF(data, imagen) async {
  if (imagen == true) {
    final PdfDocument document = PdfDocument(
        inputBytes: await _readData('credencial_img_individual.pdf'));

    final PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
    name.text = data.data['nombre'] +
        ' ' +
        data.data['primer_apellido'] +
        " " +
        data.data['segundo_apellido'];

    var per = "";
    if (data.data['sexo'] == 'H') {
      per = "PERSONA ARTESANA PRODUCTORA DE ";
    } else {
      per = "PERSONA ARTESANA PRODUCTOR DE ";
    }

    final PdfTextBoxField texto = document.form.fields[1] as PdfTextBoxField;
    texto.text = per + data.data['nombre_rama'];

    /*
    
    PdfPage page = document.pages[0];
    page.graphics.drawString(
        data.data['id_artesano'], PdfStandardFont(PdfFontFamily.helvetica, 7),
        bounds: const Rect.fromLTWH(347, 84, 0, 0));
        */

    final PdfTextBoxField inscripcion =
        document.form.fields[2] as PdfTextBoxField;
    inscripcion.text = data.data['gpo_pertenencia'];
    final PdfTextBoxField domicilio =
        document.form.fields[3] as PdfTextBoxField;
    domicilio.text = data.data['calle'] +
        " " +
        data.data['num_exterior'] +
        " " +
        data.data['num_interior'];
    final PdfTextBoxField localidad =
        document.form.fields[4] as PdfTextBoxField;
    localidad.text = data.data['localidad'];
    final PdfTextBoxField municipio =
        document.form.fields[5] as PdfTextBoxField;
    municipio.text = data.data['municipio'];
    final PdfTextBoxField region = document.form.fields[6] as PdfTextBoxField;
    region.text = data.data['region'];
    final PdfTextBoxField cp = document.form.fields[7] as PdfTextBoxField;
    cp.text = data.data['cp'];
    final PdfTextBoxField telefono = document.form.fields[8] as PdfTextBoxField;
    telefono.text = data.data['tel_celular'];
    final PdfTextBoxField ine = document.form.fields[9] as PdfTextBoxField;
    ine.text = data.data['clave_ine'];
    final PdfTextBoxField curp = document.form.fields[10] as PdfTextBoxField;
    curp.text = data.data['curp'];
    var fechad = data.data['created_at'];
    fechad = fechad.split(" ");
    final PdfTextBoxField fecha = document.form.fields[11] as PdfTextBoxField;
    fecha.text = fechad[0];
    final PdfTextBoxField idartesano =
        document.form.fields[12] as PdfTextBoxField;
    idartesano.text = data.data['id_artesano'];

    List<int> bytes = await document.save();
    document.dispose();
    // ignore: prefer_interpolation_to_compose_strings
    saveAndLaunchFile(bytes, "${"Credencial_" + data.data['id_artesano']}.pdf");
  } else {
    final PdfDocument document =
        PdfDocument(inputBytes: await _readData('credencial_individual.pdf'));

    final PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
    name.text = data.data['nombre'] +
        ' ' +
        data.data['primer_apellido'] +
        " " +
        data.data['segundo_apellido'];

    var per = "";
    if (data.data['sexo'] == 'H') {
      per = "PERSONA ARTESANA PRODUCTORA DE ";
    } else {
      per = "PERSONA ARTESANA PRODUCTOR DE ";
    }

    final PdfTextBoxField texto = document.form.fields[1] as PdfTextBoxField;
    texto.text = per + data.data['nombre_rama'];

    final PdfTextBoxField inscripcion =
        document.form.fields[2] as PdfTextBoxField;
    inscripcion.text = data.data['gpo_pertenencia'];
    final PdfTextBoxField domicilio =
        document.form.fields[3] as PdfTextBoxField;
    domicilio.text = data.data['calle'] +
        " " +
        data.data['num_exterior'] +
        " " +
        data.data['num_interior'];
    final PdfTextBoxField localidad =
        document.form.fields[4] as PdfTextBoxField;
    localidad.text = data.data['localidad'];
    final PdfTextBoxField municipio =
        document.form.fields[5] as PdfTextBoxField;
    municipio.text = data.data['municipio'];
    final PdfTextBoxField region = document.form.fields[6] as PdfTextBoxField;
    region.text = data.data['region'];
    final PdfTextBoxField cp = document.form.fields[7] as PdfTextBoxField;
    cp.text = data.data['cp'];
    final PdfTextBoxField telefono = document.form.fields[8] as PdfTextBoxField;
    telefono.text = data.data['tel_celular'];
    final PdfTextBoxField ine = document.form.fields[9] as PdfTextBoxField;
    ine.text = data.data['clave_ine'];
    final PdfTextBoxField curp = document.form.fields[10] as PdfTextBoxField;
    curp.text = data.data['curp'];
    var fechad = data.data['created_at'];
    fechad = fechad.split(" ");
    final PdfTextBoxField fecha = document.form.fields[11] as PdfTextBoxField;
    fecha.text = fechad[0];

    final PdfTextBoxField idartesano =
        document.form.fields[12] as PdfTextBoxField;
    idartesano.text = data.data['id_artesano'];

    List<int> bytes = await document.save();
    document.dispose();
    // ignore: prefer_interpolation_to_compose_strings
    saveAndLaunchFile(bytes, "${"Credencial_" + data.data['id_artesano']}.pdf");
  }
}

Future<void> _createPDFOrganizacion(data, imagen) async {
  if (imagen == true) {
    final PdfDocument document =
        PdfDocument(inputBytes: await _readData('credencial_img_org.pdf'));

    final PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
    name.text = data.data['nombre'] +
        ' ' +
        data.data['primer_apellido'] +
        " " +
        data.data['segundo_apellido'];

    var per = "";
    if (data.data['sexo'] == 'H') {
      per = "PERSONA ARTESANA PRODUCTORA DE ";
    } else {
      per = "PERSONA ARTESANA PRODUCTOR DE ";
    }

    final PdfTextBoxField texto = document.form.fields[1] as PdfTextBoxField;
    texto.text = per + data.data['nombre_rama'];

    final PdfTextBoxField inscripcion =
        document.form.fields[2] as PdfTextBoxField;
    inscripcion.text = data.data['gpo_pertenencia'];
    final PdfTextBoxField organizacion =
        document.form.fields[3] as PdfTextBoxField;
    organizacion.text = data.data['id_organizacion'];
    final PdfTextBoxField domicilio =
        document.form.fields[4] as PdfTextBoxField;
    domicilio.text = data.data['calle'] +
        " " +
        data.data['num_exterior'] +
        " " +
        data.data['num_interior'];
    final PdfTextBoxField localidad =
        document.form.fields[5] as PdfTextBoxField;
    localidad.text = data.data['localidad'];
    final PdfTextBoxField municipio =
        document.form.fields[6] as PdfTextBoxField;
    municipio.text = data.data['municipio'];
    final PdfTextBoxField region = document.form.fields[7] as PdfTextBoxField;
    region.text = data.data['region'];
    final PdfTextBoxField cp = document.form.fields[8] as PdfTextBoxField;
    cp.text = data.data['cp'];
    final PdfTextBoxField telefono = document.form.fields[9] as PdfTextBoxField;
    telefono.text = data.data['tel_celular'];
    final PdfTextBoxField ine = document.form.fields[10] as PdfTextBoxField;
    ine.text = data.data['clave_ine'];
    final PdfTextBoxField curp = document.form.fields[11] as PdfTextBoxField;
    curp.text = data.data['curp'];
    var fechad = data.data['created_at'];
    fechad = fechad.split(" ");
    final PdfTextBoxField fecha = document.form.fields[12] as PdfTextBoxField;
    fecha.text = fechad[0];

    final PdfTextBoxField idartesano =
        document.form.fields[13] as PdfTextBoxField;
    idartesano.text = data.data['id_artesano'];

    List<int> bytes = await document.save();
    document.dispose();
    // ignore: prefer_interpolation_to_compose_strings
    saveAndLaunchFile(bytes, "${"Credencial_" + data.data['id_artesano']}.pdf");
  } else {
    final PdfDocument document =
        PdfDocument(inputBytes: await _readData('credencial_org.pdf'));

    final PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
    name.text = data.data['nombre'] +
        ' ' +
        data.data['primer_apellido'] +
        " " +
        data.data['segundo_apellido'];

    var per = "";
    if (data.data['sexo'] == 'H') {
      per = "PERSONA ARTESANA PRODUCTORA DE ";
    } else {
      per = "PERSONA ARTESANA PRODUCTOR DE ";
    }

    final PdfTextBoxField texto = document.form.fields[1] as PdfTextBoxField;
    texto.text = per + data.data['nombre_rama'];

    final PdfTextBoxField inscripcion =
        document.form.fields[2] as PdfTextBoxField;
    inscripcion.text = data.data['gpo_pertenencia'];
    final PdfTextBoxField organizacion =
        document.form.fields[3] as PdfTextBoxField;
    organizacion.text = data.data['id_organizacion'];
    final PdfTextBoxField domicilio =
        document.form.fields[4] as PdfTextBoxField;
    domicilio.text = data.data['calle'] +
        " " +
        data.data['num_exterior'] +
        " " +
        data.data['num_interior'];
    final PdfTextBoxField localidad =
        document.form.fields[5] as PdfTextBoxField;
    localidad.text = data.data['localidad'];
    final PdfTextBoxField municipio =
        document.form.fields[6] as PdfTextBoxField;
    municipio.text = data.data['municipio'];
    final PdfTextBoxField region = document.form.fields[7] as PdfTextBoxField;
    region.text = data.data['region'];
    final PdfTextBoxField cp = document.form.fields[8] as PdfTextBoxField;
    cp.text = data.data['cp'];
    final PdfTextBoxField telefono = document.form.fields[9] as PdfTextBoxField;
    telefono.text = data.data['tel_celular'];
    final PdfTextBoxField ine = document.form.fields[10] as PdfTextBoxField;
    ine.text = data.data['clave_ine'];
    final PdfTextBoxField curp = document.form.fields[11] as PdfTextBoxField;
    curp.text = data.data['curp'];
    var fechad = data.data['created_at'];
    fechad = fechad.split(" ");
    final PdfTextBoxField fecha = document.form.fields[12] as PdfTextBoxField;
    fecha.text = fechad[0];
    final PdfTextBoxField idartesano =
        document.form.fields[13] as PdfTextBoxField;
    idartesano.text = data.data['id_artesano'];

    List<int> bytes = await document.save();
    document.dispose();
    // ignore: prefer_interpolation_to_compose_strings
    saveAndLaunchFile(bytes, "${"Credencial_" + data.data['id_artesano']}.pdf");
  }
}

Future<List<int>> _readData(String name) async {
  final ByteData data = await rootBundle.load('assets/pdf/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
