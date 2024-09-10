import 'package:flutter_excel/excel.dart';
import 'package:scav/src/utils/data/offline.dart';
import 'package:scav/src/utils/data/offline_capacitacion.dart';
import 'package:scav/src/utils/variables.dart';

class ExcelFunciones {
  
  static createExcelOrganizaciones() {
    var excel = Excel.createExcel();

    excel.rename('Sheet1', 'Registros');

    Sheet sheetObject = excel['Registros'];

    for (var i = 1; i <= Offline.organizacionesList.length; i++) {
      var d = i - 1;

      var cell = sheetObject.cell(CellIndex.indexByString("A$i"));
      cell.value = Offline.organizacionesList[d]['id_organizacion'].toString();
      var cell2 = sheetObject.cell(CellIndex.indexByString("B$i"));
      cell2.value = Offline.organizacionesList[d]['representante'].toString();
      var cell3 = sheetObject.cell(CellIndex.indexByString("C$i"));
      cell3.value =
          Offline.organizacionesList[d]['nombre_organizacion'].toString();
      var cell4 = sheetObject.cell(CellIndex.indexByString("D$i"));
      cell4.value = Offline.organizacionesList[d]['rfc'].toString();
      var cell5 = sheetObject.cell(CellIndex.indexByString("E$i"));
      cell5.value = Offline.organizacionesList[d]['calle'].toString();
      var cell6 = sheetObject.cell(CellIndex.indexByString("F$i"));
      cell6.value = Offline.organizacionesList[d]['num_exterior'].toString();
      var cell7 = sheetObject.cell(CellIndex.indexByString("G$i"));
      cell7.value = Offline.organizacionesList[d]['num_interior'].toString();
      var cell8 = sheetObject.cell(CellIndex.indexByString("H$i"));
      cell8.value = Offline.organizacionesList[d]['cp'].toString();
      var cell9 = sheetObject.cell(CellIndex.indexByString("I$i"));
      cell9.value = Offline.organizacionesList[d]['id_region'].toString();
      var cell10 = sheetObject.cell(CellIndex.indexByString("J$i"));
      cell10.value = Offline.organizacionesList[d]['id_distrito'].toString();
      var cell11 = sheetObject.cell(CellIndex.indexByString("K$i"));
      cell11.value = Offline.organizacionesList[d]['id_municipio'].toString();
      var cell12 = sheetObject.cell(CellIndex.indexByString("L$i"));
      cell12.value = Offline.organizacionesList[d]['id_localidad'].toString();
      var cell13 = sheetObject.cell(CellIndex.indexByString("M$i"));
      cell13.value = Offline.organizacionesList[d]['tel_fijo'].toString();
      var cell14 = sheetObject.cell(CellIndex.indexByString("N$i"));
      cell14.value = Offline.organizacionesList[d]['tel_celular'].toString();
      var cell15 = sheetObject.cell(CellIndex.indexByString("O$i"));
      cell15.value = Offline.organizacionesList[d]['correo'].toString();
      var cell16 = sheetObject.cell(CellIndex.indexByString("P$i"));
      cell16.value =
          Offline.organizacionesList[d]['num_integrantes'].toString();
      var cell17 = sheetObject.cell(CellIndex.indexByString("Q$i"));
      cell17.value = Offline.organizacionesList[d]['hombres'].toString();
      var cell18 = sheetObject.cell(CellIndex.indexByString("R$i"));
      cell18.value = Offline.organizacionesList[d]['mujeres'].toString();
      var cell19 = sheetObject.cell(CellIndex.indexByString("S$i"));
      cell19.value = Offline.organizacionesList[d]['activo'].toString();
      var cell20 = sheetObject.cell(CellIndex.indexByString("T$i"));
      cell20.value = Offline.organizacionesList[d]['created_at'].toString();
      var cell21 = sheetObject.cell(CellIndex.indexByString("U$i"));
      cell21.value = Offline.organizacionesList[d]['updated_at'].toString();
      var cell22 = sheetObject.cell(CellIndex.indexByString("V$i"));
      cell22.value = Offline.organizacionesList[d]['descripcion'].toString();
      var cell23 = sheetObject.cell(CellIndex.indexByString("W$i"));
      cell23.value = Offline.organizacionesList[d]['tipo_org'].toString();
      var cell24 = sheetObject.cell(CellIndex.indexByString("X$i"));
      cell24.value = Offline.organizacionesList[d]['tipo'].toString();
      var cell25 = sheetObject.cell(CellIndex.indexByString("Y$i"));
      cell25.value = Offline.organizacionesList[d]['id_rama'].toString();
      var cell26 = sheetObject.cell(CellIndex.indexByString("Z$i"));
      cell26.value = Offline.organizacionesList[d]['id_tecnica'].toString();
    }

    var fileBytes = excel.save(
        fileName: "Registros_Organizaciones_${GlobalVariable.currentDate}.csv");
    fileBytes;
  }

  static createExcel() {
    var excel = Excel.createExcel();

    excel.rename('Sheet1', 'Registros');

    Sheet sheetObject = excel['Registros'];

    for (var i = 1; i <= Offline.artesanosList.length; i++) {
      var d = i - 1;

      var cell = sheetObject.cell(CellIndex.indexByString("A$i"));
      cell.value = Offline.artesanosList[d]['id_artesano'].toString();
      var cell2 = sheetObject.cell(CellIndex.indexByString("B$i"));
      cell2.value = Offline.artesanosList[d]['nombre'].toString();
      var cell3 = sheetObject.cell(CellIndex.indexByString("C$i"));
      cell3.value = Offline.artesanosList[d]['primer_apellido'].toString();
      var cell4 = sheetObject.cell(CellIndex.indexByString("D$i"));
      cell4.value = Offline.artesanosList[d]['segundo_apellido'].toString();
      var cell5 = sheetObject.cell(CellIndex.indexByString("E$i"));
      cell5.value = Offline.artesanosList[d]['sexo'].toString();
      var cell6 = sheetObject.cell(CellIndex.indexByString("F$i"));
      cell6.value = Offline.artesanosList[d]['fecha_nacimiento'].toString();
      var cell7 = sheetObject.cell(CellIndex.indexByString("G$i"));
      cell7.value = Offline.artesanosList[d]['edo_civil'].toString();
      var cell8 = sheetObject.cell(CellIndex.indexByString("H$i"));
      cell8.value = Offline.artesanosList[d]['curp'].toString();
      var cell9 = sheetObject.cell(CellIndex.indexByString("I$i"));
      cell9.value = Offline.artesanosList[d]['clave_ine'].toString();
      var cell10 = sheetObject.cell(CellIndex.indexByString("J$i"));
      cell10.value = Offline.artesanosList[d]['rfc'].toString();
      var cell11 = sheetObject.cell(CellIndex.indexByString("K$i"));
      cell11.value = Offline.artesanosList[d]['calle'].toString();
      var cell12 = sheetObject.cell(CellIndex.indexByString("L$i"));
      cell12.value = Offline.artesanosList[d]['num_exterior'].toString();
      var cell13 = sheetObject.cell(CellIndex.indexByString("M$i"));
      cell13.value = Offline.artesanosList[d]['num_interior'].toString();
      var cell14 = sheetObject.cell(CellIndex.indexByString("N$i"));
      cell14.value = Offline.artesanosList[d]['cp'].toString();
      var cell15 = sheetObject.cell(CellIndex.indexByString("O$i"));
      cell15.value = Offline.artesanosList[d]['id_region'].toString();
      var cell16 = sheetObject.cell(CellIndex.indexByString("P$i"));
      cell16.value = Offline.artesanosList[d]['id_distrito'].toString();
      var cell17 = sheetObject.cell(CellIndex.indexByString("Q$i"));
      cell17.value = Offline.artesanosList[d]['id_municipio'].toString();
      var cell18 = sheetObject.cell(CellIndex.indexByString("R$i"));
      cell18.value = Offline.artesanosList[d]['id_localidad'].toString();
      var cell19 = sheetObject.cell(CellIndex.indexByString("S$i"));
      cell19.value = Offline.artesanosList[d]['seccion'].toString();
      var cell20 = sheetObject.cell(CellIndex.indexByString("T$i"));
      cell20.value = Offline.artesanosList[d]['tel_fijo'].toString();
      var cell21 = sheetObject.cell(CellIndex.indexByString("U$i"));
      cell21.value = Offline.artesanosList[d]['tel_celular'].toString();
      var cell22 = sheetObject.cell(CellIndex.indexByString("V$i"));
      cell22.value = Offline.artesanosList[d]['correo'].toString();
      var cell23 = sheetObject.cell(CellIndex.indexByString("W$i"));
      cell23.value = Offline.artesanosList[d]['redes_sociales'].toString();
      var cell24 = sheetObject.cell(CellIndex.indexByString("X$i"));
      cell24.value = Offline.artesanosList[d]['escolaridad'].toString();
      var cell25 = sheetObject.cell(CellIndex.indexByString("Y$i"));
      cell25.value = Offline.artesanosList[d]['id_grupo'].toString();
      var cell26 = sheetObject.cell(CellIndex.indexByString("Z$i"));
      cell26.value = Offline.artesanosList[d]['gpo_pertenencia'].toString();
      var cell27 = sheetObject.cell(CellIndex.indexByString("AA$i"));
      cell27.value = Offline.artesanosList[d]['id_organizacion'].toString();
      var cell28 = sheetObject.cell(CellIndex.indexByString("AB$i"));
      cell28.value = Offline.artesanosList[d]['id_materia_prima'].toString();
      var cell29 = sheetObject.cell(CellIndex.indexByString("AC$i"));
      cell29.value = Offline.artesanosList[d]['id_venta_producto'].toString();
      var cell30 = sheetObject.cell(CellIndex.indexByString("AD$i"));
      cell30.value = Offline.artesanosList[d]['id_tipo_comprador'].toString();
      var cell31 = sheetObject.cell(CellIndex.indexByString("AE$i"));
      cell31.value = Offline.artesanosList[d]['folio_cuis'].toString();
      var cell32 = sheetObject.cell(CellIndex.indexByString("AF$i"));
      cell32.value = Offline.artesanosList[d]['foto'].toString();
      var cell33 = sheetObject.cell(CellIndex.indexByString("AG$i"));
      cell33.value = Offline.artesanosList[d]['activo'].toString();
      var cell34 = sheetObject.cell(CellIndex.indexByString("AH$i"));
      cell34.value = Offline.artesanosList[d]['nombre_archivo'].toString();
      var cell35 = sheetObject.cell(CellIndex.indexByString("AI$i"));
      cell35.value = Offline.artesanosList[d]['comentarios'].toString();
      var cell36 = sheetObject.cell(CellIndex.indexByString("AJ$i"));
      cell36.value = Offline.artesanosList[d]['id_lengua'].toString();
      var cell37 = sheetObject.cell(CellIndex.indexByString("AK$i"));
      cell37.value = Offline.artesanosList[d]['longitud'].toString();
      var cell38 = sheetObject.cell(CellIndex.indexByString("AL$i"));
      cell38.value = Offline.artesanosList[d]['latitud'].toString();
      var cell39 = sheetObject.cell(CellIndex.indexByString("AM$i"));
      cell39.value = Offline.artesanosList[d]['created_at'].toString();
      var cell40 = sheetObject.cell(CellIndex.indexByString("AN$i"));
      cell40.value = Offline.artesanosList[d]['updated_at'].toString();
      var cell41 = sheetObject.cell(CellIndex.indexByString("AO$i"));
      cell41.value = Offline.artesanosList[d]['recados'].toString();
      var cell42 = sheetObject.cell(CellIndex.indexByString("AP$i"));
      cell42.value = Offline.artesanosList[d]['id_rama'].toString();
      var cell43 = sheetObject.cell(CellIndex.indexByString("AQ$i"));
      cell43.value = Offline.artesanosList[d]['id_tecnica'].toString();
      var cell44 = sheetObject.cell(CellIndex.indexByString("AR$i"));
      cell44.value = Offline.artesanosList[d]['id_materiaprima'].toString();
      var cell45 = sheetObject.cell(CellIndex.indexByString("AS$i"));
      cell45.value = Offline.artesanosList[d]['id_canal'].toString();
      var cell46 = sheetObject.cell(CellIndex.indexByString("AT$i"));
      cell46.value = Offline.artesanosList[d]['fecha_entrega_credencial'].toString();
      var cell47 = sheetObject.cell(CellIndex.indexByString("AU$i"));
      cell47.value = Offline.artesanosList[d]['proveedor'].toString();
    }

    var fileBytes = excel.save(
        fileName: "Registros_Artesanos_${GlobalVariable.currentDate}.csv");
    fileBytes;
  }


  static createExcelInscripciones() {

    var excel = Excel.createExcel();

    excel.rename('Sheet1', 'Registros Inscripciones');

    Sheet sheetObject = excel['Registros Inscripciones'];

    for (var i = 1;
        i <= OfflineDataCapacitacion.inscripcionesOffline.length;
        i++) {
      var d = i - 1;

      var cell = sheetObject.cell(CellIndex.indexByString("A$i"));
      cell.value = 'DEFAULT';
      var cell2 = sheetObject.cell(CellIndex.indexByString("B$i"));
      cell2.value = OfflineDataCapacitacion.inscripcionesOffline[d]
              ['id_artesano']
          .toString();
      var cell3 = sheetObject.cell(CellIndex.indexByString("C$i"));
      cell3.value = OfflineDataCapacitacion.inscripcionesOffline[d]['solicitud']
          .toString();
      var cell4 = sheetObject.cell(CellIndex.indexByString("D$i"));
      cell4.value = OfflineDataCapacitacion.inscripcionesOffline[d]
              ['observaciones']
          .toString();
      var cell5 = sheetObject.cell(CellIndex.indexByString("E$i"));
      cell5.value = OfflineDataCapacitacion.inscripcionesOffline[d]['id_accion']
          .toString();
      var cell6 = sheetObject.cell(CellIndex.indexByString("F$i"));
      cell6.value = OfflineDataCapacitacion.inscripcionesOffline[d]
              ['created_at']
          .toString();
      var cell7 = sheetObject.cell(CellIndex.indexByString("G$i"));
      cell7.value = OfflineDataCapacitacion.inscripcionesOffline[d]
              ['updated_at']
          .toString();
    }

    var fileBytes = excel.save(
        fileName: "Registros_Inscripciones_${GlobalVariable.currentDate}.csv");
    fileBytes;
  }

  
}
