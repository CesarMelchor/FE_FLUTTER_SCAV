import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListArtesanosConScreen extends StatefulWidget {
  const ListArtesanosConScreen({super.key});

  @override
  State<ListArtesanosConScreen> createState() => _ListArtesanosConScreenState();
}

class _ListArtesanosConScreenState extends State<ListArtesanosConScreen> {
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
                            width: Adaptive.w(23),
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
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          SizedBox(
                            width: Adaptive.w(15),
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
                            width: Adaptive.w(15),
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
                            width: Adaptive.w(15),
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
}
