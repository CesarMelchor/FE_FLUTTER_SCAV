import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/pages/credencializacion/offline/funciones/excel.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/data/offline.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:scav/src/utils/mobile.dart'
    if (dart.library.html) 'package:scav/src/utils/web.dart';

class ListArtesanosOfflineScreen extends StatefulWidget {
  const ListArtesanosOfflineScreen({super.key});

  @override
  State<ListArtesanosOfflineScreen> createState() =>
      _ListArtesanosOfflineScreenState();
}

class _ListArtesanosOfflineScreenState
    extends State<ListArtesanosOfflineScreen> {
  TextEditingController buscar = TextEditingController();
  TextEditingController detailBaja = TextEditingController();

  String credencial = 'NO';
  bool generateCredencial = false;
  bool generateReporte = false;
  bool getRenovados = false;
  bool getNuevos = false;
  bool getSearch = false;
  bool bajaRegistro = false;
  bool altRegistro = false;

  String baja = 'NO';

  Dio dio = Dio();

  List artesanos = Offline.artesanosList;

  Future apiCredencial(data, imagen) async {
    if (data['id_organizacion'].toString().startsWith('OR') ||
        data['id_organizacion'].toString().startsWith('TF')) {
      _createPDFOrganizacion(data, imagen);
    } else {
      _createPDF(data, imagen);
    }
  }

  bool apiEntregarCredencial(id, BuildContext context) {
    var fecha = GlobalVariable.currentDate.split(" ");

     for (var i = 0; i < Offline.artesanosList.length; i++) {
      if (Offline.artesanosList[i]['id_artesano'] == id) {

        Offline.artesanosList[i]['fecha_entrega_credencial'] = fecha[0];

      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                    controller: buscar,
                    inputFormatters: [
                      CapitalLetters(),
                    ],
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {},
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {},
                            child: getSearch == false
                                ? const Icon(Icons.search)
                                : const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: CircularProgressIndicator(),
                                  )),
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Styles.rojo),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        floatingLabelStyle: TextStyle(
                            color: Styles.rojo, fontWeight: FontWeight.bold),
                        label: const Text('FOLIO, NOMBRE, CURP O MUNICIPIO')),
                  ),
                ),
                SizedBox(
                  width: Adaptive.w(2),
                ),
                Expanded(child: Container()),
                ElevatedButton.icon(
                    icon: const Icon(Icons.format_list_bulleted),
                    style: Styles.buttonBothBorders,
                    onPressed: () {
                      ExcelFunciones.createExcel();
                      ExcelFunciones.createExcelOrganizaciones();
                    },
                    label: Text(
                      "DESCARGAR DATOS",
                      style: TextStyle(fontSize: Adaptive.sp(11)),
                    )),
                SizedBox(
                  width: Adaptive.w(2),
                ),
                ElevatedButton.icon(
                    icon: const Icon(Icons.format_list_bulleted),
                    style: Styles.buttonBothBorders,
                    onPressed: () {
                      Navigator.of(context).pushNamed("organizaciones");
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
                        color: Styles.crema2,
                        fontSize: Adaptive.sp(12),
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
                    "VIGENCIA DE CREDENCIAL",
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
                    "FECHA DE ENTREGA",
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
            for (var item in artesanos)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Adaptive.w(1)),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      SizedBox(
                          width: Adaptive.w(20),
                          child: Text(
                            item['id_artesano'],
                            style: TextStyle(
                                color: Styles.crema2,
                                fontSize: Adaptive.sp(12),
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
                            "2022-2028",
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
                            item['fecha_entrega_credencial'] ?? 'Sin fecha',
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
                            ElevatedButton.icon(
                                style: Styles.buttonViewEditArt,
                                onPressed: () {
                                  setState(() {
                                    GlobalVariable.idArtesanoEditCred =
                                        item['id_artesano'];
                                  });

                                  Navigator.of(context)
                                      .pushNamed("viewEditArtesano");
                                },
                                icon: const Icon(Icons.edit),
                                label: Text(
                                  "VER Y EDITAR INFORMACION",
                                  style: TextStyle(fontSize: Adaptive.sp(11)),
                                )),
                            SizedBox(
                              width: Adaptive.w(2),
                            ),
                            IconButton(
                                tooltip: "CREDENCIAL PDF CON IMAGEN",
                                onPressed: () {
                                  apiCredencial(item, true);
                                },
                                icon: Icon(
                                  Icons.picture_as_pdf,
                                  color: Styles.rojo,
                                )),
                            IconButton(
                                tooltip: "CREDENCIAL PDF EN TEXTO",
                                onPressed: () {
                                  apiCredencial(item, false);
                                },
                                icon: Icon(
                                  Icons.document_scanner,
                                  color: Styles.rojo,
                                )),
                            SizedBox(
                              width: Adaptive.w(2),
                            ),
                            Text("ENTREGA CREDENCIAL",
                                style: TextStyle(
                                    fontSize: Adaptive.sp(12),
                                    color: Styles.crema2,
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
                                style: TextStyle(fontSize: Adaptive.sp(11))),
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
                                style: TextStyle(fontSize: Adaptive.sp(11))),
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
    );
  }

  _entregaCredencial(BuildContext context, item) async {
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
                              onPressed: () {
                                apiEntregarCredencial(
                                    item['id_artesano'], context);
                                Navigator.pop(context);
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
  var idartesano = data['id_artesano'].toString();
  var idramaartesano = "";
  var rama = "";
  for (var i = 0; i < Offline.ramaArtesanosList.length; i++) {
    if (Offline.ramaArtesanosList[i]['id_artesano'] == idartesano) {
      idramaartesano = Offline.ramas[i]['id_rama'].toString();
    }
  }

  for (var i = 0; i < Offline.ramas.length; i++) {
    if (Offline.ramas[i]['id_rama'] == idramaartesano) {
      rama = Offline.ramas[i]['nombre_rama'].toString();
    }
  }

  var idlocalidad = data['id_localidad'].toString();
  var localidadT = "";
  for (var i = 0; i < Offline.localidades.length; i++) {
    if (Offline.localidades[i]['id_localidad'] == idlocalidad) {
      localidadT = Offline.localidades[i]['localidad'].toString();
    }
  }

  var idmunicipio = data['id_municipio'].toString();
  var municipioT = "";
  for (var i = 0; i < Offline.municipios.length; i++) {
    if (Offline.municipios[i]['id_municipio'] == idmunicipio) {
      municipioT = Offline.municipios[i]['municipio'].toString();
    }
  }

  var idregion = data['id_region'].toString();
  var regionT = "";
  for (var i = 0; i < Offline.regiones.length; i++) {
    if (Offline.regiones[i]['id_region'] == idregion) {
      regionT = Offline.regiones[i]['region'].toString();
    }
  }

  if (imagen == true) {
    final PdfDocument document = PdfDocument(
        inputBytes: await _readData('credencial_img_individual.pdf'));

    final PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
    // ignore: prefer_interpolation_to_compose_strings
    name.text = data['nombre'].toString() +
        ' ' +
        data['primer_apellido'].toString() +
        " " +
        data['segundo_apellido'].toString();

    var per = "";
    if (data['sexo'] == 'H') {
      per = "PERSONA ARTESANA PRODUCTORA DE ";
    } else {
      per = "PERSONA ARTESANA PRODUCTOR DE ";
    }

    final PdfTextBoxField texto = document.form.fields[1] as PdfTextBoxField;
    texto.text = per + rama;

    final PdfTextBoxField inscripcion =
        document.form.fields[2] as PdfTextBoxField;
    inscripcion.text = data['gpo_pertenencia'].toString();
    final PdfTextBoxField domicilio =
        document.form.fields[3] as PdfTextBoxField;
    domicilio.text =
        "${data['calle'].toString()} ${data['num_exterior'].toString()} ${data['num_interior'].toString()}";
    final PdfTextBoxField localidad =
        document.form.fields[4] as PdfTextBoxField;
    localidad.text = localidadT;
    final PdfTextBoxField municipio =
        document.form.fields[5] as PdfTextBoxField;
    municipio.text = municipioT;
    final PdfTextBoxField region = document.form.fields[6] as PdfTextBoxField;
    region.text = regionT;
    final PdfTextBoxField cp = document.form.fields[7] as PdfTextBoxField;
    cp.text = data['cp'].toString();
    final PdfTextBoxField telefono = document.form.fields[8] as PdfTextBoxField;
    telefono.text = data['tel_celular'].toString();
    final PdfTextBoxField ine = document.form.fields[9] as PdfTextBoxField;
    ine.text = data['clave_ine'].toString();
    final PdfTextBoxField curp = document.form.fields[10] as PdfTextBoxField;
    curp.text = data['curp'].toString();
    var fechad = data['created_at'];
    fechad = fechad.split(" ");
    final PdfTextBoxField fecha = document.form.fields[11] as PdfTextBoxField;
    fecha.text = fechad[0];
    final PdfTextBoxField idartesano =
        document.form.fields[12] as PdfTextBoxField;
    idartesano.text = data['id_artesano'].toString();

    List<int> bytes = await document.save();
    document.dispose();
    // ignore: prefer_interpolation_to_compose_strings
    saveAndLaunchFile(bytes, "${"Credencial_" + data['id_artesano']}.pdf");
  } else {
    final PdfDocument document =
        PdfDocument(inputBytes: await _readData('credencial_individual.pdf'));

    final PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
    // ignore: prefer_interpolation_to_compose_strings
    name.text = data['nombre'].toString() +
        ' ' +
        data['primer_apellido'].toString() +
        " " +
        data['segundo_apellido'].toString();

    var per = "";
    if (data['sexo'] == 'H') {
      per = "PERSONA ARTESANA PRODUCTORA DE ";
    } else {
      per = "PERSONA ARTESANA PRODUCTOR DE ";
    }

    final PdfTextBoxField texto = document.form.fields[1] as PdfTextBoxField;
    texto.text = per + rama;

    final PdfTextBoxField inscripcion =
        document.form.fields[2] as PdfTextBoxField;
    inscripcion.text = data['gpo_pertenencia'].toString();
    final PdfTextBoxField domicilio =
        document.form.fields[3] as PdfTextBoxField;
    domicilio.text =
        "${data['calle'].toString()} ${data['num_exterior'].toString()} ${data['num_interior'].toString()}";
    final PdfTextBoxField localidad =
        document.form.fields[4] as PdfTextBoxField;
    localidad.text = localidadT;
    final PdfTextBoxField municipio =
        document.form.fields[5] as PdfTextBoxField;
    municipio.text = municipioT;
    final PdfTextBoxField region = document.form.fields[6] as PdfTextBoxField;
    region.text = regionT;
    final PdfTextBoxField cp = document.form.fields[7] as PdfTextBoxField;
    cp.text = data['cp'].toString();
    final PdfTextBoxField telefono = document.form.fields[8] as PdfTextBoxField;
    telefono.text = data['tel_celular'].toString();
    final PdfTextBoxField ine = document.form.fields[9] as PdfTextBoxField;
    ine.text = data['clave_ine'].toString();
    final PdfTextBoxField curp = document.form.fields[10] as PdfTextBoxField;
    curp.text = data['curp'].toString();
    var fechad = data['created_at'];
    fechad = fechad.split(" ");
    final PdfTextBoxField fecha = document.form.fields[11] as PdfTextBoxField;
    fecha.text = fechad[0].toString();
    final PdfTextBoxField idartesano =
        document.form.fields[12] as PdfTextBoxField;
    idartesano.text = data['id_artesano'].toString();

    List<int> bytes = await document.save();
    document.dispose();
    // ignore: prefer_interpolation_to_compose_strings
    saveAndLaunchFile(bytes, "${"Credencial_" + data['id_artesano']}.pdf");
  }
}

Future<void> _createPDFOrganizacion(data, imagen) async {
  var idartesano = data['id_artesano'].toString();
  var idramaartesano = "";
  var rama = "";
  for (var i = 0; i < Offline.ramaArtesanosList.length; i++) {
    if (Offline.ramaArtesanosList[i]['id_artesano'] == idartesano) {
      idramaartesano = Offline.ramas[i]['id_rama'].toString();
    }
  }

  for (var i = 0; i < Offline.ramas.length; i++) {
    if (Offline.ramas[i]['id_rama'] == idramaartesano) {
      rama = Offline.ramas[i]['nombre_rama'].toString();
    }
  }

  var idlocalidad = data['id_localidad'].toString();
  var localidadT = "";
  for (var i = 0; i < Offline.localidades.length; i++) {
    if (Offline.localidades[i]['id_localidad'] == idlocalidad) {
      localidadT = Offline.localidades[i]['localidad'].toString();
    }
  }

  var idmunicipio = data['id_municipio'].toString();
  var municipioT = "";
  for (var i = 0; i < Offline.municipios.length; i++) {
    if (Offline.municipios[i]['id_municipio'] == idmunicipio) {
      municipioT = Offline.municipios[i]['municipio'].toString();
    }
  }

  var idregion = data['id_region'].toString();
  var regionT = "";
  for (var i = 0; i < Offline.regiones.length; i++) {
    if (Offline.regiones[i]['id_region'] == idregion) {
      regionT = Offline.regiones[i]['region'].toString();
    }
  }

  if (imagen == true) {
    final PdfDocument document =
        PdfDocument(inputBytes: await _readData('credencial_img_org.pdf'));

    final PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
    name.text = data['nombre'] +
        ' ' +
        data['primer_apellido'] +
        " " +
        data['segundo_apellido'];

    var per = "";
    if (data['sexo'].toString() == 'H') {
      per = "PERSONA ARTESANA PRODUCTORA DE ";
    } else {
      per = "PERSONA ARTESANA PRODUCTOR DE ";
    }

    final PdfTextBoxField texto = document.form.fields[1] as PdfTextBoxField;
    texto.text = per + rama;

    final PdfTextBoxField inscripcion =
        document.form.fields[2] as PdfTextBoxField;
    inscripcion.text = data['gpo_pertenencia'].toString();
    final PdfTextBoxField organizacion =
        document.form.fields[3] as PdfTextBoxField;
    organizacion.text = data['id_organizacion'].toString();
    final PdfTextBoxField domicilio =
        document.form.fields[4] as PdfTextBoxField;
    domicilio.text =
        "${data['calle']} ${data['num_exterior']} ${data['num_interior']}";
    final PdfTextBoxField localidad =
        document.form.fields[5] as PdfTextBoxField;
    localidad.text = localidadT;
    final PdfTextBoxField municipio =
        document.form.fields[6] as PdfTextBoxField;
    municipio.text = municipioT;
    final PdfTextBoxField region = document.form.fields[7] as PdfTextBoxField;
    region.text = regionT;
    final PdfTextBoxField cp = document.form.fields[8] as PdfTextBoxField;
    cp.text = data['cp'].toString();
    final PdfTextBoxField telefono = document.form.fields[9] as PdfTextBoxField;
    telefono.text = data['tel_celular'].toString();
    final PdfTextBoxField ine = document.form.fields[10] as PdfTextBoxField;
    ine.text = data['clave_ine'].toString();
    final PdfTextBoxField curp = document.form.fields[11] as PdfTextBoxField;
    curp.text = data['curp'].toString();
    var fechad = data['created_at'];
    fechad = fechad.split(" ");
    final PdfTextBoxField fecha = document.form.fields[12] as PdfTextBoxField;
    fecha.text = fechad[0];
    final PdfTextBoxField idartesano =
        document.form.fields[13] as PdfTextBoxField;
    idartesano.text = data['id_artesano'].toString();

    List<int> bytes = await document.save();
    document.dispose();
    // ignore: prefer_interpolation_to_compose_strings
    saveAndLaunchFile(bytes, "${"Credencial_" + data['id_artesano']}.pdf");
  } else {
    final PdfDocument document =
        PdfDocument(inputBytes: await _readData('credencial_org.pdf'));

    final PdfTextBoxField name = document.form.fields[0] as PdfTextBoxField;
    name.text = data['nombre'] +
        ' ' +
        data['primer_apellido'] +
        " " +
        data['segundo_apellido'];

    var per = "";
    if (data['sexo'] == 'H') {
      per = "PERSONA ARTESANA PRODUCTORA DE ";
    } else {
      per = "PERSONA ARTESANA PRODUCTOR DE ";
    }

    final PdfTextBoxField texto = document.form.fields[1] as PdfTextBoxField;
    texto.text = per + rama;

    final PdfTextBoxField inscripcion =
        document.form.fields[2] as PdfTextBoxField;
    inscripcion.text = data['gpo_pertenencia'];
    final PdfTextBoxField organizacion =
        document.form.fields[3] as PdfTextBoxField;
    organizacion.text = data['id_organizacion'];
    final PdfTextBoxField domicilio =
        document.form.fields[4] as PdfTextBoxField;
    domicilio.text =
        data['calle'] + " " + data['num_exterior'] + " " + data['num_interior'];
    final PdfTextBoxField localidad =
        document.form.fields[5] as PdfTextBoxField;
    localidad.text = localidadT;
    final PdfTextBoxField municipio =
        document.form.fields[6] as PdfTextBoxField;
    municipio.text = municipioT;
    final PdfTextBoxField region = document.form.fields[7] as PdfTextBoxField;
    region.text = regionT;
    final PdfTextBoxField cp = document.form.fields[8] as PdfTextBoxField;
    cp.text = data['cp'];
    final PdfTextBoxField telefono = document.form.fields[9] as PdfTextBoxField;
    telefono.text = data['tel_celular'];
    final PdfTextBoxField ine = document.form.fields[10] as PdfTextBoxField;
    ine.text = data['clave_ine'];
    final PdfTextBoxField curp = document.form.fields[11] as PdfTextBoxField;
    curp.text = data['curp'];
    var fechad = data['created_at'];
    fechad = fechad.split(" ");
    final PdfTextBoxField fecha = document.form.fields[12] as PdfTextBoxField;
    fecha.text = fechad[0];
    final PdfTextBoxField idartesano =
        document.form.fields[13] as PdfTextBoxField;
    idartesano.text = data['id_artesano'];
    List<int> bytes = await document.save();
    document.dispose();
    // ignore: prefer_interpolation_to_compose_strings
    saveAndLaunchFile(bytes, "${"Credencial_" + data['id_artesano']}.pdf");
  }
}

Future<List<int>> _readData(String name) async {
  final ByteData data = await rootBundle.load('assets/pdf/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
