import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';

class ListComprobacionesOfflineScreen extends StatefulWidget {
  const ListComprobacionesOfflineScreen({super.key});

  @override
  State<ListComprobacionesOfflineScreen> createState() =>
      _ListComprobacionesOfflineScreenState();
}

class _ListComprobacionesOfflineScreenState
    extends State<ListComprobacionesOfflineScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController buscarRegisters = TextEditingController();
  TextEditingController monto = TextEditingController();
  TextEditingController accion = TextEditingController();

  TextEditingController montoE = TextEditingController();

  String comprobacionid = "";
  String artesanoid = "";

  Dio dio = Dio();

  Response listComprobaciones = Response(requestOptions: RequestOptions());
  Response newListComprobaciones = Response(requestOptions: RequestOptions());

  Response listComprobacionesSearch =
      Response(requestOptions: RequestOptions());

  Response resultSearch = Response(requestOptions: RequestOptions());
  Response addComprobacion = Response(requestOptions: RequestOptions());
  Response editComprobacion = Response(requestOptions: RequestOptions());
  Response listAcciones = Response(requestOptions: RequestOptions());
  String accionid = "";
  bool searching = false;
  bool agregando = false;
  bool editando = false;

  void idAccionSelected(accion, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre'] == accion) {
        setState(() {
          accionid = lista.data[i]['id'];
        });
      }
    }
  }

  Future apiGetAcciones() async {
    listAcciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/acciones');

    return listAcciones.data;
  }

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

  Future apiAddComprobacion(BuildContext context) async {
    setState(() {
      agregando = true;
    });
    addComprobacion = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/comprobaciones/create',
        data: {
          "id_artesano": artesanoid,
          "id_accion": accionid,
          "monto": monto.text,
          "created_at": GlobalVariable.currentDate,
          "updated_at": GlobalVariable.currentDate,
        });

    if (addComprobacion.statusCode == 200) {
      setState(() {
        buscar.text = '';
        artesanoid = '';
        monto = TextEditingController();
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

  Future apiAEditComprobacion(BuildContext context) async {
    setState(() {
      editando = true;
    });
    editComprobacion = await dio.post(
        '${GlobalVariable.baseUrlApi}scav/v1/comprobaciones/update/$comprobacionid',
        data: {
          "monto": montoE.text,
          "updated_at": GlobalVariable.currentDate,
        });

    if (editComprobacion.statusCode == 200) {
      setState(() {
        montoE = TextEditingController();
        comprobacionid = "";
        editando = false;
      });
      return true;
    } else {
      setState(() {
        editando = false;
      });
      return false;
    }
  }

  Future apiGetComprobaciones() async {
    listComprobaciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/comprobaciones');

    return listComprobaciones.data;
  }

  Future apiGetComprobacionesAfterChanges() async {
    newListComprobaciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/comprobaciones');
    if (newListComprobaciones.statusCode == 200) {
      setState(() {
        listComprobaciones.data = newListComprobaciones.data;
      });
    } else {
      // ignore: use_build_context_synchronously
      Message().mensaje(Colors.amber, Icons.warning,
          'Error al obtener la nueva lista', context);
    }
  }

  Future apiGetArtesanoByCurp(BuildContext context) async {
    setState(() {
      getSearch = true;
    });
    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/artesano/detail',
        queryParameters: {"curp": buscar.text});

    if (resultSearch.statusCode == 200) {
      setState(() {
        artesanoid = resultSearch.data['id_artesano'];
      });
      // ignore: use_build_context_synchronously
      _createComprobacion(context);
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
    listComprobacionesSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/comprobaciones/search',
        queryParameters: {"buscar": buscarRegisters.text});

    if (listComprobacionesSearch.statusCode == 200) {
      listComprobaciones.data = listComprobacionesSearch.data;
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

  late final Future getComprobaciones = apiGetComprobaciones();
  late final Future getAcciones = apiGetAcciones();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getComprobaciones,
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
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
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
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                    width: Adaptive.w(2),
                                                    height: Adaptive.h(2),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Styles.rojo,
                                                    )),
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
                                        'BUSCAR REGISTRO POR NOMBRE O CURP :')),
                              ),
                            ),
                            Expanded(child: Container()),
                            SizedBox(
                              width: Adaptive.w(35),
                              child: TextFormField(
                                controller: buscar,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (value) {
                                  apiGetArtesanoByCurp(context);
                                },
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          apiGetArtesanoByCurp(context);
                                        },
                                        child: getSearch == false
                                            ? const Icon(Icons.search)
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                    width: Adaptive.w(2),
                                                    height: Adaptive.h(2),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Styles.rojo,
                                                    )),
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
                                        'INGRESA CURP PARA REALIZAR REGISTRO :')),
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(2),
                            )
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
                                  width: Adaptive.w(15),
                                  child: Text(
                                    "CURP",
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
                                    "MONTO",
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
                                    "ACCION",
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
                                    "AÑO",
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
                                  width: Adaptive.w(6),
                                  child: Text(
                                    "TRIMESTRE",
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
                            for (var item in listComprobaciones.data)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Adaptive.w(1)),
                                child: ExpansionTile(
                                  trailing: IconButton(
                                      onPressed: () async {
                                        if (isEnabled(item['annioaccion'],
                                            item['trimestreid'])) {
                                          setState(() {
                                            montoE.text = item['monto'];
                                            comprobacionid = item['id'];
                                          });
                                          _editComprobacion(context, item);
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
                                          width: Adaptive.w(15),
                                          child: Text(
                                            item['curp'],
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
                                            item['monto'],
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
                                            item['nombreaccion'],
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
                                            item['annioaccion'],
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
                                            item['nombreprograma'],
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
                                            item['trimestreid'],
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

  _createComprobacion(BuildContext context) {
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
                child: Text("REALIZAR REGISTRO DE COMPROBACION",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: Adaptive.w(80),
                height: Adaptive.h(85),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Adaptive.w(15),
                          child: TextFormField(
                            controller: monto,
                            inputFormatters: [
                              CapitalLetters(),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9.]"))
                            ],
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("MONTO :"),
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
                                if (await apiAddComprobacion(context) == true) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Comprobación realizada', context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  apiGetComprobacionesAfterChanges();
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'Error al agregar, actualiza e intenta de nuevo',
                                      context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
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

  _editComprobacion(BuildContext context, item) {
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
                child: Text("ACTUALIZAR COMPROBACION",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(
                horizontal: Adaptive.w(5), vertical: Adaptive.h(10)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: Adaptive.w(80),
                height: Adaptive.h(85),
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
                      width: Adaptive.w(40),
                      child: Row(
                        children: [
                          const SelectableText('TRIMESTRE : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText(item['trimestreid'] ?? 'NA')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Adaptive.w(40),
                      child: Row(
                        children: [
                          const SelectableText('AÑO : ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText(item['annioaccion'] ?? 'NA')
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
                            controller: montoE,
                            inputFormatters: [
                              CapitalLetters(),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9.]"))
                            ],
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("MONTO :"),
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
                              child: const Text("GUARDAR"),
                              onPressed: () async {
                                if (await apiAEditComprobacion(context) ==
                                    true) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Comprobación actualizada', context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  apiGetComprobacionesAfterChanges();
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'Error al actualizar, actualiza la página e intenta de nuevo',
                                      context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
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
