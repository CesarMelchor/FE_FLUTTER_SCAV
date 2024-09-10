import 'package:custom_dropdown_2/custom_dropdown2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/pages/credencializacion/add_new/utils/functions_add_artesano.dart';
import 'package:scav/src/pages/credencializacion/add_new/utils/variables_add_artesano.dart';
import 'package:scav/src/providers/credenciales_provider.dart';
import 'package:scav/src/utils/capital_letters.dart';
import 'package:scav/src/utils/data/offline.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:scav/src/utils/variables.dart';

class ViewEditArtesanoOfflineScreen extends StatefulWidget {
  const ViewEditArtesanoOfflineScreen({super.key});

  @override
  State<ViewEditArtesanoOfflineScreen> createState() =>
      _ViewEditArtesanoOfflineScreenState();
}

class _ViewEditArtesanoOfflineScreenState
    extends State<ViewEditArtesanoOfflineScreen> {
  TextEditingController nombre = TextEditingController();
  TextEditingController paterno = TextEditingController();
  TextEditingController materno = TextEditingController();
  TextEditingController nacimiento = TextEditingController();
  TextEditingController sexo = TextEditingController();
  TextEditingController estadoCivil = TextEditingController();
  TextEditingController curp = TextEditingController();
  TextEditingController claveElector = TextEditingController();
  TextEditingController rfc = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController escolaridad = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController distrito = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController localidad = TextEditingController();
  TextEditingController calle = TextEditingController();
  TextEditingController numExterior = TextEditingController();
  TextEditingController numInterior = TextEditingController();
  TextEditingController cp = TextEditingController();
  TextEditingController redesSociales = TextEditingController();
  TextEditingController etnia = TextEditingController();
  TextEditingController rama = TextEditingController();
  TextEditingController tecnica = TextEditingController();
  TextEditingController materiaPrima = TextEditingController();
  TextEditingController tipoComprador = TextEditingController();
  TextEditingController comentarios = TextEditingController();
  TextEditingController pertenece = TextEditingController();

  String sexoHi = "SEXO";
  String edoCivilHi = "ESTADO CIVIL";
  String escolaridadHi = "ESCOLARIDAD";
  String regionHi = "REGION";
  String municipioHi = "MUNICIPIO";
  String distritoHi = "DISTRITO";
  String localidadHi = "LOCALIDAD";
  String grupoHi = "GRUPO ETNICO";
  String ramaHi = "RAMA ARTESANAL";
  String lenguaHi = "";
  String productosHi = "PRODUCTOS ELABORADOS";
  String inscripcionHi = "TIPO DE INSCRIPCION";
  String materiaHi = "MATERIA PRIMA";
  String canalHi = "CANAL DE COMERCIALIZACION";
  String agrupacionHi = "AGRUPACION / TALLER";

  String sexoSe = "";
  String edoCivilSe = "";
  String escolaridadSe = "";
  String regionSe = "";
  String lenguaSe = "";
  String municipioSe = "";
  String distritoSe = "";
  String localidadSe = "";
  String fechaNacimiento = "";
  String grupoSe = "";
  String ramaSe = "";
  String productosSe = "";
  String inscripcionSe = "INDIVIDUAL";
  String materiaSe = "";
  String canalSe = "";
  String agrupacionSe = "";
  String estadoCivilSe = "";
  List<String> socialMedia = [];

  int indexEditing = 0;

  // ignore: prefer_typing_uninitialized_variables
  late var dataArtesano;
  var materia = "";
  var ramaT = "";
  var subrama = "";
  var tipoComp = "";
  var regionT = "";
  var municipioT = "";
  var localidadT = "";
  var distritoT = "";
  var etniaT = "";
  var lenguaT = "";
  var ramaI = "";
  var subramaI = "";
  var materiaI = "";
  var canalI = "";
  var lenguaI = "";
  bool getEditing = false;

  Future apigetArtesano() async {
    for (var i = 0; i < Offline.artesanosList.length; i++) {
      if (Offline.artesanosList[i]['id_artesano'] ==
          GlobalVariable.idArtesanoEditCred) {
        dataArtesano = Offline.artesanosList[i];

        if (dataArtesano['id_organizacion'].toString().startsWith('OR') ||
            dataArtesano['id_organizacion'].toString().startsWith('TF')) {
          for (var i = 0; i < Offline.organizaciones.length; i++) {
            if (Offline.organizaciones[i]['id_organizacion'] ==
                dataArtesano['id_organizacion']) {
              agrupacionHi = Offline.organizaciones[i]['nombre_organizacion'];
            }
          }
        }
      }
    }

    for (var i = 0; i < listMateriaPrimas.data.length; i++) {
      if (listMateriaPrimas.data[i]['id_materiap'] ==
          dataArtesano['id_materiaprima']) {
        materia = listMateriaPrimas.data[i]['nombre'];
      }
    }

    for (var i = 0; i < listRamas.data.length; i++) {
      if (listRamas.data[i]['id_rama'] == dataArtesano['id_rama']) {
        ramaT = listRamas.data[i]['nombre_rama'];
      }
    }

    for (var i = 0; i < listTecnicas.data.length; i++) {
      if (listTecnicas.data[i]['id_subrama'] == dataArtesano['id_tecnica']) {
        subrama = listTecnicas.data[i]['nombre_subrama'];
      }
    }

    for (var i = 0; i < listTipoCompradores.data.length; i++) {
      if (listTipoCompradores.data[i]['id_tipo_comprador'] ==
          dataArtesano['id_canal']) {
        tipoComp = listTipoCompradores.data[i]['nombre'];
      }
    }

    for (var i = 0; i < listRegiones.data.length; i++) {
      if (listRegiones.data[i]['id_region'] == dataArtesano['id_region']) {
        regionT = listRegiones.data[i]['region'];
      }
    }

    for (var i = 0; i < listMunicipios.data.length; i++) {
      if (listMunicipios.data[i]['id_municipio'] ==
          dataArtesano['id_municipio']) {
        municipioT = listMunicipios.data[i]['municipio'];
      }
    }

    for (var i = 0; i < listLocalidades.data.length; i++) {
      if (listLocalidades.data[i]['id_localidad'] ==
          dataArtesano['id_localidad']) {
        localidadT = listLocalidades.data[i]['localidad'];
      }
    }

    for (var i = 0; i < listDistritos.data.length; i++) {
      if (listDistritos.data[i]['id_distrito'] == dataArtesano['id_distrito']) {
        distritoT = listDistritos.data.distritos[i]['distrito'];
      }
    }

    for (var i = 0; i < listGrupos.data.length; i++) {
      if (listGrupos.data[i]['id_grupo'] == dataArtesano['id_grupo']) {
        etniaT = listGrupos.data[i]['nombre_etnia'];
      }
    }

    for (var i = 0; i < listLenguas.data.length; i++) {
      if (listLenguas.data[i]['id_lengua'] == dataArtesano['id_lengua']) {
        lenguaT = listLenguas.data[i]['lengua'];
      }
    }

    if (dataArtesano['sexo'] == 'H') {
      setState(() {
        sexoSe = 'Masculino';
      });
      sexoHi = 'Masculino';
    }
    if (dataArtesano['sexo'] == 'M') {
      setState(() {
        sexoSe = 'Femenino';
      });
      sexoHi = 'Femenino';
    }

    socialMedia = dataArtesano['redes_sociales'].toString().split('<');

    nombre.text = dataArtesano['nombre'];
    paterno.text = dataArtesano['primer_apellido'];
    materno.text = dataArtesano['segundo_apellido'];
    nacimiento.text = dataArtesano['fecha_nacimiento'];
    edoCivilHi = dataArtesano['edo_civil'] ?? '';
    curp.text = dataArtesano['curp'] ?? '';
    claveElector.text = dataArtesano['clave_ine'] ?? '';
    rfc.text = dataArtesano['rfc'] ?? '';
    escolaridadHi = dataArtesano['escolaridad'] ?? '';
    correo.text = dataArtesano['correo'] ?? '';
    telefono.text = dataArtesano['tel_fijo'] ?? '';
    celular.text = dataArtesano['tel_celular'] ?? '';
    calle.text = dataArtesano['calle'] ?? '';
    inscripcionHi = dataArtesano['gpo_pertenencia'] ?? '';

    materiaHi = materia;
    canalHi = tipoComp;
    ramaHi = ramaT;
    lenguaHi = lenguaT;
    productosHi = subrama;

    setState(() {
      inscripcionSe = dataArtesano['gpo_pertenencia'];
      sexoSe = dataArtesano['sexo'];
      edoCivilSe = dataArtesano['edo_civil'];
      escolaridadSe = dataArtesano['escolaridad'];
      regionSe = dataArtesano['id_region'];
      fechaNacimiento = dataArtesano['fecha_nacimiento'];
      edoCivilSe = dataArtesano['edo_civil'];
      distritoSe = dataArtesano['id_distrito'];
      municipioSe = dataArtesano['id_municipio'];
      localidadSe = dataArtesano['id_localidad'];
      regionHi = regionT;
      lenguaSe = dataArtesano['id_lengua'];
      grupoSe = dataArtesano['id_grupo'];
      agrupacionSe = dataArtesano['id_organizacion'];
      distritoHi = distritoT;
      municipioHi = municipioT;
      localidadHi = localidadT;
      grupoHi = etniaT;
      inscripcionHi = dataArtesano['gpo_pertenencia'];
      materiaHi = materia;
      canalHi = tipoComp;
    });

    numExterior.text = dataArtesano['num_exterior'];
    numInterior.text = dataArtesano['num_interior'];
    cp.text = dataArtesano['cp'];

    comentarios.text = dataArtesano['comentarios'];

    return dataArtesano;
  }

  bool apiUpdateArtesano(id, BuildContext context) {
    idElementUpdated(dataArtesano['nombre_rama'], listRamas.data, 'rama');
    idElementUpdated(
        dataArtesano['nombre_subrama'], listTecnicas.data, 'subrama');
    idElementUpdated(
        dataArtesano['materiap'], listMateriaPrimas.data, 'materia');
    idElementUpdated(
        dataArtesano['tipocomp'], listTipoCompradores.data, 'canal');

    var social =
        "${socialMedia[0]}<${socialMedia[1]}<${socialMedia[2]}<${socialMedia[3]}<${socialMedia[4]}";

    for (var i = 0; i < Offline.artesanosList.length; i++) {
      if (Offline.artesanosList[i]['id_artesano'] == id) {
        Offline.artesanosList[i]['nombre'] = nombre.text;
        Offline.artesanosList[i]['primer_apellido'] = paterno.text;
        Offline.artesanosList[i]['segundo_apellido'] = materno.text;
        Offline.artesanosList[i]['sexo'] = sexoSe;
        Offline.artesanosList[i]['fecha_nacimiento'] = fechaNacimiento;
        Offline.artesanosList[i]['edo_civil'] = estadoCivilSe;
        Offline.artesanosList[i]['curp'] = curp.text;
        Offline.artesanosList[i]['clave_ine'] = claveElector.text;
        Offline.artesanosList[i]['rfc'] = rfc.text;
        Offline.artesanosList[i]['calle'] = calle.text;
        Offline.artesanosList[i]['num_exterior'] = numExterior.text;
        Offline.artesanosList[i]['num_interior'] = numInterior.text;
        Offline.artesanosList[i]['cp'] = cp.text;
        Offline.artesanosList[i]['id_region'] = regionSe;
        Offline.artesanosList[i]['id_distrito'] = distritoSe;
        Offline.artesanosList[i]['id_municipio'] = municipioSe;
        Offline.artesanosList[i]['id_localidad'] = localidadSe;
        Offline.artesanosList[i]['tel_fijo'] = telefono.text;
        Offline.artesanosList[i]['tel_celular'] = celular.text;
        Offline.artesanosList[i]['correo'] = correo.text;
        Offline.artesanosList[i]['redes_sociales'] = social;
        Offline.artesanosList[i]['escolaridad'] = escolaridadSe;
        Offline.artesanosList[i]['id_grupo'] = grupoSe;
        Offline.artesanosList[i]['gpo_pertenencia'] = inscripcionSe;
        Offline.artesanosList[i]['id_organizacion'] = agrupacionSe;
        Offline.artesanosList[i]['comentarios'] = comentarios.text;
        Offline.artesanosList[i]['id_lengua'] = lenguaSe;
        Offline.artesanosList[i]['updated_at'] = GlobalVariable.currentDate;
        Offline.artesanosList[i]['id_rama'] = ramaSe;
        Offline.artesanosList[i]['id_tecnica'] = productosSe;
        Offline.artesanosList[i]['id_materiaprima'] = materiaSe;
        Offline.artesanosList[i]['id_canal'] = canalSe;
      }
    }

    FunctionAddArtesano.clean();
    // ignore: use_build_context_synchronously
    Message()
        .mensaje(Colors.green, Icons.done, 'Información actualizada', context);

    return true;
  }

  void idElementUpdated(element, lista, caso) {
    switch (caso) {
      case 'region':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['region'] == element) {
            setState(() {
              regionSe = lista[i]['id_region'];
            });
          }
        }
        break;

      case 'municipio':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['municipio'] == element) {
            setState(() {
              municipioSe = lista[i]['id_municipio'];
            });
          }
        }
        break;

      case 'distrito':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['distrito'] == element) {
            setState(() {
              distritoSe = lista[i]['id_distrito'];
            });
          }
        }
        break;

      case 'localidad':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['localidad'] == element) {
            setState(() {
              localidadSe = lista[i]['id_localidad'];
            });
          }
        }
        break;
      case 'grupo':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['nombre_etnia'] == element) {
            setState(() {
              grupoSe = lista[i]['id_grupo'];
            });
          }
        }
        break;
      case 'rama':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['nombre_rama'] == element) {
            setState(() {
              ramaSe = lista[i]['id_rama'];
            });
          }
        }
        break;
      case 'subrama':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['nombre_subrama'] == element) {
            setState(() {
              productosSe = lista[i]['id_subrama'];
            });
          }
        }
        break;
      case 'materia':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['nombre'] == element) {
            setState(() {
              materiaSe = lista[i]['id_materiap'];
            });
          }
        }
        break;
      case 'canal':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['nombre'] == element) {
            setState(() {
              canalSe = lista[i]['id_tipo_comprador'];
            });
          }
        }
        break;
        
      case 'lengua':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['lengua'] == element) {
            setState(() {
              lenguaSe = lista[i]['id_lengua'];
            });
          }
        }
        break;
      case 'agrupacion':
        for (var i = 0; i < lista.length; i++) {
          if (lista[i]['nombre_organizacion'] == element) {
            setState(() {
              agrupacionSe = lista[i]['id_organizacion'];
            });
          }
        }
        break;
      default:
    }
  }

  Response listLocalidades = Response(requestOptions: RequestOptions());
  Response listMunicipios = Response(requestOptions: RequestOptions());
  Response listLenguas = Response(requestOptions: RequestOptions());
  Response listDistritos = Response(requestOptions: RequestOptions());
  Response listRegiones = Response(requestOptions: RequestOptions());
  Response listRamas = Response(requestOptions: RequestOptions());
  Response listTecnicas = Response(requestOptions: RequestOptions());
  Response listGrupos = Response(requestOptions: RequestOptions());
  Response listTipoCompradores = Response(requestOptions: RequestOptions());
  Response listMateriaPrimas = Response(requestOptions: RequestOptions());
  Response listOrganizaciones = Response(requestOptions: RequestOptions());
  Response listTalleres = Response(requestOptions: RequestOptions());
  Response addTaller = Response(requestOptions: RequestOptions());
  Response addOrganizacion = Response(requestOptions: RequestOptions());
  Response addArtesano = Response(requestOptions: RequestOptions());
  Response addRamaArtesano = Response(requestOptions: RequestOptions());
  Response addCanalArtesano = Response(requestOptions: RequestOptions());
  Response addMateriaArtesano = Response(requestOptions: RequestOptions());

  Dio dio = Dio();

  Future apiGetMaterias() async {
    listMateriaPrimas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/materias/excel');

    return listMateriaPrimas.data;
  }

  Future apiGetOrganizaciones() async {
    listOrganizaciones = await dio
        .get('${GlobalVariable.baseUrlApi}scav/v1/organizaciones/excel');

    return listOrganizaciones.data;
  }

  Future apiGetTalleres() async {
    listTalleres = await dio
        .get('${GlobalVariable.baseUrlApi}scav/v1/organizaciones/excel');

    return listTalleres.data;
  }

  Future apiGetLenguas() async {
    listLenguas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/lenguas/excel');

    return listLenguas.data;
  }

  Future apiGetCompradores() async {
    listTipoCompradores =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/compradores/excel');

    return listTipoCompradores.data;
  }

  Future apiGetLocalidades() async {
    listLocalidades =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/localidades/excel');

    return listLocalidades.data;
  }

  Future apiGetMunicipios() async {
    listMunicipios =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/municipios/excel');

    return listMunicipios.data;
  }

  Future apiGetGrupos() async {
    listGrupos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/etnias/excel');

    return listGrupos.data;
  }

  Future apiGetDistritos() async {
    listDistritos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/distritos/excel');

    return listDistritos.data;
  }

  Future apiGetRegiones() async {
    listRegiones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/regiones/excel');

    return listRegiones.data;
  }

  Future apiGetRamas() async {
    listRamas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/ramas/excel');

    return listRamas.data;
  }

  Future apiGetTecnicas() async {
    listTecnicas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/tecnicas/excel');

    return listTecnicas.data;
  }

  late final Future getLocalidades = apiGetLocalidades();
  late final Future getDistritos = apiGetDistritos();
  late final Future getMunicipios = apiGetMunicipios();
  late final Future getRegiones = apiGetRegiones();
  late final Future getGrupos = apiGetGrupos();
  late final Future getRamas = apiGetRamas();
  late final Future getTecnicas = apiGetTecnicas();
  late final Future getMaterias = apiGetMaterias();
  late final Future getCompradores = apiGetCompradores();
  late final Future getOrganizaciones = apiGetOrganizaciones();
  late final Future getTalleres = apiGetTalleres();
  late final Future getLenguas = apiGetLenguas();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    apigetArtesano();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.crema,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    style: Styles().buttonEditArtesano(context),
                    onPressed: () {
                      context
                          .read<CredencialProvider>()
                          .setButtonEditArtesano();
                    },
                    label: Text(
                      "EDITAR",
                      style: TextStyle(fontSize: Adaptive.sp(11)),
                    )),
                SizedBox(
                  width: Adaptive.w(27),
                ),
                Text(
                  "VER / EDITAR INFORMACION DE ARTESANO",
                  style: TextStyle(
                      color: Styles.crema2, fontSize: Adaptive.sp(14)),
                ),
                Expanded(child: Container()),
                ElevatedButton.icon(
                    icon: const Icon(Icons.format_list_bulleted),
                    style: Styles.buttonAddArtesano,
                    onPressed: () {
                      Navigator.of(context).pushNamed("listArtesanos");
                    },
                    label: Text(
                      "LISTA DE ARTESANOS",
                      style: TextStyle(fontSize: Adaptive.sp(11)),
                    )),
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
                    Row(
                      children: [
                        SizedBox(
                          width: Adaptive.w(30),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            enabled: context.watch<CredencialProvider>().edit,
                            controller: nombre,
                            inputFormatters: [
                              CapitalLetters(),
                            ],
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("NOMBRE"),
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
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            controller: paterno,
                            enabled: context.watch<CredencialProvider>().edit,
                            inputFormatters: [
                              CapitalLetters(),
                            ],
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("APELLIDO PATERNO"),
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
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            controller: materno,
                            enabled: context.watch<CredencialProvider>().edit,
                            inputFormatters: [
                              CapitalLetters(),
                            ],
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("APELLIDO MATERNO"),
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
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Adaptive.w(20),
                          height: Adaptive.h(5),
                          child: DateTimeField(
                            enabled: context.watch<CredencialProvider>().edit,
                            enableInteractiveSelection: false,
                            decoration: Styles()
                                .inputStyleArtesano("FECHA DE NACIMIENTO"),
                            format: DateFormat("yyyy-MM-dd"),
                            controller: nacimiento,
                            onChanged: (value) {
                              setState(() {
                                var fecha = value.toString().split(' ');
                                fechaNacimiento = fecha[0];
                              });
                            },
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100),
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
                              controller: VarAddArtesano.sexo,
                              hintText: sexoHi,
                              selectedStyle: TextStyle(color: Styles.rojo),
                              errorText: 'Sin resultados',
                              onChanged: (p0) {
                                if (p0 == 'Masculino') {
                                  setState(() {
                                    sexoSe = 'H';
                                  });
                                } else {
                                  setState(() {
                                    sexoSe = 'M';
                                  });
                                }
                              },
                              borderSide: BorderSide(color: Styles.rojo),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              items:
                                  context.watch<CredencialProvider>().generos,
                            )),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                          width: Adaptive.w(20),
                          height: Adaptive.h(5),
                          child: CustomDropDownII.search(
                            controller: VarAddArtesano.estadoCivil,
                            hintText: edoCivilHi,
                            selectedStyle: TextStyle(color: Styles.rojo),
                            errorText: 'Sin resultados',
                            onChanged: (p0) {
                              setState(() {
                                estadoCivilSe = p0;
                              });
                            },
                            borderSide: BorderSide(color: Styles.rojo),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            items: context
                                .watch<CredencialProvider>()
                                .estadosCiviles,
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                          width: Adaptive.w(29),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            enabled: context.watch<CredencialProvider>().edit,
                            controller: curp,
                            inputFormatters: [
                              CapitalLetters(),
                              LengthLimitingTextInputFormatter(18),
                            ],
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("CURP"),
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
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Adaptive.w(30),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            enabled: context.watch<CredencialProvider>().edit,
                            controller: claveElector,
                            inputFormatters: [
                              CapitalLetters(),
                              LengthLimitingTextInputFormatter(20),
                            ],
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("CLAVE DE ELECTOR"),
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
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            enabled: context.watch<CredencialProvider>().edit,
                            controller: rfc,
                            inputFormatters: [
                              CapitalLetters(),
                              LengthLimitingTextInputFormatter(12),
                            ],
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("RFC"),
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
                          height: Adaptive.h(5),
                          child: CustomDropDownII.search(
                            controller: VarAddArtesano.escolaridad,
                            hintText: escolaridadHi,
                            selectedStyle: TextStyle(color: Styles.rojo),
                            errorText: 'Sin resultados',
                            onChanged: (p0) {
                              setState(() {
                                escolaridadSe = p0;
                              });
                            },
                            borderSide: BorderSide(color: Styles.rojo),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            items: context
                                .watch<CredencialProvider>()
                                .escolaridades,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Adaptive.w(30),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            enabled: context.watch<CredencialProvider>().edit,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            controller: VarAddArtesano.correo,
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("CORREO"),
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
                          width: Adaptive.w(19),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            enabled: context.watch<CredencialProvider>().edit,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            controller: VarAddArtesano.telefono,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                              LengthLimitingTextInputFormatter(10)
                            ],
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("TELEFONO LOCAL"),
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
                          width: Adaptive.w(20),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            controller: VarAddArtesano.celular,
                            enabled: context.watch<CredencialProvider>().edit,
                            inputFormatters: [
                              CapitalLetters(),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("TELEFONO MOVIL"),
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
                          width: Adaptive.w(20),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            enabled: context.watch<CredencialProvider>().edit,
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            controller: VarAddArtesano.recados,
                            inputFormatters: [
                              CapitalLetters(),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            onChanged: (value) {},
                            decoration: Styles()
                                .inputStyleArtesano("TELEFONO DE RECADOS"),
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
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Adaptive.w(27),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            enabled: context.watch<CredencialProvider>().edit,
                            controller: calle,
                            inputFormatters: [
                              CapitalLetters(),
                            ],
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("CALLE"),
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
                          width: Adaptive.w(12),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            enabled: context.watch<CredencialProvider>().edit,
                            controller: numInterior,
                            inputFormatters: [
                              CapitalLetters(),
                            ],
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("NUM. INTERIOR"),
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
                          width: Adaptive.w(12),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            enabled: context.watch<CredencialProvider>().edit,
                            controller: numExterior,
                            inputFormatters: [
                              CapitalLetters(),
                            ],
                            onChanged: (value) {},
                            decoration:
                                Styles().inputStyleArtesano("NUM. EXTERIOR"),
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
                          width: Adaptive.w(10),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            enabled: context.watch<CredencialProvider>().edit,
                            controller: cp,
                            inputFormatters: [
                              CapitalLetters(),
                              LengthLimitingTextInputFormatter(5),
                            ],
                            onChanged: (value) {},
                            decoration: Styles().inputStyleArtesano("CP"),
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
                            width: Adaptive.w(27),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getRegiones,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano.region,
                                          hintText: regionHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(p0,
                                                listRegiones.data, 'region');
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
                                      : const LinearProgressIndicator();
                                })),
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: Adaptive.w(30),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getDistritos,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano.distrito,
                                          hintText: distritoHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(p0,
                                                listDistritos.data, 'distrito');
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
                                      : const LinearProgressIndicator();
                                })),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(30),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getMunicipios,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano.municipio,
                                          hintText: municipioHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(
                                                p0,
                                                listMunicipios.data,
                                                'municipio');
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
                                      : const LinearProgressIndicator();
                                })),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(30),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getLocalidades,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano.localidad,
                                          hintText: localidadHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(
                                                p0,
                                                listLocalidades.data,
                                                'localidad');
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item
                                                in listLocalidades.data)
                                              item['localidad']
                                          ],
                                        )
                                      : const LinearProgressIndicator();
                                })),
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        const Text("REDES SOCIALES"),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<CredencialProvider>()
                                  .setSocialEdit('face');
                              setState(() {
                                redesSociales.text = socialMedia[0];
                                indexEditing = 0;
                              });
                            },
                            icon: Image.asset(
                              "assets/images/ORGANIZACION_INFORMACION-04.png",
                              width: Adaptive.w(2),
                              color: context
                                          .read<CredencialProvider>()
                                          .flagFaceEdit ==
                                      false
                                  ? Colors.grey
                                  : Styles.rojo,
                            )),
                        SizedBox(
                          width: Adaptive.w(0.5),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<CredencialProvider>()
                                  .setSocialEdit("insta");
                              setState(() {
                                redesSociales.text = socialMedia[1];
                                indexEditing = 1;
                              });
                            },
                            icon: Image.asset(
                              "assets/images/ORGANIZACION_INFORMACION-05.png",
                              width: Adaptive.w(2),
                              color: context
                                          .read<CredencialProvider>()
                                          .flagInstaEdit ==
                                      false
                                  ? Colors.grey
                                  : Styles.rojo,
                            )),
                        SizedBox(
                          width: Adaptive.w(0.5),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<CredencialProvider>()
                                  .setSocialEdit("twitter");
                              setState(() {
                                redesSociales.text = socialMedia[2];
                                indexEditing = 2;
                              });
                            },
                            icon: Image.asset(
                              "assets/images/ORGANIZACION_INFORMACION-06.png",
                              width: Adaptive.w(2),
                              color: context
                                          .read<CredencialProvider>()
                                          .flagTwitterEdit ==
                                      false
                                  ? Colors.grey
                                  : Styles.rojo,
                            )),
                        SizedBox(
                          width: Adaptive.w(0.5),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<CredencialProvider>()
                                  .setSocialEdit("youtube");
                              setState(() {
                                redesSociales.text = socialMedia[3];
                                indexEditing = 3;
                              });
                            },
                            icon: Image.asset(
                              "assets/images/ORGANIZACION_INFORMACION-07.png",
                              width: Adaptive.w(2),
                              color: context
                                          .read<CredencialProvider>()
                                          .flagYoutubeEdit ==
                                      false
                                  ? Colors.grey
                                  : Styles.rojo,
                            )),
                        SizedBox(
                          width: Adaptive.w(0.5),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<CredencialProvider>()
                                  .setSocialEdit("tiktok");
                              setState(() {
                                redesSociales.text = socialMedia[4];
                                indexEditing = 4;
                              });
                            },
                            icon: Image.asset(
                              "assets/images/ORGANIZACION_INFORMACION-08.png",
                              width: Adaptive.w(2),
                              color: context
                                          .read<CredencialProvider>()
                                          .flagTiktokEdit ==
                                      false
                                  ? Colors.grey
                                  : Styles.rojo,
                            )),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                          width: Adaptive.w(44.5),
                          height: Adaptive.h(5),
                          child: TextFormField(
                            cursorWidth: 2,
                            cursorHeight: 15,
                            style: TextStyle(
                              fontSize: Adaptive.sp(11),
                            ),
                            controller: redesSociales,
                            inputFormatters: [
                              CapitalLetters(),
                            ],
                            onChanged: (value) {
                              setState(() {
                                socialMedia[indexEditing] = value;
                              });
                            },
                            decoration: Styles().inputStyleArtesano(
                                context.watch<CredencialProvider>().textSocial),
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
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: Adaptive.w(30),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getGrupos,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano.etnia,
                                          hintText: grupoHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(
                                                p0, listGrupos.data, 'grupo');
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item in listGrupos.data)
                                              item['nombre_etnia']
                                          ],
                                        )
                                      : const LinearProgressIndicator();
                                })),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(30),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getRamas,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano.rama,
                                          hintText: ramaHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(
                                                p0, listRamas.data, 'rama');
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
                                      : const LinearProgressIndicator();
                                })),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(30),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getTecnicas,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano.tecnica,
                                          hintText: productosHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(p0,
                                                listTecnicas.data, 'subrama');
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
                                      : const LinearProgressIndicator();
                                })),
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Adaptive.w(30),
                          height: Adaptive.h(5),
                          child: CustomDropDownII.search(
                            controller: VarAddArtesano.tipoInscripcion,
                            hintText: inscripcionHi,
                            selectedStyle: TextStyle(color: Styles.rojo),
                            errorText: 'Sin resultados',
                            onChanged: (p0) {
                              setState(() {
                                inscripcionSe = p0;
                              });
                            },
                            borderSide: BorderSide(color: Styles.rojo),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            items: const ['INDIVIDUAL', 'FAMILIAR', 'GRUPAL'],
                          ),
                        ),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(30),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getMaterias,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller:
                                              VarAddArtesano.materiaPrima,
                                          hintText: materiaHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(
                                                p0,
                                                listMateriaPrimas.data,
                                                'materia');
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item
                                                in listMateriaPrimas.data)
                                              item['nombre']
                                          ],
                                        )
                                      : const LinearProgressIndicator();
                                })),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        SizedBox(
                            width: Adaptive.w(30),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                                future: getCompradores,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano
                                              .canalComercializacion,
                                          hintText: canalHi,
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(
                                                p0,
                                                listTipoCompradores.data,
                                                'canal');
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item
                                                in listTipoCompradores.data)
                                              item['nombre']
                                          ],
                                        )
                                      : const LinearProgressIndicator();
                                })),
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Row(
                      children: [
                        inscripcionSe != 'INDIVIDUAL' &&
                                inscripcionSe != 'INDEPENDIENTE'
                            ? inscripcionSe == 'GRUPAL'
                                ? SizedBox(
                                    width: Adaptive.w(25),
                                    height: Adaptive.h(5),
                                    child: FutureBuilder(
                                        future: getOrganizaciones,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          return snapshot.hasData
                                              ? CustomDropDownII.search(
                                                  controller:
                                                      VarAddArtesano.tallerT,
                                                  hintText: agrupacionHi,
                                                  selectedStyle: TextStyle(
                                                      color: Styles.rojo),
                                                  errorText: 'Sin resultados',
                                                  onChanged: (p0) {
                                                    idElementUpdated(
                                                        p0,
                                                        listOrganizaciones.data,
                                                        'agrupacion');
                                                  },
                                                  borderSide: BorderSide(
                                                      color: Styles.rojo),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  items: [
                                                    for (var item
                                                        in listOrganizaciones
                                                            .data)
                                                      item[
                                                          'nombre_organizacion']
                                                  ],
                                                )
                                              : const LinearProgressIndicator();
                                        }))
                                : SizedBox(
                                    width: Adaptive.w(25),
                                    height: Adaptive.h(5),
                                    child: FutureBuilder(
                                        future: getOrganizaciones,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          return snapshot.hasData
                                              ? CustomDropDownII.search(
                                                  controller:
                                                      VarAddArtesano.tallerT,
                                                  hintText: agrupacionHi,
                                                  selectedStyle: TextStyle(
                                                      color: Styles.rojo),
                                                  errorText: 'Sin resultados',
                                                  onChanged: (p0) {
                                                    idElementUpdated(
                                                        p0,
                                                        listOrganizaciones.data,
                                                        'agrupacion');
                                                  },
                                                  borderSide: BorderSide(
                                                      color: Styles.rojo),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  items: [
                                                    for (var item
                                                        in listOrganizaciones
                                                            .data)
                                                      item[
                                                          'nombre_organizacion']
                                                  ],
                                                )
                                              : const LinearProgressIndicator();
                                        }))
                            : Container(),
                        SizedBox(
                          width: Adaptive.w(1),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Adaptive.w(30),
                              height: Adaptive.h(5),
                              child: FutureBuilder(
                                future: getLenguas,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  return snapshot.hasData
                                      ? CustomDropDownII.search(
                                          controller: VarAddArtesano.lengua,
                                          hintText: 'LENGUA INDIGENA',
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            idElementUpdated(p0,
                                                listLenguas.data, 'lengua');
                                          },
                                          borderSide:
                                              BorderSide(color: Styles.rojo),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                          items: [
                                            for (var item in listLenguas.data)
                                              item['lengua']
                                          ],
                                        )
                                      : const LinearProgressIndicator();
                                },
                              ),
                            ),
                            SizedBox(
                              width: Adaptive.w(1),
                            ),
                            SizedBox(
                              width: Adaptive.w(30),
                              height: Adaptive.h(5),
                              child: TextFormField(
                                cursorWidth: 2,
                                cursorHeight: 15,
                                style: TextStyle(
                                  fontSize: Adaptive.sp(11),
                                ),
                                controller: VarAddArtesano.observaciones,
                                inputFormatters: [
                                  CapitalLetters(),
                                ],
                                onChanged: (value) {},
                                decoration: Styles()
                                    .inputStyleArtesano("OBSERVACIONES"),
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
                      ],
                    ),
                    SizedBox(
                      height: Adaptive.h(5),
                    ),
                    Center(
                        child: OutlinedLoadingButton(
                            isLoading: getEditing,
                            loadingIcon: const Icon(Icons.update),
                            loadingLabel: const Text('Actualizando...'),
                            style: Styles.buttonStyleCred,
                            onPressed: context
                                        .watch<CredencialProvider>()
                                        .edit ==
                                    false
                                ? null
                                : () async {
                                    apiUpdateArtesano(
                                        dataArtesano['id_artesano'], context);
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context)
                                        .pushNamed("listArtesanos");
                                  },
                            child: const Text("GUARDAR"))),
                    SizedBox(
                      height: Adaptive.h(1),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
