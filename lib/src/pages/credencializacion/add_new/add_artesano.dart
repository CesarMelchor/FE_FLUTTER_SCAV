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

class AddArtesanoScreen extends StatefulWidget {
  const AddArtesanoScreen({super.key});

  @override
  State<AddArtesanoScreen> createState() => _AddArtesanoScreenState();
}

class _AddArtesanoScreenState extends State<AddArtesanoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Dio dio = Dio();

  bool createTaller = false;
  bool createAgrupacion = false;
  bool createArtesano = false;
  bool getdistritos = false;
  bool getmunicipios = false;
  bool getlocalidades = false;

  bool getdistritos2 = false;
  bool getmunicipios2 = false;
  bool getlocalidades2 = false;

  Response listLocalidades2 = Response(requestOptions: RequestOptions());
  Response listMunicipios2 = Response(requestOptions: RequestOptions());
  Response listDistritos2 = Response(requestOptions: RequestOptions());
  Response listLocalidades = Response(requestOptions: RequestOptions());
  Response listMunicipios = Response(requestOptions: RequestOptions());
  Response listLenguas = Response(requestOptions: RequestOptions());
  Response listDistritos = Response(requestOptions: RequestOptions());
  Response listRegiones = Response(requestOptions: RequestOptions());
  Response listRegionesTaller = Response(requestOptions: RequestOptions());
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

  List listadistritos = [
    {"distrito": ""}
  ];
  List listamunicipios = [
    {"municipio": ""}
  ];
  List listalocalidades = [
    {"localidad": ""}
  ];

  List listadistritos2 = [
    {"distrito": ""}
  ];
  List listamunicipios2 = [
    {"municipio": ""}
  ];
  List listalocalidades2 = [
    {"localidad": ""}
  ];

  int posicion = 0;
  List<String> sociales = VarAddArtesano.fullRedes.split("<");

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
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/agrupacionesAll');

    return listTalleres.data;
  }

  Future apiGetLenguas() async {
    listLenguas = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/lenguas');

    return listLenguas.data;
  }

  Future apiGetCompradores() async {
    listTipoCompradores =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/compradores');

    return listTipoCompradores.data;
  }

  Future apiGetLocalidades(municipio, numero) async {
    if (numero == 1) {
      setState(() {
        getlocalidades = true;
      });
      listLocalidades = await dio
          .get('${GlobalVariable.baseUrlApi}scav/v1/localidades/$municipio');
      setState(() {
        listalocalidades = listLocalidades.data;
        getlocalidades = false;
      });
      return listLocalidades.data;
    } else {
      setState(() {
        getlocalidades2 = true;
      });
      listLocalidades2 = await dio
          .get('${GlobalVariable.baseUrlApi}scav/v1/localidades/$municipio');
      setState(() {
        listalocalidades2 = listLocalidades2.data;
        getlocalidades2 = false;
      });
      return listLocalidades2.data;
    }
  }

  Future apiGetMunicipios(distrito, numero) async {
    if (numero == 1) {
      setState(() {
        getmunicipios = true;
      });
      listMunicipios = await dio
          .get('${GlobalVariable.baseUrlApi}scav/v1/municipios/$distrito');
      setState(() {
        listamunicipios = listMunicipios.data;
        getmunicipios = false;
      });
      return listMunicipios.data;
    } else {
      setState(() {
        getmunicipios2 = true;
      });
      listMunicipios2 = await dio
          .get('${GlobalVariable.baseUrlApi}scav/v1/municipios/$distrito');
      setState(() {
        listamunicipios2 = listMunicipios2.data;
        getmunicipios2 = false;
      });
      return listMunicipios2.data;
    }
  }

  Future apiGetGrupos() async {
    listGrupos = await dio.get('${GlobalVariable.baseUrlApi}scav/v1/etnias');

    return listGrupos.data;
  }

  Future apiGetDistritos(region, numero) async {
    if (numero == 1) {
      setState(() {
        getdistritos = true;
      });
      listDistritos = await dio
          .get('${GlobalVariable.baseUrlApi}scav/v1/distritos/$region');
      setState(() {
        listadistritos = listDistritos.data;
        getdistritos = false;
      });
      return listDistritos.data;
    } else {
      setState(() {
        getdistritos2 = true;
      });
      listDistritos2 = await dio
          .get('${GlobalVariable.baseUrlApi}scav/v1/distritos/$region');
      setState(() {
        listadistritos2 = listDistritos2.data;
        getdistritos2 = false;
      });
      return listDistritos2.data;
    }
  }

  Future apiGetRegiones() async {
    listRegiones =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/regiones');

    return listRegiones.data;
  }

  Future apiGetRegionesTaller() async {
    listRegionesTaller =
        await dio.get('${GlobalVariable.baseUrlApi}scav/v1/regiones');

    return listRegionesTaller.data;
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

  Future apiAddOrganizacion() async {
    var segmento = VarAddArtesano.nombreT.text;
    addTaller = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/organizacion/create', data: {
      "id_organizacion": "TF_${segmento[0]}${segmento[1]}_",
      "representante": VarAddArtesano.nombreRepresentanteT.text,
      "nombre_organizacion": VarAddArtesano.nombreT.text,
      "rfc": VarAddArtesano.rfcT.text,
      "calle": VarAddArtesano.calleT.text,
      "num_exterior": VarAddArtesano.numExteriorT.text,
      "num_interior": VarAddArtesano.numInteriorT.text,
      "cp": VarAddArtesano.cpT.text,
      "id_region": VarAddArtesano.idRegionTaller,
      "id_distrito": VarAddArtesano.idDistritoTaller,
      "id_municipio": VarAddArtesano.idMunicipioTaller,
      "id_localidad": VarAddArtesano.idLocalidadTaller,
      "tel_fijo": VarAddArtesano.telefonoT.text,
      "tel_celular": VarAddArtesano.celularT.text,
      "correo": VarAddArtesano.correoT.text,
      "num_integrantes": 0,
      "hombres": VarAddArtesano.totalHombresT.text,
      "mujeres": VarAddArtesano.totalMujeresT.text,
      "activo": 1,
      "created_at": GlobalVariable.currentDate,
      "updated_at": GlobalVariable.currentDate,
      "descripcion": VarAddArtesano.descripcionT.text,
      "tipo_org": VarAddArtesano.tipoOrganizacionT.text,
      "tipo": VarAddArtesano.tipoOrganizacion,
      "id_rama": VarAddArtesano.idRamaTaller,
      "id_tecnica": VarAddArtesano.idTecnicaTaller,
    });

    if (addTaller.statusCode == 200) {
      setState(() {
        VarAddArtesano.addTaller = true;
        VarAddArtesano.idAgrupacion = addTaller.data['mensaje'];
      });
      return true;
    } else {
      setState(() {
        VarAddArtesano.addTaller = false;
      });
      return false;
    }
  }

  Future apiAddArtesano(BuildContext context) async {
    var art = VarAddArtesano.curp.text.substring(0, 16);
    var socialmedia =
        "${sociales[0]}<${sociales[1]}<${sociales[2]}<${sociales[3]}<${sociales[4]}";
    addArtesano = await dio
        .post('${GlobalVariable.baseUrlApi}scav/v1/artesano/create', data: {
      "id_artesano": "ART_$art",
      "nombre": VarAddArtesano.nombre.text,
      "primer_apellido": VarAddArtesano.paterno.text,
      "segundo_apellido": VarAddArtesano.materno.text,
      "sexo": VarAddArtesano.sexoSelected,
      "fecha_nacimiento": VarAddArtesano.nacimiento.text,
      "edo_civil": VarAddArtesano.estadoCivil.text,
      "curp": VarAddArtesano.curp.text,
      "clave_ine": VarAddArtesano.claveElector.text,
      "rfc": VarAddArtesano.rfc.text,
      "calle": VarAddArtesano.calle.text,
      "num_exterior": VarAddArtesano.numExterior.text,
      "num_interior": VarAddArtesano.numInterior.text,
      "cp": VarAddArtesano.cp.text,
      "id_region": VarAddArtesano.idRegionArtesano,
      "id_distrito": VarAddArtesano.idDistritoArtesano,
      "id_municipio": VarAddArtesano.idMunicipioArtesano,
      "id_localidad": VarAddArtesano.idLocalidadArtesano,
      "seccion": "NOENTREGADO",
      "tel_fijo": VarAddArtesano.telefono.text,
      "tel_celular": VarAddArtesano.celular.text,
      "correo": VarAddArtesano.correo.text,
      "redes_sociales": socialmedia,
      "escolaridad": VarAddArtesano.escolaridad.text,
      "id_grupo": VarAddArtesano.idGrupo,
      "gpo_pertenencia": VarAddArtesano.tipoInscripcion.text,
      "id_organizacion": VarAddArtesano.idAgrupacion,
      "id_materia_prima": VarAddArtesano.idMateria,
      "id_venta_producto": 0,
      "id_tipo_comprador": VarAddArtesano.idComprador,
      "folio_cuis": ".",
      "foto": ".",
      "activo": 1,
      "nombre_archivo": ".",
      "comentarios": VarAddArtesano.observaciones.text,
      "id_lengua": VarAddArtesano.idLengua,
      "longitud": ".",
      "latitud": ".",
      "created_at": GlobalVariable.currentDate,
      "updated_at": GlobalVariable.currentDate,
      "recados": VarAddArtesano.recados.text,
      "id_rama": VarAddArtesano.idRamaArtesano,
      "id_tecnica": VarAddArtesano.idTecnicaArtesano,
      "id_materiaprima": VarAddArtesano.idMateria,
      "id_canal": VarAddArtesano.idComprador,
      "fecha_entrega_credencial": '0000-00-00',
      "proveedor": '0'
    });

    if (addArtesano.statusCode == 200) {
      return true;
    } else if (addArtesano.statusCode == 203) {
      // ignore: use_build_context_synchronously
      Message()
          .mensaje(Colors.amber, Icons.warning, 'Artesano existente', context);
      return false;
    } else {
      
                                    // ignore: use_build_context_synchronously
                                    Message().mensaje(Colors.red, Icons.error,
                                        'Error, intentalo de nuevo', context);
      return false;
    }
  }

  late final Future getRegiones = apiGetRegiones();
  late final Future getRegionesTaller = apiGetRegionesTaller();
  late final Future getGrupos = apiGetGrupos();
  late final Future getRamas = apiGetRamas();
  late final Future getTecnicas = apiGetTecnicas();
  late final Future getMaterias = apiGetMaterias();
  late final Future getCompradores = apiGetCompradores();
  late final Future getOrganizaciones = apiGetOrganizaciones();
  late final Future getTalleres = apiGetTalleres();
  late final Future getLenguas = apiGetLenguas();

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
                      icon: const Icon(Icons.format_list_bulleted),
                      style: Styles.buttonListArtesano,
                      onPressed: () {
                        Navigator.of(context).pushNamed("listArtesanos");
                      },
                      label: Text(
                        "LISTA DE PERSONAS",
                        style: TextStyle(fontSize: Adaptive.sp(11)),
                      )),
                  SizedBox(
                    width: Adaptive.w(27),
                  ),
                  Text(
                    "AGREGAR ARTESANO",
                    style: TextStyle(
                        color: Styles.crema2, fontSize: Adaptive.sp(14)),
                  ),
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
                              controller: VarAddArtesano.nombre,
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
                              controller: VarAddArtesano.paterno,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {},
                              decoration: Styles()
                                  .inputStyleArtesano("APELLIDO PATERNO"),
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
                              controller: VarAddArtesano.materno,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {},
                              decoration: Styles()
                                  .inputStyleArtesano("APELLIDO MATERNO"),
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
                            width: Adaptive.w(20),
                            height: Adaptive.h(5),
                            child: DateTimeField(
                              enableInteractiveSelection: false,
                              decoration: Styles()
                                  .inputStyleArtesano("FECHA DE NACIMIENTO"),
                              format: DateFormat("yyyy-MM-dd"),
                              onChanged: (value) {
                                setState(() {
                                  var fecha = value.toString().split(' ');
                                  VarAddArtesano.nacimiento.text = fecha[0];
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
                              hintText: 'GENERO',
                              selectedStyle: TextStyle(color: Styles.rojo),
                              errorText: 'Sin resultados',
                              onChanged: (p0) {
                                if (p0 == 'Masculino') {
                                  setState(() {
                                    VarAddArtesano.sexo.text = p0;
                                    VarAddArtesano.sexoSelected = 'H';
                                  });
                                } else {
                                  setState(() {
                                    VarAddArtesano.sexo.text = p0;
                                    VarAddArtesano.sexoSelected = 'M';
                                  });
                                }
                              },
                              borderSide: BorderSide(color: Styles.rojo),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              items:
                                  context.watch<CredencialProvider>().generos,
                            ),
                          ),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          SizedBox(
                            width: Adaptive.w(20),
                            height: Adaptive.h(5),
                            child: CustomDropDownII.search(
                              controller: VarAddArtesano.estadoCivil,
                              hintText: 'ESTADO CIVIL',
                              selectedStyle: TextStyle(color: Styles.rojo),
                              errorText: 'Sin resultados',
                              onChanged: (p0) {
                                setState(() {
                                  VarAddArtesano.estadoCivil.text = p0;
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
                              controller: VarAddArtesano.curp,
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
                              controller: VarAddArtesano.claveElector,
                              inputFormatters: [
                                CapitalLetters(),
                                LengthLimitingTextInputFormatter(20),
                              ],
                              onChanged: (value) {},
                              decoration: Styles()
                                  .inputStyleArtesano("CLAVE DE ELECTOR"),
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
                              controller: VarAddArtesano.rfc,
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
                              hintText: 'ESCOLARIDAD',
                              selectedStyle: TextStyle(color: Styles.rojo),
                              errorText: 'Sin resultados',
                              onChanged: (p0) {
                                setState(() {
                                  VarAddArtesano.escolaridad.text = p0;
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
                              style: TextStyle(
                                fontSize: Adaptive.sp(11),
                              ),
                              controller: VarAddArtesano.telefono,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]")),
                                LengthLimitingTextInputFormatter(10),
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
                              controller: VarAddArtesano.calle,
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
                              controller: VarAddArtesano.numInterior,
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
                              controller: VarAddArtesano.numExterior,
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
                            width: Adaptive.w(12),
                            height: Adaptive.h(5),
                            child: TextFormField(
                              cursorWidth: 2,
                              cursorHeight: 15,
                              style: TextStyle(
                                fontSize: Adaptive.sp(11),
                              ),
                              controller: VarAddArtesano.cp,
                              inputFormatters: [
                                CapitalLetters(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]")),
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
                            width: Adaptive.w(25),
                            height: Adaptive.h(5),
                            child: FutureBuilder(
                              future: getRegiones,
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                return snapshot.hasData
                                    ? CustomDropDownII.search(
                                        controller: VarAddArtesano.region,
                                        hintText: 'REGION',
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          setState(() {
                                            VarAddArtesano.distrito =
                                                TextEditingController();
                                            VarAddArtesano.municipio =
                                                TextEditingController();
                                            VarAddArtesano.localidad =
                                                TextEditingController();
                                          });

                                          FunctionAddArtesano.idRegionSelected(
                                              p0, 'artesano', listRegiones);
                                          apiGetDistritos(
                                              VarAddArtesano.idRegionArtesano,
                                              1);
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
                                    : LinearProgressIndicator(
                                        minHeight: Adaptive.h(2),
                                      );
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
                              child: getdistritos == false
                                  ? CustomDropDownII.search(
                                      controller: VarAddArtesano.distrito,
                                      hintText: 'DISTRITO',
                                      selectedStyle:
                                          TextStyle(color: Styles.rojo),
                                      errorText: 'Sin resultados',
                                      onChanged: (p0) {
                                        setState(() {
                                          VarAddArtesano.municipio =
                                              TextEditingController();
                                          VarAddArtesano.localidad =
                                              TextEditingController();
                                        });

                                        FunctionAddArtesano.idDistritoSelected(
                                            p0, 'artesano', listadistritos);

                                        apiGetMunicipios(
                                            VarAddArtesano.idDistritoArtesano,
                                            1);
                                      },
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      items: [
                                        for (var item in listadistritos)
                                          item['distrito']
                                      ],
                                    )
                                  : LinearProgressIndicator(
                                      color: Styles.rojo,
                                    )),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          SizedBox(
                              width: Adaptive.w(30),
                              height: Adaptive.h(5),
                              child: getmunicipios == false
                                  ? CustomDropDownII.search(
                                      controller: VarAddArtesano.municipio,
                                      hintText: 'MUNICIPIO',
                                      selectedStyle:
                                          TextStyle(color: Styles.rojo),
                                      errorText: 'Sin resultados',
                                      onChanged: (p0) {
                                        setState(() {
                                          VarAddArtesano.localidad =
                                              TextEditingController();
                                        });
                                        FunctionAddArtesano.idMunicipioSelected(
                                            p0, 'artesano', listamunicipios);

                                        apiGetLocalidades(
                                            VarAddArtesano.idMunicipioArtesano,
                                            1);
                                      },
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      items: [
                                        for (var item in listamunicipios)
                                          item['municipio']
                                      ],
                                    )
                                  : LinearProgressIndicator(
                                      color: Styles.rojo,
                                    )),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          SizedBox(
                              width: Adaptive.w(30),
                              height: Adaptive.h(5),
                              child: getlocalidades == false
                                  ? CustomDropDownII.search(
                                      controller: VarAddArtesano.localidad,
                                      hintText: 'LOCALIDAD',
                                      selectedStyle:
                                          TextStyle(color: Styles.rojo),
                                      errorText: 'Sin resultados',
                                      onChanged: (p0) {
                                        FunctionAddArtesano.idLocalidadSelected(
                                            p0, 'artesano', listalocalidades);
                                      },
                                      borderSide:
                                          BorderSide(color: Styles.rojo),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      items: [
                                        for (var item in listalocalidades)
                                          item['localidad']
                                      ],
                                    )
                                  : LinearProgressIndicator(
                                      color: Styles.rojo,
                                    )),
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
                          Radio(
                            value: 'SI',
                            groupValue:
                                context.watch<CredencialProvider>().redesEdit,
                            activeColor: Styles.rojo,
                            onChanged: (val) {
                              context
                                  .read<CredencialProvider>()
                                  .setRedes("SI", true);
                            },
                          ),
                          Text("SI",
                              style: TextStyle(fontSize: Adaptive.sp(11))),
                          Radio(
                            value: 'NO',
                            groupValue:
                                context.watch<CredencialProvider>().redesEdit,
                            activeColor: Styles.rojo,
                            onChanged: (val) {
                              setState(() {
                                VarAddArtesano.fullRedes = " < < < < ";
                              });
                              context
                                  .read<CredencialProvider>()
                                  .setRedes("NO", false);
                            },
                          ),
                          Text("NO",
                              style: TextStyle(fontSize: Adaptive.sp(11))),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          IconButton(
                              onPressed:
                                  context.watch<CredencialProvider>().redes ==
                                          false
                                      ? null
                                      : () {
                                          setState(() {
                                            posicion = 0;
                                            VarAddArtesano.redesSociales.text =
                                                sociales[posicion];
                                          });
                                          context
                                              .read<CredencialProvider>()
                                              .setSocialSelected('face');
                                        },
                              icon: Image.asset(
                                "assets/images/ORGANIZACION_INFORMACION-04.png",
                                width: Adaptive.w(2),
                                color: context
                                            .read<CredencialProvider>()
                                            .flagFace ==
                                        false
                                    ? Colors.grey
                                    : Styles.rojo,
                              )),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          IconButton(
                              onPressed:
                                  context.watch<CredencialProvider>().redes ==
                                          false
                                      ? null
                                      : () {
                                          setState(() {
                                            posicion = 1;
                                            VarAddArtesano.redesSociales.text =
                                                sociales[posicion];
                                          });
                                          context
                                              .read<CredencialProvider>()
                                              .setSocialSelected("insta");
                                        },
                              icon: Image.asset(
                                "assets/images/ORGANIZACION_INFORMACION-05.png",
                                width: Adaptive.w(2),
                                color: context
                                            .read<CredencialProvider>()
                                            .flagInsta ==
                                        false
                                    ? Colors.grey
                                    : Styles.rojo,
                              )),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          IconButton(
                              onPressed:
                                  context.watch<CredencialProvider>().redes ==
                                          false
                                      ? null
                                      : () {
                                          setState(() {
                                            posicion = 2;
                                            VarAddArtesano.redesSociales.text =
                                                sociales[posicion];
                                          });
                                          context
                                              .read<CredencialProvider>()
                                              .setSocialSelected("twitter");
                                        },
                              icon: Image.asset(
                                "assets/images/ORGANIZACION_INFORMACION-06.png",
                                width: Adaptive.w(2),
                                color: context
                                            .read<CredencialProvider>()
                                            .flagTwitter ==
                                        false
                                    ? Colors.grey
                                    : Styles.rojo,
                              )),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          IconButton(
                              onPressed:
                                  context.watch<CredencialProvider>().redes ==
                                          false
                                      ? null
                                      : () {
                                          setState(() {
                                            posicion = 3;
                                            VarAddArtesano.redesSociales.text =
                                                sociales[posicion];
                                          });
                                          context
                                              .read<CredencialProvider>()
                                              .setSocialSelected("youtube");
                                        },
                              icon: Image.asset(
                                "assets/images/ORGANIZACION_INFORMACION-07.png",
                                width: Adaptive.w(2),
                                color: context
                                            .read<CredencialProvider>()
                                            .flagYoutube ==
                                        false
                                    ? Colors.grey
                                    : Styles.rojo,
                              )),
                          SizedBox(
                            width: Adaptive.w(0.5),
                          ),
                          IconButton(
                              onPressed:
                                  context.watch<CredencialProvider>().redes ==
                                          false
                                      ? null
                                      : () {
                                          setState(() {
                                            posicion = 4;
                                            VarAddArtesano.redesSociales.text =
                                                sociales[posicion];
                                          });
                                          context
                                              .read<CredencialProvider>()
                                              .setSocialSelected("tiktok");
                                        },
                              icon: Image.asset(
                                "assets/images/ORGANIZACION_INFORMACION-08.png",
                                width: Adaptive.w(2),
                                color: context
                                            .read<CredencialProvider>()
                                            .flagTiktok ==
                                        false
                                    ? Colors.grey
                                    : Styles.rojo,
                              )),
                          SizedBox(
                            width: Adaptive.w(1),
                          ),
                          SizedBox(
                            width: Adaptive.w(35),
                            height: Adaptive.h(5),
                            child: TextFormField(
                              cursorWidth: 2,
                              cursorHeight: 15,
                              enabled:
                                  context.watch<CredencialProvider>().redes,
                              controller: VarAddArtesano.redesSociales,
                              inputFormatters: [
                                CapitalLetters(),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  sociales[posicion] = value;
                                });
                              },
                              decoration: Styles().inputStyleArtesano(context
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
                                        controller: VarAddArtesano.etnia,
                                        hintText: 'GRUPO ETNICO',
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          FunctionAddArtesano.idGrupoSelected(
                                              p0, listGrupos);
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
                                        hintText: 'RAMA ARTESANAL',
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          FunctionAddArtesano.idRamaSelected(
                                              p0, 'artesano', listRamas);
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
                                        controller: VarAddArtesano.tecnica,
                                        hintText: 'PRODUCTOS ELABORADOS',
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          FunctionAddArtesano.idTecnicaSelected(
                                              p0, 'artesano', listTecnicas);
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
                              controller: VarAddArtesano.tipoInscripcion,
                              hintText: 'TIPO DE INSCRIPCION',
                              selectedStyle: TextStyle(color: Styles.rojo),
                              errorText: 'Sin resultados',
                              onChanged: (p0) {
                                setState(() {
                                  VarAddArtesano.tipoInscripcion.text = p0;
                                });
                                switch (p0) {
                                  case 'FAMILIAR':
                                    setState(() {
                                      VarAddArtesano.familiar = true;
                                      VarAddArtesano.tipoOrganizacion =
                                          'TALLER';
                                    });
                                    break;
                                  case 'GRUPAL':
                                    setState(() {
                                      VarAddArtesano.familiar = true;
                                      VarAddArtesano.tipoOrganizacion =
                                          'ORGANIZACION';
                                    });
                                    break;
                                  case 'INDIVIDUAL':
                                    setState(() {
                                      VarAddArtesano.familiar = false;
                                      VarAddArtesano.idAgrupacion = ".";
                                    });
                                    break;
                                  default:
                                }
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
                                          hintText: 'MATERIA PRIMA',
                                          selectedStyle:
                                              TextStyle(color: Styles.rojo),
                                          errorText: 'Sin resultados',
                                          onChanged: (p0) {
                                            FunctionAddArtesano
                                                .idMateriaSelected(
                                                    p0, listMateriaPrimas);
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
                                        hintText: 'CANAL DE COMERCIALIZACION',
                                        selectedStyle:
                                            TextStyle(color: Styles.rojo),
                                        errorText: 'Sin resultados',
                                        onChanged: (p0) {
                                          FunctionAddArtesano.idCanalSelected(
                                              p0, listTipoCompradores);
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
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Adaptive.h(2),
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
                                          FunctionAddArtesano.idLenguaSelected(
                                              p0, listLenguas);
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
                            width: Adaptive.w(60),
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
                              decoration:
                                  Styles().inputStyleArtesano("OBSERVACIONES"),
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
                      VarAddArtesano.familiar == true
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: Adaptive.w(90),
                                        child: Text(
                                          "AGRUPACION / TALLER FAMILIAR",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: Adaptive.sp(14)),
                                        ))
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Adaptive.w(2),
                                    ),
                                    const Text("NUEVO"),
                                    SizedBox(
                                      width: Adaptive.w(1),
                                    ),
                                    Radio(
                                      value: 'SI',
                                      groupValue: context
                                          .watch<CredencialProvider>()
                                          .newTaller,
                                      activeColor: Styles.rojo,
                                      onChanged: (val) {
                                        context
                                            .read<CredencialProvider>()
                                            .setnewTaller("SI");
                                      },
                                    ),
                                    Text("SI",
                                        style: TextStyle(
                                            fontSize: Adaptive.sp(11))),
                                    Radio(
                                      value: 'NO',
                                      groupValue: context
                                          .watch<CredencialProvider>()
                                          .newTaller,
                                      activeColor: Styles.rojo,
                                      onChanged: (val) {
                                        context
                                            .read<CredencialProvider>()
                                            .setnewTaller("NO");
                                      },
                                    ),
                                    Text("NO",
                                        style: TextStyle(
                                            fontSize: Adaptive.sp(11))),
                                    SizedBox(
                                      width: Adaptive.w(1),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Adaptive.h(2),
                                ),
                                context.watch<CredencialProvider>().newTaller ==
                                        'SI'
                                    ? Column(
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
                                                  controller:
                                                      VarAddArtesano.nombreT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "NOMBRE"),
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
                                                  controller: VarAddArtesano
                                                      .nombreRepresentanteT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "NOMBRE DEL REPRESENTANTE"),
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
                                                  controller:
                                                      VarAddArtesano.rfcT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                    LengthLimitingTextInputFormatter(
                                                        12),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "RFC"),
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
                                                  controller:
                                                      VarAddArtesano.calleT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "CALLE"),
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
                                                  controller: VarAddArtesano
                                                      .numInteriorT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "NUM. INTERIOR"),
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
                                                  controller: VarAddArtesano
                                                      .numExteriorT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "NUM. EXTERIOR"),
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
                                                  controller:
                                                      VarAddArtesano.cpT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp("[0-9]")),
                                                    LengthLimitingTextInputFormatter(
                                                        5),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano("CP"),
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
                                                  future: getRegionesTaller,
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                    return snapshot.hasData
                                                        ? CustomDropDownII
                                                            .search(
                                                            controller:
                                                                VarAddArtesano
                                                                    .regionT,
                                                            hintText: 'REGION',
                                                            selectedStyle:
                                                                TextStyle(
                                                                    color: Styles
                                                                        .rojo),
                                                            errorText:
                                                                'Sin resultados',
                                                            onChanged: (p0) {
                                                              setState(() {
                                                                VarAddArtesano
                                                                        .distritoT =
                                                                    TextEditingController();
                                                                VarAddArtesano
                                                                        .municipioT =
                                                                    TextEditingController();
                                                                VarAddArtesano
                                                                        .localidadT =
                                                                    TextEditingController();
                                                              });
                                                              FunctionAddArtesano
                                                                  .idRegionSelected(
                                                                      p0,
                                                                      'taller',
                                                                      listRegiones);

                                                              apiGetDistritos(
                                                                  VarAddArtesano
                                                                      .idRegionTaller,
                                                                  2);
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
                                                                  in listRegionesTaller
                                                                      .data)
                                                                item['region']
                                                            ],
                                                          )
                                                        : LinearProgressIndicator(
                                                            color: Styles.rojo,
                                                          );
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
                                                child: getdistritos2 == false
                                                    ? CustomDropDownII.search(
                                                        controller:
                                                            VarAddArtesano
                                                                .distritoT,
                                                        hintText: 'DISTRITO',
                                                        selectedStyle:
                                                            TextStyle(
                                                                color: Styles
                                                                    .rojo),
                                                        errorText:
                                                            'Sin resultados',
                                                        onChanged: (p0) {
                                                          setState(() {
                                                            VarAddArtesano
                                                                    .municipioT =
                                                                TextEditingController();
                                                            VarAddArtesano
                                                                    .localidadT =
                                                                TextEditingController();
                                                          });
                                                          FunctionAddArtesano
                                                              .idDistritoSelected(
                                                                  p0,
                                                                  'taller',
                                                                  listadistritos2);
                                                          apiGetMunicipios(
                                                              VarAddArtesano
                                                                  .idDistritoTaller,
                                                              2);
                                                        },
                                                        borderSide: BorderSide(
                                                            color: Styles.rojo),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    12)),
                                                        items: [
                                                          for (var item
                                                              in listadistritos2)
                                                            item['distrito']
                                                        ],
                                                      )
                                                    : LinearProgressIndicator(
                                                        color: Styles.rojo,
                                                      ),
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(1),
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(30),
                                                height: Adaptive.h(5),
                                                child: getmunicipios2 == false
                                                    ? CustomDropDownII.search(
                                                        controller:
                                                            VarAddArtesano
                                                                .municipioT,
                                                        hintText: 'MUNICIPIO',
                                                        selectedStyle:
                                                            TextStyle(
                                                                color: Styles
                                                                    .rojo),
                                                        errorText:
                                                            'Sin resultados',
                                                        onChanged: (p0) {
                                                          setState(() {
                                                            VarAddArtesano
                                                                    .localidadT =
                                                                TextEditingController();
                                                          });
                                                          FunctionAddArtesano
                                                              .idMunicipioSelected(
                                                                  p0,
                                                                  'taller',
                                                                  listamunicipios2);
                                                          apiGetLocalidades(
                                                              VarAddArtesano
                                                                  .idMunicipioTaller,
                                                              2);
                                                        },
                                                        borderSide: BorderSide(
                                                            color: Styles.rojo),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    12)),
                                                        items: [
                                                          for (var item
                                                              in listamunicipios2)
                                                            item['municipio']
                                                        ],
                                                      )
                                                    : LinearProgressIndicator(
                                                        color: Styles.rojo,
                                                      ),
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(1),
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(30),
                                                height: Adaptive.h(5),
                                                child: getlocalidades2 == false
                                                    ? CustomDropDownII.search(
                                                        controller:
                                                            VarAddArtesano
                                                                .localidadT,
                                                        hintText: 'LOCALIDAD',
                                                        selectedStyle:
                                                            TextStyle(
                                                                color: Styles
                                                                    .rojo),
                                                        errorText:
                                                            'Sin resultados',
                                                        onChanged: (p0) {
                                                          FunctionAddArtesano
                                                              .idLocalidadSelected(
                                                                  p0,
                                                                  'taller',
                                                                  listalocalidades2);
                                                        },
                                                        borderSide: BorderSide(
                                                            color: Styles.rojo),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    12)),
                                                        items: [
                                                          for (var item
                                                              in listalocalidades2)
                                                            item['localidad']
                                                        ],
                                                      )
                                                    : LinearProgressIndicator(
                                                        color: Styles.rojo,
                                                      ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Adaptive.h(2),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  controller:
                                                      VarAddArtesano.correoT,
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "CORREO"),
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
                                                  controller:
                                                      VarAddArtesano.celularT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp("[0-9]")),
                                                    LengthLimitingTextInputFormatter(
                                                        10),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "TELEFONO MOVIL"),
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
                                                  controller:
                                                      VarAddArtesano.telefonoT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp("[0-9]")),
                                                    LengthLimitingTextInputFormatter(
                                                        10),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "TELEFONO LOCAL"),
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
                                                  controller: VarAddArtesano
                                                      .totalHombresT,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp("[0-9]")),
                                                    LengthLimitingTextInputFormatter(
                                                        5),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "TOTAL DE HOMBRES"),
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
                                                  controller: VarAddArtesano
                                                      .totalMujeresT,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp("[0-9]")),
                                                    LengthLimitingTextInputFormatter(
                                                        5),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "TOTAL DE MUJERES"),
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
                                                  controller: VarAddArtesano
                                                      .tipoOrganizacionT,
                                                  hintText:
                                                      'TIPO DE ORGANIZACION',
                                                  selectedStyle: TextStyle(
                                                      color: Styles.rojo),
                                                  errorText: 'Sin resultados',
                                                  onChanged: (p0) {},
                                                  borderSide: BorderSide(
                                                      color: Styles.rojo),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(12)),
                                                  items: const [
                                                    'ONG',
                                                    'PUBLICA'
                                                  ],
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
                                                child: CustomDropDownII.search(
                                                  controller:
                                                      VarAddArtesano.ramaT,
                                                  hintText: 'RAMA ARTESANAL',
                                                  selectedStyle: TextStyle(
                                                      color: Styles.rojo),
                                                  errorText: 'Sin resultados',
                                                  onChanged: (p0) {
                                                    FunctionAddArtesano
                                                        .idRamaSelected(
                                                            p0,
                                                            'taller',
                                                            listRamas);
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
                                                ),
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(1),
                                              ),
                                              SizedBox(
                                                width: Adaptive.w(30),
                                                height: Adaptive.h(5),
                                                child: CustomDropDownII.search(
                                                  controller:
                                                      VarAddArtesano.tecnicaT,
                                                  hintText:
                                                      'PRODUCTOS ELABORADOS',
                                                  selectedStyle: TextStyle(
                                                      color: Styles.rojo),
                                                  errorText: 'Sin resultados',
                                                  onChanged: (p0) {
                                                    FunctionAddArtesano
                                                        .idTecnicaSelected(
                                                            p0,
                                                            'taller',
                                                            listTecnicas);
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
                                                  controller: VarAddArtesano
                                                      .descripcionT,
                                                  inputFormatters: [
                                                    CapitalLetters(),
                                                  ],
                                                  onChanged: (value) {},
                                                  decoration: Styles()
                                                      .inputStyleArtesano(
                                                          "DESCRIPCION"),
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
                                            height: Adaptive.h(6),
                                          ),
                                          Center(
                                              child: OutlinedLoadingButton(
                                                  isLoading: createTaller,
                                                  loadingIcon:
                                                      const Icon(Icons.add),
                                                  loadingLabel: const Text(
                                                      'Creando taller familiar...'),
                                                  style: Styles.buttonStyleCred,
                                                  onPressed: VarAddArtesano
                                                              .addTaller ==
                                                          false
                                                      ? () async {
                                                          setState(() {
                                                            createTaller = true;
                                                          });
                                                          if (await apiAddOrganizacion()) {
                                                            // ignore: use_build_context_synchronously
                                                            Message().mensaje(
                                                                Colors.green,
                                                                Icons.done,
                                                                'Agrupación creada',
                                                                context);
                                                          } else {
                                                            // ignore: use_build_context_synchronously
                                                            Message().mensaje(
                                                                Colors.red,
                                                                Icons.error,
                                                                'Error, intenta de nuevo',
                                                                context);
                                                          }
                                                          setState(() {
                                                            createTaller =
                                                                false;
                                                          });
                                                        }
                                                      : null,
                                                  child: const Text(
                                                      "CREAR TALLER FAMILIAR"))),
                                          SizedBox(
                                            height: Adaptive.h(2),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        width: Adaptive.w(60),
                                        height: Adaptive.h(5),
                                        child: FutureBuilder(
                                          future: getTalleres,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<dynamic> snapshot) {
                                            return snapshot.hasData
                                                ? CustomDropDownII.search(
                                                    controller:
                                                        VarAddArtesano.tallerT,
                                                    hintText:
                                                        'AGRUPACIONES / TALLERES FAMILIARES',
                                                    selectedStyle: TextStyle(
                                                        color: Styles.rojo),
                                                    errorText: 'Sin resultados',
                                                    onChanged: (p0) {
                                                      FunctionAddArtesano
                                                          .idOrganizacionSelected(
                                                              p0, listTalleres);
                                                    },
                                                    borderSide: BorderSide(
                                                        color: Styles.rojo),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    items: [
                                                      for (var item
                                                          in listTalleres.data)
                                                        item[
                                                            'nombre_organizacion']
                                                    ],
                                                  )
                                                : const LinearProgressIndicator();
                                          },
                                        ),
                                      )
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: Adaptive.h(3),
                      ),
                      Center(
                          child: OutlinedLoadingButton(
                              isLoading: createArtesano,
                              style: Styles.buttonStyleCred,
                              onPressed: () async {
                                if (VarAddArtesano.idAgrupacion != "") {
                                  setState(() {
                                    createArtesano = true;
                                  });
                                  if (await apiAddArtesano(context)) {
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<CredencialProvider>()
                                        .setRedes("NO", true);
                                    FunctionAddArtesano.clean();
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<CredencialProvider>()
                                        .setnewOrganizacion('SI');
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<CredencialProvider>()
                                        .setnewTaller('SI');

                                    setState(() {
                                      createArtesano = false;
                                    });
                                    // ignore: use_build_context_synchronously
                                    Message().mensaje(Colors.green, Icons.done,
                                        'Persona artesana añadida', context);

                                  } else {
                                    setState(() {
                                      createArtesano = false;
                                    });
                                  }
                                } else {
                                  // ignore: use_build_context_synchronously
                                  Message().mensaje(
                                      Colors.red,
                                      Icons.error,
                                      'Selecciona o crea una organizacion/taller',
                                      context);
                                }
                              },
                              child: const Text("AÑADIR PERSONA ARTESANA"))),
                      SizedBox(
                        height: Adaptive.h(1),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
