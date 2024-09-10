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
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:scav/src/utils/variables.dart';

class ViewEditArtesanoScreen extends StatefulWidget {
  const ViewEditArtesanoScreen({super.key});

  @override
  State<ViewEditArtesanoScreen> createState() => _ViewEditArtesanoScreenState();
}

class _ViewEditArtesanoScreenState extends State<ViewEditArtesanoScreen> {
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
  TextEditingController recados = TextEditingController();
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
  String productosHi = "PRODUCTOS ELABORADOS";
  String inscripcionHi = "TIPO DE INSCRIPCION";
  String materiaHi = "MATERIA PRIMA";
  String canalHi = "CANAL DE COMERCIALIZACION";
  String agrupacionHi = "AGRUPACION / TALLER";
  String lenguaHi = "LENGUAS INDIGENAS";

  String sexoSe = "";
  String edoCivilSe = "";
  String escolaridadSe = "";
  String regionSe = "";
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
  String lenguaSe = "";
  List<String> socialMedia = [];

  int indexEditing = 0;

  Dio dio = Dio();

  Response dataArtesano = Response(requestOptions: RequestOptions());
  Response updateArtesano = Response(requestOptions: RequestOptions());
  Response listLenguas = Response(requestOptions: RequestOptions());

  bool getEditing = false;

  Future apiGetLenguas() async {
    listLenguas = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/lenguas');

    return listLenguas.data;
  }

  Future apigetArtesano() async {
    dataArtesano = await dio.get(
        '${GlobalVariable.baseUrlApi}scav/v1/artesanos/detail',
        queryParameters: {"artesano": GlobalVariable.idArtesanoEditCred});

    if (dataArtesano.data['sexo'] == 'H') {
      setState(() {
        VarAddArtesano.sexo.text = 'Masculino';
      });
      sexoHi = 'HOMBRE';
    }
    if (dataArtesano.data['sexo'] == 'M') {
      setState(() {
        VarAddArtesano.sexo.text = 'Femenino';
      });
      sexoHi = 'MUJER';
    }

    socialMedia = dataArtesano.data['redes_sociales'].toString().split('<');

    nombre.text = dataArtesano.data['nombre'];
    paterno.text = dataArtesano.data['primer_apellido'];
    materno.text = dataArtesano.data['segundo_apellido'];
    nacimiento.text = dataArtesano.data['fecha_nacimiento'];
    edoCivilHi = dataArtesano.data['edo_civil'];
    curp.text = dataArtesano.data['curp'];
    claveElector.text = dataArtesano.data['clave_ine'];
    rfc.text = dataArtesano.data['rfc'];
    escolaridadHi = dataArtesano.data['escolaridad'];
    correo.text = dataArtesano.data['correo'];
    telefono.text = dataArtesano.data['tel_fijo'];
    celular.text = dataArtesano.data['tel_celular'];
    recados.text = dataArtesano.data['telefono_recados'];
    calle.text = dataArtesano.data['calle'];
    inscripcionHi = dataArtesano.data['gpo_pertenencia'];
    agrupacionHi = dataArtesano.data['id_organizacion'] ?? " ";
    lenguaHi = dataArtesano.data['lengua'] ?? " ";

    materiaHi = dataArtesano.data['materiap'];
    canalHi = dataArtesano.data['tipocomp'];
    ramaHi = dataArtesano.data['nombre_rama'];
    productosHi = dataArtesano.data['nombre_subrama'];
    setState(() {
      inscripcionSe = dataArtesano.data['gpo_pertenencia'];
      lenguaSe = dataArtesano.data['id_lengua'];
      sexoSe = dataArtesano.data['sexo'];
      edoCivilSe = dataArtesano.data['edo_civil'];
      escolaridadSe = dataArtesano.data['escolaridad'];
      inscripcionSe = dataArtesano.data['gpo_pertenencia'];
      regionSe = dataArtesano.data['id_region'];
      fechaNacimiento = dataArtesano.data['fecha_nacimiento'];
      edoCivilSe = dataArtesano.data['edo_civil'];
      distritoSe = dataArtesano.data['id_distrito'];
      municipioSe = dataArtesano.data['id_municipio'];
      localidadSe = dataArtesano.data['id_localidad'];
      regionHi = dataArtesano.data['region'];
      grupoSe = dataArtesano.data['id_grupo'];
      agrupacionSe = dataArtesano.data['id_organizacion'];
      distritoHi = dataArtesano.data['distrito'];
      municipioHi = dataArtesano.data['municipio'];
      localidadHi = dataArtesano.data['localidad'];
      grupoHi = dataArtesano.data['nombre_etnia'] ?? ' ';
      inscripcionHi = dataArtesano.data['gpo_pertenencia'];
      materiaHi = dataArtesano.data['materiap'];
      canalHi = dataArtesano.data['tipocomp'];
    });

    numExterior.text = dataArtesano.data['num_exterior'];
    numInterior.text = dataArtesano.data['num_interior'];
    cp.text = dataArtesano.data['cp'];

    comentarios.text = dataArtesano.data['comentarios'];

    return dataArtesano.data;
  }

  Future<bool> apiUpdateArtesano(id, BuildContext context) async {
    idElementUpdated(dataArtesano.data['nombre_rama'], listRamas, 'rama');
    idElementUpdated(
        dataArtesano.data['nombre_subrama'], listTecnicas, 'subrama');
    idElementUpdated(
        dataArtesano.data['materiap'], listMateriaPrimas, 'materia');
    idElementUpdated(
        dataArtesano.data['tipocomp'], listTipoCompradores, 'canal');

    var social =
        "${socialMedia[0]}<${socialMedia[1]}<${socialMedia[2]}<${socialMedia[3]}<${socialMedia[4]}";

    updateArtesano = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/artesano/update/$id', data: {
      "nombre": nombre.text,
      "primer_apellido": paterno.text,
      "segundo_apellido": materno.text,
      "sexo": sexoSe,
      "fecha_nacimiento": fechaNacimiento,
      "edo_civil": estadoCivilSe,
      "curp": curp.text,
      "clave_ine": claveElector.text,
      "rfc": rfc.text,
      "calle": calle.text,
      "num_exterior": numExterior.text,
      "num_interior": numInterior.text,
      "cp": cp.text,
      "id_region": regionSe,
      "id_distrito": distritoSe,
      "id_municipio": municipioSe,
      "id_localidad": localidadSe,
      "tel_fijo": telefono.text,
      "tel_celular": celular.text,
      "correo": correo.text,
      "redes_sociales": social,
      "escolaridad": escolaridadSe,
      "id_grupo": grupoSe,
      "gpo_pertenencia": inscripcionSe,
      "id_organizacion": agrupacionSe,
      "comentarios": comentarios.text,
      "id_lengua": VarAddArtesano.idLengua,
      "updated_at": GlobalVariable.currentDate,
      "recados": recados.text,
      "id_rama": ramaSe,
      "id_tecnica": productosSe,
      "id_materiaprima": materiaSe,
      "id_canal": canalSe
    });

    if (updateArtesano.statusCode == 200) {
      FunctionAddArtesano.clean();
      // ignore: use_build_context_synchronously
      Message().mensaje(
          Colors.green, Icons.done, 'Información actualizada', context);
      return true;
    } else {
      return false;
    }
  }

  void idElementUpdated(element, lista, caso) {
    switch (caso) {
      case 'region':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['region'] == element) {
            setState(() {
              regionSe = lista.data[i]['id_region'];
            });
          }
        }
        break;

      case 'municipio':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['municipio'] == element) {
            setState(() {
              municipioSe = lista.data[i]['id_municipio'];
            });
          }
        }
        break;

      case 'lengua':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['lengua'] == element) {
            setState(() {
              lenguaSe = lista.data[i]['id_lengua'];
            });
          }
        }
        break;

      case 'distrito':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['distrito'] == element) {
            setState(() {
              distritoSe = lista.data[i]['id_distrito'];
            });
          }
        }
        break;

      case 'localidad':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['localidad'] == element) {
            setState(() {
              localidadSe = lista.data[i]['id_localidad'];
            });
          }
        }
        break;
      case 'grupo':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_etnia'] == element) {
            setState(() {
              grupoSe = lista.data[i]['id_grupo'];
            });
          }
        }
        break;
      case 'rama':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_rama'] == element) {
            setState(() {
              ramaSe = lista.data[i]['id_rama'];
            });
          }
        }
        break;
      case 'subrama':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_subrama'] == element) {
            setState(() {
              productosSe = lista.data[i]['id_subrama'];
            });
          }
        }
        break;
      case 'materia':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre'] == element) {
            setState(() {
              materiaSe = lista.data[i]['id_materiap'];
            });
          }
        }
        break;
      case 'canal':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre'] == element) {
            setState(() {
              canalSe = lista.data[i]['id_tipo_comprador'];
            });
          }
        }
        break;
      case 'agrupacion':
        for (var i = 0; i < lista.data.length; i++) {
          if (lista.data[i]['nombre_organizacion'] == element) {
            setState(() {
              agrupacionSe = lista.data[i]['id_organizacion'];
            });
          }
        }
        break;
      default:
    }
  }

  Response listLocalidades = Response(requestOptions: RequestOptions());
  Response listMunicipios = Response(requestOptions: RequestOptions());
  Response listDistritos = Response(requestOptions: RequestOptions());
  Response listRegiones = Response(requestOptions: RequestOptions());
  Response listRamas = Response(requestOptions: RequestOptions());
  Response listTecnicas = Response(requestOptions: RequestOptions());
  Response listGrupos = Response(requestOptions: RequestOptions());
  Response listTipoCompradores = Response(requestOptions: RequestOptions());
  Response listMateriaPrimas = Response(requestOptions: RequestOptions());
  Response listOrganizaciones = Response(requestOptions: RequestOptions());
  Response listTalleres = Response(requestOptions: RequestOptions());

  Future apiGetMaterias() async {
    listMateriaPrimas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/materias');

    return listMateriaPrimas.data;
  }

  Future apiGetOrganizaciones() async {
    listOrganizaciones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/organizaciones');

    return listOrganizaciones.data;
  }

  Future apiGetTalleres() async {
    listTalleres =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/talleres');

    return listTalleres.data;
  }

  Future apiGetCompradores() async {
    listTipoCompradores =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/compradores');

    return listTipoCompradores.data;
  }

  Future apiGetLocalidades() async {
    listLocalidades =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/localidades/all');

    return listLocalidades.data;
  }

  Future apiGetMunicipios() async {
    listMunicipios =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/municipios');

    return listMunicipios.data;
  }

  Future apiGetGrupos() async {
    listGrupos = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/etnias');

    return listGrupos.data;
  }

  Future apiGetDistritos() async {
    listDistritos =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/distritos');

    return listDistritos.data;
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

  Future apiGetTecnicas() async {
    listTecnicas =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/tecnicas');

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

  late final Future getArtesanos = apigetArtesano();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getArtesanos,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Scaffold(
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
                                color: Styles.crema2,
                                fontSize: Adaptive.sp(14)),
                          ),
                          Expanded(child: Container()),
                          ElevatedButton.icon(
                              icon: const Icon(Icons.format_list_bulleted),
                              style: Styles.buttonAddArtesano,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("listArtesanos");
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
                              horizontal: Adaptive.w(2),
                              vertical: Adaptive.h(3)),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: nombre,
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
                                    height: Adaptive.h(5),
                                    child: TextFormField(
                                      cursorWidth: 2,
                                      cursorHeight: 15,
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      controller: paterno,
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles().inputStyleArtesano(
                                          "APELLIDO PATERNO"),
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
                                      controller: materno,
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles().inputStyleArtesano(
                                          "APELLIDO MATERNO"),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      enableInteractiveSelection: false,
                                      decoration: Styles().inputStyleArtesano(
                                          "FECHA DE NACIMIENTO"),
                                      format: DateFormat("yyyy-MM-dd"),
                                      controller: nacimiento,
                                      onChanged: (value) {
                                        setState(() {
                                          var fecha =
                                              value.toString().split(' ');
                                          fechaNacimiento = fecha[0];
                                        });
                                      },
                                      onShowPicker: (context, currentValue) {
                                        return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate:
                                              currentValue ?? DateTime.now(),
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
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
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
                                        borderSide:
                                            BorderSide(color: Styles.rojo),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        items: context
                                            .watch<CredencialProvider>()
                                            .generos,
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
                                      selectedStyle:
                                          TextStyle(color: Styles.rojo),
                                      errorText: 'Sin resultados',
                                      onChanged: (p0) {
                                        setState(() {
                                          estadoCivilSe = p0;
                                        });
                                      },
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: curp,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(18),
                                      ],
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyleArtesano("CURP"),
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
                                height: Adaptive.h(2),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: claveElector,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(20),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles().inputStyleArtesano(
                                          "CLAVE DE ELECTOR"),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: rfc,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(12),
                                      ],
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyleArtesano("RFC"),
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
                                      selectedStyle:
                                          TextStyle(color: Styles.rojo),
                                      errorText: 'Sin resultados',
                                      onChanged: (p0) {
                                        setState(() {
                                          escolaridadSe = p0;
                                        });
                                      },
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      items: context
                                          .watch<CredencialProvider>()
                                          .escolaridades,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Adaptive.h(2),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: correo,
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyleArtesano("CORREO"),
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
                                      style: TextStyle(
                                        fontSize: Adaptive.sp(11),
                                      ),
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: telefono,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[0-9]")),
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("TELEFONO LOCAL"),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: celular,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("TELEFONO MOVIL"),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: recados,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles().inputStyleArtesano(
                                          "TELEFONO DE RECADOS"),
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
                                height: Adaptive.h(2),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: calle,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyleArtesano("CALLE"),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: numInterior,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("NUM. INTERIOR"),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: numExterior,
                                      inputFormatters: [
                                        CapitalLetters(),
                                      ],
                                      onChanged: (value) {},
                                      decoration: Styles()
                                          .inputStyleArtesano("NUM. EXTERIOR"),
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
                                      enabled: context
                                          .watch<CredencialProvider>()
                                          .edit,
                                      controller: cp,
                                      inputFormatters: [
                                        CapitalLetters(),
                                        LengthLimitingTextInputFormatter(5),
                                      ],
                                      onChanged: (value) {},
                                      decoration:
                                          Styles().inputStyleArtesano("CP"),
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
                                                controller:
                                                    VarAddArtesano.region,
                                                hintText: regionHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(p0,
                                                      listRegiones, 'region');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listRegiones.data)
                                                    item['region']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Adaptive.h(2),
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
                                                controller:
                                                    VarAddArtesano.distrito,
                                                hintText: distritoHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0,
                                                      listDistritos,
                                                      'distrito');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listDistritos.data)
                                                    item['distrito']
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
                                    child: FutureBuilder(
                                      future: getMunicipios,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller:
                                                    VarAddArtesano.municipio,
                                                hintText: municipioHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0,
                                                      listMunicipios,
                                                      'municipio');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listMunicipios.data)
                                                    item['municipio']
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
                                    child: FutureBuilder(
                                      future: getLocalidades,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller:
                                                    VarAddArtesano.localidad,
                                                hintText: localidadHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0,
                                                      listLocalidades,
                                                      'localidad');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listLocalidades.data)
                                                    item['localidad']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Adaptive.h(2),
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
                                          context
                                              .watch<CredencialProvider>()
                                              .textSocial),
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
                                height: Adaptive.h(2),
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
                                                controller:
                                                    VarAddArtesano.etnia,
                                                hintText: grupoHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0, listGrupos, 'grupo');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listGrupos.data)
                                                    item['nombre_etnia']
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
                                    child: FutureBuilder(
                                      future: getRamas,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller: VarAddArtesano.rama,
                                                hintText: ramaHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0, listRamas, 'rama');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listRamas.data)
                                                    item['nombre_rama']
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
                                    child: FutureBuilder(
                                      future: getTecnicas,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData
                                            ? CustomDropDownII.search(
                                                controller:
                                                    VarAddArtesano.tecnica,
                                                hintText: productosHi,
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(p0,
                                                      listTecnicas, 'subrama');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listTecnicas.data)
                                                    item['nombre_subrama']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Adaptive.h(2),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: Adaptive.w(30),
                                    height: Adaptive.h(5),
                                    child: CustomDropDownII.search(
                                      controller:
                                          VarAddArtesano.tipoInscripcion,
                                      hintText: inscripcionHi,
                                      selectedStyle:
                                          TextStyle(color: Styles.rojo),
                                      errorText: 'Sin resultados',
                                      onChanged: (p0) {
                                        setState(() {
                                          inscripcionSe = p0;
                                        });
                                      },
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      items: const [
                                        'INDIVIDUAL',
                                        'FAMILIAR',
                                        'GRUPAL'
                                      ],
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
                                                  controller: VarAddArtesano
                                                      .materiaPrima,
                                                  hintText: materiaHi,
                                                  selectedStyle: TextStyle(
                                                      color: Styles.rojo),
                                                  errorText: 'Sin resultados',
                                                  onChanged: (p0) {
                                                    idElementUpdated(
                                                        p0,
                                                        listMateriaPrimas,
                                                        'materia');
                                                  },
                                                  borderSide: BorderSide(
                                                      color: Styles.rojo),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  items: [
                                                    for (var item
                                                        in listMateriaPrimas
                                                            .data)
                                                      item['nombre']
                                                  ],
                                                )
                                              : const LinearProgressIndicator();
                                        },
                                      )),
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
                                                selectedStyle: TextStyle(
                                                    color: Styles.rojo),
                                                errorText: 'Sin resultados',
                                                onChanged: (p0) {
                                                  idElementUpdated(
                                                      p0,
                                                      listTipoCompradores,
                                                      'canal');
                                                },
                                                borderSide: BorderSide(
                                                    color: Styles.rojo),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12)),
                                                items: [
                                                  for (var item
                                                      in listTipoCompradores
                                                          .data)
                                                    item['nombre']
                                                ],
                                              )
                                            : const LinearProgressIndicator();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Adaptive.h(2),
                              ),
                              Row(
                                children: [
                                  inscripcionSe != 'INDIVIDUAL' &&
                                          inscripcionSe != 'INDEPENDIENTE'
                                      ? inscripcionSe == 'GRUPAL'
                                          ? SizedBox(
                                              width: Adaptive.w(25),
                                              child: FutureBuilder(
                                                future: getOrganizaciones,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<dynamic>
                                                        snapshot) {
                                                  return snapshot.hasData
                                                      ? CustomDropDownII.search(
                                                          controller:
                                                              VarAddArtesano
                                                                  .tallerT,
                                                          hintText:
                                                              agrupacionHi,
                                                          selectedStyle:
                                                              TextStyle(
                                                                  color: Styles
                                                                      .rojo),
                                                          errorText:
                                                              'Sin resultados',
                                                          onChanged: (p0) {
                                                            idElementUpdated(
                                                                p0,
                                                                listOrganizaciones,
                                                                'agrupacion');
                                                          },
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Styles
                                                                      .rojo),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12)),
                                                          items: [
                                                            for (var item
                                                                in listOrganizaciones
                                                                    .data)
                                                              item[
                                                                  'nombre_organizacion']
                                                          ],
                                                        )
                                                      : const LinearProgressIndicator();
                                                },
                                              ),
                                            )
                                          : SizedBox(
                                              width: Adaptive.w(25),
                                              height: Adaptive.h(5),
                                              child: FutureBuilder(
                                                future: getTalleres,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<dynamic>
                                                        snapshot) {
                                                  return snapshot.hasData
                                                      ? CustomDropDownII.search(
                                                          controller:
                                                              VarAddArtesano
                                                                  .tallerT,
                                                          hintText:
                                                              agrupacionHi,
                                                          selectedStyle:
                                                              TextStyle(
                                                                  color: Styles
                                                                      .rojo),
                                                          errorText:
                                                              'Sin resultados',
                                                          onChanged: (p0) {
                                                            idElementUpdated(
                                                                p0,
                                                                listTalleres,
                                                                'agrupacion');
                                                          },
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Styles
                                                                      .rojo),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12)),
                                                          items: [
                                                            for (var item
                                                                in listTalleres
                                                                    .data)
                                                              item[
                                                                  'nombre_organizacion']
                                                          ],
                                                        )
                                                      : const LinearProgressIndicator();
                                                },
                                              ),
                                            )
                                      : Container(),
                                  SizedBox(
                                    width: Adaptive.w(1),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    controller:
                                                        VarAddArtesano.lengua,
                                                    hintText: lenguaHi,
                                                    selectedStyle: TextStyle(
                                                        color: Styles.rojo),
                                                    errorText: 'Sin resultados',
                                                    onChanged: (p0) {
                                                      idElementUpdated(
                                                          p0,
                                                          listLenguas,
                                                          'lengua');
                                                    },
                                                    borderSide: BorderSide(
                                                        color: Styles.rojo),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    items: [
                                                      for (var item
                                                          in listLenguas.data)
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
                                        width: Adaptive.w(60),
                                        height: Adaptive.h(5),
                                        child: TextFormField(
                                          cursorWidth: 2,
                                          cursorHeight: 15,
                                          style: TextStyle(
                                            fontSize: Adaptive.sp(11),
                                          ),
                                          controller:
                                              VarAddArtesano.observaciones,
                                          inputFormatters: [
                                            CapitalLetters(),
                                          ],
                                          onChanged: (value) {},
                                          decoration: Styles()
                                              .inputStyleArtesano(
                                                  "OBSERVACIONES"),
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
                                height: Adaptive.h(3),
                              ),
                              Center(
                                  child: OutlinedLoadingButton(
                                      isLoading: getEditing,
                                      loadingIcon: const Icon(Icons.update),
                                      loadingLabel:
                                          const Text('Actualizando...'),
                                      style: Styles.buttonStyleCred,
                                      onPressed: context
                                                  .watch<CredencialProvider>()
                                                  .edit ==
                                              false
                                          ? null
                                          : () async {
                                              setState(() {
                                                getEditing = true;
                                              });
                                              if (await apiUpdateArtesano(
                                                      dataArtesano
                                                          .data['id_artesano'],
                                                      context) ==
                                                  true) {
                                                // ignore: use_build_context_synchronously
                                                Navigator.of(context)
                                                    .pushNamed("listArtesanos");
                                              }
                                              setState(() {
                                                getEditing = false;
                                              });
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
              )
            : Image.asset("assets/images/cargando.gif");
      },
    );
  }
}
