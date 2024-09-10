import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scav/src/providers/login_provider_c.dart';
import 'package:scav/src/utils/messages.dart';
import 'package:scav/src/utils/styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scav/src/utils/variables.dart';
import 'package:vrouter/vrouter.dart';
import 'package:material_loading_buttons/material_loading_buttons.dart';
import 'package:cooky/cooky.dart' as cookie;

class LoginScreenCapacitacion extends StatefulWidget {
  const LoginScreenCapacitacion({super.key});

  @override
  State<LoginScreenCapacitacion> createState() =>
      _LoginScreenCapacitacionState();
}

class _LoginScreenCapacitacionState extends State<LoginScreenCapacitacion> {
  TextEditingController correo = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool sesion = false;

  Dio dio = Dio();

  Response logIn = Response(requestOptions: RequestOptions());

  Future login() async {
    logIn = await dio.post('${GlobalVariable.baseUrlApi}scav/v1/user/login',
        data: {"email": correo.text, "password": password.text, "tipo": "2"});

    if (logIn.statusCode == 200) {
      setState(() {
        sesion = false;
      });
      return true;
    } else {
      // ignore: use_build_context_synchronously
      Message()
          .mensaje(Colors.amber, Icons.warning, logIn.data['mensaje'], context);
      setState(() {
        sesion = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: Adaptive.w(100),
              height: Adaptive.h(30),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/images/ORGANIZACION_INFORMACION-03.png"))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                      icon: const Icon(Icons.wifi_off),
                      style: Styles.buttonBordersRigth,
                      onPressed: () {
                        context.vRouter.to("/homeOfflineCapacitacion");
                      },
                      label: Text(
                        "OFFLINE",
                        style: TextStyle(fontSize: Adaptive.sp(11)),
                      )),
                  Expanded(
                    child: Container(),
                  ),
                  Image.asset(
                    "assets/images/ORGANIZACION_INFORMACION-09.png",
                    width: Adaptive.w(20),
                  ),
                  SizedBox(
                    width: Adaptive.w(28),
                  ),
                  ElevatedButton.icon(
                      icon: const Icon(Icons.home),
                      style: Styles.buttonLogoutArtesano,
                      onPressed: () {
                        context.vRouter.to("/home");
                      },
                      label: Text(
                        "MENU PRINCIPAL",
                        style: TextStyle(fontSize: Adaptive.sp(11)),
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Adaptive.w(1), vertical: Adaptive.h(2)),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/x.PNG"))),
              child: Container(
                decoration: Styles().containerCredMargin,
                child: Column(
                  children: [
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    Center(
                        child: Text(
                      "SISTEMA DE CAPACITACIONES",
                      style: TextStyle(
                          color: Styles.rojo, fontWeight: FontWeight.bold),
                    )),
                    SizedBox(
                      height: Adaptive.h(4),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "CORREO",
                          style: TextStyle(
                              color: Styles.crema2,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        Container(
                          decoration: Styles().containerCred,
                          width: Adaptive.w(40),
                          child: TextFormField(
                            controller: correo,
                            decoration: Styles().inputLoginCred(),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              value = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Este campo no puede estar vacío";
                              }
                              if (!value.contains('@')) {
                                return "Formato de correo inválido";
                              }
                              if (!value.contains('.')) {
                                return "Formato de correo inválido";
                              }
                              if (!value.contains('com')) {
                                return "Formato de correo inválido";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: Adaptive.h(5),
                        ),
                        Text(
                          "CONTRASEÑA",
                          style: TextStyle(
                              color: Styles.crema2,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: Adaptive.h(2),
                        ),
                        Container(
                          decoration: Styles().containerCred,
                          width: Adaptive.w(40),
                          child: TextFormField(
                            controller: password,
                            onEditingComplete: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  sesion = true;
                                });
                                if (await login() == true) {
                                  cookie.set('idCap', logIn.data['id_usuario'],
                                      maxAge: const Duration(days: 6));
                                  switch (logIn.data['rol']) {
                                    case 'Administrador':
                                      // ignore: use_build_context_synchronously
                                      context.vRouter.to("/homeCapacitacion");
                                      break;
                                    case 'Capturista':
                                      // ignore: use_build_context_synchronously
                                      context.vRouter
                                          .to("/homeCapacitacionCap");
                                      break;
                                    case 'Consultor':
                                      // ignore: use_build_context_synchronously
                                      context.vRouter
                                          .to("/homeCapacitacionCon");
                                      break;
                                    default:
                                  }
                                }
                              }
                            },
                            obscureText: context.watch<LoginProvider>().passC,
                            decoration: Styles().inputPasswordCred(context),
                            onChanged: (value) {
                              value = value;
                            },
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
                      height: Adaptive.h(5),
                    ),
                    OutlinedLoadingButton(
                        isLoading: sesion,
                        style: Styles.buttonStyleCred,
                        loadingIcon: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Styles.rojo),
                        ),
                        loadingLabel: const Text('CARGANDO'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              sesion = true;
                            });
                            if (await login() == true) {
                              cookie.set('idCap', logIn.data['id_usuario'],
                                  maxAge: const Duration(days: 6));
                              switch (logIn.data['rol']) {
                                case 'Administrador':
                                  // ignore: use_build_context_synchronously
                                  context.vRouter.to("/homeCapacitacion");
                                  break;
                                case 'Capturista':
                                  // ignore: use_build_context_synchronously
                                  context.vRouter.to("/homeCapacitacionCap");
                                  break;
                                case 'Consultor':
                                  // ignore: use_build_context_synchronously
                                  context.vRouter.to("/homeCapacitacionCon");
                                  break;
                                default:
                              }
                            }
                          }
                        },
                        child: const Text("INGRESAR")),
                    SizedBox(
                      height: Adaptive.h(3),
                    ),
                    SizedBox(
                      width: Adaptive.w(100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: Adaptive.w(40),
                            height: Adaptive.h(0.3),
                            color: Styles.crema2,
                          ),
                          SizedBox(
                            width: Adaptive.w(0.7),
                          ),
                          Image.asset(
                            "assets/images/xx.PNG",
                            width: Adaptive.w(2),
                          ),
                          SizedBox(
                            width: Adaptive.w(0.7),
                          ),
                          Container(
                            width: Adaptive.w(40),
                            height: Adaptive.h(0.3),
                            color: Styles.crema2,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Adaptive.h(2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
