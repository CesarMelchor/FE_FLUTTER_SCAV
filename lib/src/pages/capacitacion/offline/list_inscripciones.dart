import 'dart:typed_data';
import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/pages/credencializacion/offline/funciones/excel.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/data/offline.dart';
import 'package:scav/src/utils/data/offline_capacitacion.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:scav/src/utils/mobile.dart'
    if (dart.library.html) 'package:scav/src/utils/web.dart';

class ListInscripcionesOfflineScreen extends StatefulWidget {
  const ListInscripcionesOfflineScreen({super.key});

  @override
  State<ListInscripcionesOfflineScreen> createState() =>
      _ListInscripcionesOfflineScreenState();
}

class _ListInscripcionesOfflineScreenState
    extends State<ListInscripcionesOfflineScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController buscarRegisters = TextEditingController();
  TextEditingController observaciones = TextEditingController();
  TextEditingController solicitud = TextEditingController();
  TextEditingController accion = TextEditingController();
  TextEditingController accionConstancia = TextEditingController();
  TextEditingController rama = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController etnia = TextEditingController();
  TextEditingController programa = TextEditingController();

  TextEditingController solicitudE = TextEditingController();
  TextEditingController observacionesE = TextEditingController();
  TextEditingController formatoController = TextEditingController();
  bool searching = false;
  bool agregando = false;
  bool editando = false;
  bool creating = false;
  bool creatingFile = false;
  String formato = "";
  String accioid = "";
  String idartesano = "";
  String inscripcionIdE = "";
  String ramaB = "";
  String municipioB = "";
  String regionB = "";
  String etniaB = "";
  String programaB = "";
  String nombreB = "";
  String nombreAccion = "";
  String capacitadorAccion = "";
  String annioAccion = "";
  String trimestreid = "";
  String trimestreAccion = "";

  String textoConstanciaPDF = "";
  String capacitador2C = "";
  String cargo2C = "";

  List programas = OfflineDataCapacitacion.programas;
  List municipios = Offline.municipios;
  List regiones = Offline.regiones;
  List ramas = Offline.ramas;
  List etnias = Offline.gruposEtnicos;
  List inscripcionesOffline = [];
  List inscripcionesView = [];
  String artesanoEdit = "";
  String accionEdit = "";

  Response addInscripcion = Response(requestOptions: RequestOptions());
  Response editInscripcion = Response(requestOptions: RequestOptions());
  Response constancia = Response(requestOptions: RequestOptions());
  Response acciones = Response(requestOptions: RequestOptions());
  Response inscripciones = Response(requestOptions: RequestOptions());
  Response artesanos = Response(requestOptions: RequestOptions());

  var nombreC = "";
  var capacitadorC = "";
  var capacitacionC = "";
  var cargoC = "";
  var artesano = "";
  var idAccion = "";

  void idAccionSelectedConstancia(String nombreAccion) {
    for (var i = 0; i < acciones.data.length; i++) {
      if (acciones.data[i]['nombre'] == nombreAccion) {
        setState(() {

          idAccion = acciones.data[i]['id'];
          accionSeleccionada = acciones.data[i]['id'];
          capacitadorAccion = acciones.data[i]['capacitador'];
          annioAccion = acciones.data[i]['annio'];
          trimestreAccion = acciones.data[i]['id_trimestre'];

          capacitacionC = acciones.data[i]['nombre'];
          cargoC = acciones.data[i]['cargo'];
          capacitadorC = acciones.data[i]['capacitador'];
          capacitador2C = acciones.data[i]['capacitador2'];
          cargo2C = acciones.data[i]['cargo2'];
          textoConstanciaPDF = acciones.data[i]['texto_constancia'];
        });
      }
    }

    inscripcionesView = OfflineDataCapacitacion.inscripcionesOffline
        .where((i) => i['id_accion'] == idAccion)
        .toList();
  }

  bool editAccionOffline(String accion, String artesano) {
    bool res = false;
    for (var i = 0;
        i < OfflineDataCapacitacion.inscripcionesOffline.length;
        i++) {
      if (OfflineDataCapacitacion.inscripcionesOffline[i]['id_artesano'] ==
              artesano &&
          OfflineDataCapacitacion.inscripcionesOffline[i]['id_accion'] ==
              accion) {
        setState(() {
          OfflineDataCapacitacion.inscripcionesOffline[i]['solicitud'] =
              solicitudE.text;
          OfflineDataCapacitacion.inscripcionesOffline[i]['observaciones'] =
              observacionesE.text;
          solicitudE = TextEditingController();
          observacionesE = TextEditingController();
        });
        res = true;
      } else {
        res = false;
      }
    }
    return res;
  }

  Future artesanosConstancias() async {
    setState(() {
      creating = true;
    });

    artesanos = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/acciones/offline/artesanos',
        queryParameters: {'accion': idAccion});

    _createConstancias(artesanos, formato);

    setState(() {
      creating = false;
    });

    return artesanos.data;
  }

  Future<bool> apiAddInscripcion(BuildContext context) async {
    var newInscripcion = {
      "id_artesano": idartesano,
      "solicitud": solicitud.text,
      "observaciones": observaciones.text,
      "id_accion": accioid,
      "created_at": GlobalVariable.currentDate,
      "updated_at": GlobalVariable.currentDate,
    };

    addInscripcion = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/inscripciones/offline/agregar',
        queryParameters: {
          "id_artesano": idartesano,
          "solicitud": solicitud.text,
          "observaciones": observaciones.text,
          "id_accion": accioid,
          "created_at": GlobalVariable.currentDate,
          "updated_at": GlobalVariable.currentDate,
        });

    if (addInscripcion.statusCode == 200) {
      setState(() {
        OfflineDataCapacitacion.inscripcionesOffline.add(newInscripcion);
        buscar.text = '';
        accioid = '';
        idartesano = '';
        accion = TextEditingController();
        solicitud = TextEditingController();
        observaciones = TextEditingController();
      });

      return true;
    } else {
      setState(() {
        buscar.text = '';
        accioid = '';
        idartesano = '';
        accion = TextEditingController();
        solicitud = TextEditingController();
        observaciones = TextEditingController();
      });
      return false;
    }
  }

  String registros = "";
  Future apiGetInscripciones() async {
    inscripciones = await dio
        .get('${GlobalVariable.baseUrlApi}scav/v1/inscripciones/excel');

    for (var i = 0; i < inscripciones.data.length; i++) {
      OfflineDataCapacitacion.inscripcionesOffline.add(inscripciones.data[i]);
    }

    inscripcionesView = OfflineDataCapacitacion.inscripcionesOffline;

    return inscripciones;
  }

  @override
  void initState() {
    super.initState();
    apiGetInscripciones();
  }

  Future apiGetAcciones() async {
    acciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/acciones/excel');

    return acciones.data;
  }

  void idAccionSelected(accion, lista) {
    for (var i = 0; i < lista.data.length; i++) {
      if (lista.data[i]['nombre'] == accion) {
        setState(() {
          accioid = lista.data[i]['id'];
          accionSeleccionada = lista.data[i]['nombre'];
        });
      }
    }
  }

  String accionSeleccionada = "";

  Response resultSearch = Response(requestOptions: RequestOptions());

  Future apiSearchRegisters(BuildContext context) async {}

  Dio dio = Dio();

  Future apiGetArtesanoByCurp(BuildContext context) async {
    setState(() {
      searching = true;
    });

    resultSearch = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/artesano/offline/data',
        queryParameters: {"curp": buscar.text});

    if (resultSearch.statusCode == 200) {
      // ignore: use_build_context_synchronously
      _createInscripcion(context);
    } else {
      // ignore: use_build_context_synchronously
      Message()
          .mensaje(Colors.amber, Icons.warning, 'CURP no encontrada', context);
    }
    setState(() {
      idartesano = resultSearch.data['id_artesano'];
      searching = false;
    });
    return resultSearch.data;
  }

  late final Future getAcciones = apiGetAcciones();
  late final Future getInscripciones = apiGetInscripciones();

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
                            width: Adaptive.w(15),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                              future: getAcciones,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                return snapshot.hasData
                                    ? Tooltip(
                                        message:
                                            'ID : $accionSeleccionada     Capacitador: $capacitadorAccion       Año: $annioAccion        Trimestre: $trimestreAccion',
                                        child: CustomDropDownII.search(
                                          hintStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          listItemStyle: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          controller: accionConstancia,
                                          hintText: 'ACCIONES',
                                          selectedStyle: TextStyle(
                                              color: Styles.rojo,
                                              fontSize: Adaptive.sp(9)),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idAccionSelectedConstancia(p0);
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item in acciones.data)
                                              item['nombre']
                                          ],
                                        ),
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
                            width: Adaptive.w(20),
                            height: Adaptive.h(5),
                            child: CustomDropDownII.search(
                              hintStyle: TextStyle(
                                fontSize: Adaptive.sp(11),
                              ),
                              listItemStyle: TextStyle(
                                fontSize: Adaptive.sp(11),
                              ),
                              controller: formatoController,
                              hintText: 'Formato',
                              selectedStyle: TextStyle(
                                  color: Styles.rojo, fontSize: Adaptive.sp(9)),
                              errorText: 'Sin resultados',
                              onChanged: (p0) {
                                switch (p0) {
                                  case 'GENERAL':
                                    formato =
                                        'CONSTANCIA_GENERICO_VERSION1.pdf';
                                    break;
                                  case 'DEPARTAMENTAL':
                                    formato =
                                        'CONSTANCIA_GENERICO_VERSION2.pdf';
                                    break;

                                  case 'CAPACITADORES':
                                    formato =
                                        'CONSTANCIA_GENERICO_VERSION3.pdf';
                                    break;
                                  default:
                                }
                              },
                              borderSide: BorderSide(color: Styles.rojo),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              items: const [
                                'GENERAL',
                                'DEPARTAMENTAL',
                                'CAPACITADORES'
                              ],
                            ),
                          ),
 SizedBox(
                            width: Adaptive.w(2),
                          ),
                          OutlinedLoadingButton(
                              isLoading: creating,
                              style: Styles().buttonSearchArtesanos(context),
                              loadingIcon: const Icon(Icons.picture_as_pdf),
                              loadingLabel: const Text('Generando...'),
                              onPressed: () async {
                                
                                  if (idAccion == '') {
                                    Message().mensaje(
                                        Colors.yellow,
                                        Icons.warning,
                                        'SELECCIONA UNA ACCION',
                                        context);
                                  } else {
                                    if (formato == '') {
                                      Message().mensaje(
                                          Colors.yellow,
                                          Icons.warning,
                                          'SELECCIONA UN FORMATO',
                                          context);
                                    } else {
                                      artesanosConstancias();
                                    }
                                  }
                              },
                              child: Text(
                                "GENERAR CONSTANCIAS",
                                style: TextStyle(fontSize: Adaptive.sp(12)),
                              )),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          OutlinedLoadingButton(
                              isLoading: creatingFile,
                              style: Styles().buttonSearchArtesanos(context),
                              loadingIcon: const Icon(Icons.file_download),
                              loadingLabel: const Text('Generando...'),
                              onPressed: () async {
                                setState(() {
                                  creatingFile = true;
                                });
                                ExcelFunciones.createExcelInscripciones();

                                setState(() {
                                  creatingFile = false;
                                });
                              },
                              child: Text(
                                "GENERAR ARCHIVOS",
                                style: TextStyle(fontSize: Adaptive.sp(12)),
                              )),
                              Expanded(child: Container()),
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
                                      child: searching == false
                                          ? Icon(
                                              Icons.person_add_alt,
                                              color: Styles.rojo,
                                            )
                                          : const CircularProgressIndicator()),
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
                                    style: TextStyle(fontSize: Adaptive.sp(11)),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: Adaptive.w(2),
                          )
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
                                  "ID ARTESANO",
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
                                  "ID ACCION",
                                  style: TextStyle(
                                      fontSize: Adaptive.sp(11),
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(
                              width: Adaptive.w(1),
                            ),
                            SizedBox(
                                width: Adaptive.w(17),
                                child: Text(
                                  "FECHA DE INSCRIPCIÓN",
                                  style: TextStyle(
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
                          for (var item in inscripcionesView)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Adaptive.w(1)),
                              child: ExpansionTile(
                                title: Row(
                                  children: [
                                    SizedBox(
                                        width: Adaptive.w(20),
                                        child: Text(
                                          item['id_artesano'] ?? '',
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
                                          item['id_accion'] ?? '',
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(11),
                                              fontWeight: FontWeight.w600),
                                        )),
                                    SizedBox(
                                      width: Adaptive.w(1),
                                    ),
                                    SizedBox(
                                        width: Adaptive.w(17),
                                        child: Text(
                                          item['created_at'] ?? '',
                                          style: TextStyle(
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
      },
    );
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
                height: Adaptive.h(65),
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
                    SizedBox(
                      width: Adaptive.w(30),
                      child: FutureBuilder(
                        future: getAcciones,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          return snapshot.hasData
                              ? CustomDropDownII.search(
                                  controller: accion,
                                  hintText: 'ACCIONES',
                                  selectedStyle: TextStyle(color: Styles.rojo),
                                  errorText: 'Sin resultados',
                                  onChanged: (p0) {
                                    idAccionSelected(p0, acciones);
                                  },
                                  borderSide: BorderSide(color: Styles.rojo),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  items: [
                                    for (var item in acciones.data)
                                      item['nombre']
                                  ],
                                )
                              : const LinearProgressIndicator();
                        },
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
                                if (await apiAddInscripcion(context)) {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(Colors.green, Icons.done,
                                      'Inscripcion realizada', context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.amber,
                                      Icons.warning,
                                      'No fue posible agregar el registro',
                                      context);
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

  Future<void> _createConstancias(artesanos, formato) async {
    switch (formato) {
      case 'CONSTANCIA_GENERICO_VERSION1.pdf':
        for (var i = 0; i < artesanos.data.length; i++) {
          final PdfDocument document =
              PdfDocument(inputBytes: await _readData(formato));
          final PdfTextBoxField capacitacion =
              document.form.fields[1] as PdfTextBoxField;
          capacitacion.text = capacitacionC;

          final PdfTextBoxField capacitador =
              document.form.fields[2] as PdfTextBoxField;
          capacitador.text = capacitadorC;
          final PdfTextBoxField cargo =
              document.form.fields[3] as PdfTextBoxField;
          cargo.text = cargoC;

          final PdfTextBoxField textoConstancia =
              document.form.fields[4] as PdfTextBoxField;
          textoConstancia.text = textoConstanciaPDF;

          final PdfTextBoxField name =
              document.form.fields[0] as PdfTextBoxField;
          name.text = artesanos.data[i]['nombre'];

          List<int> bytes = await document.save();
          document.dispose();
          saveAndLaunchFile(
              bytes,
              // ignore: prefer_interpolation_to_compose_strings
              "${"Constancia_" + artesanos.data[i]['curp']}.pdf");
        }

        break;

      case 'CONSTANCIA_GENERICO_VERSION2.pdf':
        for (var i = 0; i < artesanos.data.length; i++) {
          final PdfDocument document =
              PdfDocument(inputBytes: await _readData(formato));

          final PdfTextBoxField capacitacion =
              document.form.fields[2] as PdfTextBoxField;
          capacitacion.text = capacitacionC;

          final PdfTextBoxField capacitador =
              document.form.fields[3] as PdfTextBoxField;
          capacitador.text = capacitadorC;
          final PdfTextBoxField cargo =
              document.form.fields[4] as PdfTextBoxField;
          cargo.text = cargoC;

          final PdfTextBoxField textoConstancia =
              document.form.fields[1] as PdfTextBoxField;
          textoConstancia.text = textoConstanciaPDF;

          final PdfTextBoxField name =
              document.form.fields[0] as PdfTextBoxField;
          name.text = artesanos.data[i]['nombre'];

          List<int> bytes = await document.save();
          document.dispose();
          saveAndLaunchFile(
              bytes,
              // ignore: prefer_interpolation_to_compose_strings
              "${"Constancia_" + artesanos.data[i]['curp']}.pdf");
        }
        break;

      case 'CONSTANCIA_GENERICO_VERSION3.pdf':
        for (var i = 0; i < artesanos.data.length; i++) {
          final PdfDocument document =
              PdfDocument(inputBytes: await _readData(formato));

          final PdfTextBoxField name =
              document.form.fields[0] as PdfTextBoxField;
          name.text = artesanos.data[i]['nombre'];

          final PdfTextBoxField textoConstancia =
              document.form.fields[1] as PdfTextBoxField;
          textoConstancia.text = textoConstanciaPDF;

          final PdfTextBoxField capacitacion =
              document.form.fields[2] as PdfTextBoxField;
          capacitacion.text = capacitacionC;

          final PdfTextBoxField capacitador =
              document.form.fields[3] as PdfTextBoxField;
          capacitador.text = capacitadorC;
          final PdfTextBoxField cargo =
              document.form.fields[4] as PdfTextBoxField;
          cargo.text = cargoC;

          final PdfTextBoxField capacitador2 =
              document.form.fields[5] as PdfTextBoxField;
          capacitador2.text = capacitador2C;

          final PdfTextBoxField cargo2 =
              document.form.fields[6] as PdfTextBoxField;
          cargo2.text = cargo2C;

          List<int> bytes = await document.save();
          document.dispose();
          saveAndLaunchFile(
              bytes,
              // ignore: prefer_interpolation_to_compose_strings
              "${"Constancia_" + artesanos.data[i]['curp']}.pdf");
        }
        break;
      default:
    }
  }

  Future<List<int>> _readData(String name) async {
    final ByteData data = await rootBundle.load('assets/pdf/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
