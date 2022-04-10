import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:salud_ilo/core/uitls/universal_file/save_file_mobile.dart'
    if (dart.library.html) 'package:salud_ilo/core/uitls/universal_file/save_file_web.dart';

import '../../../domain/grid_entity.dart';
import '../../../domain/resumenEntity.dart';

PdfPen borderPen = PdfPen(PdfColor.fromCMYK(10, 50, 55, 100));
PdfBorders borders = PdfBorders()..bottom = borderPen;

generarGridHeader(PdfGrid grid) {
// Specify the grid column count.
  grid.columns.add(count: 14);
  grid.columns[0].width = 50;
  // Add a grid header row.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  headerRow.cells[0].value = 'Concepto';
  headerRow.cells[1].value = 'Ene';
  headerRow.cells[2].value = 'Feb';
  headerRow.cells[3].value = 'Mar';
  headerRow.cells[4].value = 'Abr';
  headerRow.cells[5].value = 'May';
  headerRow.cells[6].value = 'Jun';
  headerRow.cells[7].value = 'Jul';
  headerRow.cells[8].value = 'Ago';
  headerRow.cells[9].value = 'Set';
  headerRow.cells[10].value = 'Oct';
  headerRow.cells[11].value = 'Nov';
  headerRow.cells[12].value = 'Dic';
  headerRow.cells[13].value = 'Total';

  // Set header font.
  //headerRow.style.font = fontHeaderGrid;
  headerRow.height = 13;

  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.stringFormat = PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
        wordSpacing: 10);
  }
}

generarGridRow(PdfGrid grid, GridEntity resumen) {
  // Create a PDF grid class to add tables.

  PdfGridRow row = grid.rows.add();

  row.cells[0].value = resumen.concepto;
  row.cells[1].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.enero.toStringAsFixed(2)));

  row.cells[2].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.febrero.toStringAsFixed(2)));
  row.cells[3].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.marzo.toStringAsFixed(2)));
  row.cells[4].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.abril.toStringAsFixed(2)));
  row.cells[5].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.mayo.toStringAsFixed(2)));
  row.cells[6].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.junio.toStringAsFixed(2)));
  row.cells[7].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.julio.toStringAsFixed(2)));
  row.cells[8].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.agosto.toStringAsFixed(2)));
  row.cells[9].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.setiembre.toStringAsFixed(2)));
  row.cells[10].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.octubre.toStringAsFixed(2)));
  row.cells[11].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.noviembre.toStringAsFixed(2)));
  row.cells[12].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.diciembre.toStringAsFixed(2)));
  row.cells[13].value = NumberFormat('#,##0.00', 'en_US')
      .format(double.parse(resumen.total.toStringAsFixed(2)));

  row.cells[0].stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.left,
      lineAlignment: PdfVerticalAlignment.middle,
      wordSpacing: 10);

  for (int r = 0; r < row.cells.count; r++) {
    if (r > 0) {
      row.cells[r].stringFormat = PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle,
          wordSpacing: 10);
    }

    if (row.cells[0].value == 'Ingresos' ||
        row.cells[0].value == 'Descuentos' ||
        row.cells[0].value == 'Aportes')
      row.style = PdfGridRowStyle(
          backgroundBrush: PdfBrushes.lightGray,
          font: PdfStandardFont(PdfFontFamily.timesRoman, 9,
              style: PdfFontStyle.bold));
  }
}

PdfLayoutResult? printGrid(
    PdfPage page, PdfLayoutResult resultLayout, PdfGrid grid) {
  grid.style.cellPadding = PdfPaddings(left: 2, top: 2, right: 2);
// Draw table in the PDF page.
  PdfLayoutResult? result = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, resultLayout.bounds.bottom + 10,
          page.getClientSize().width, page.getClientSize().height));
  return result;
}

PdfLayoutResult generarHeader(
    ResumenEntity resumen, PdfPage page, String anio) {
  PdfTextElement textElement = PdfTextElement(
      text: 'CONSTANCIA ANUAL MENSUALIZADO DE HABERES',
      font: PdfStandardFont(PdfFontFamily.timesRoman, 10));

  //Draw the paragraph text on page and maintain the position in PdfLayoutResult
  PdfLayoutResult layoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(
          170, 10, page.getClientSize().width, page.getClientSize().height))!;

  textElement.text = 'Dni : ' + resumen.dni;

  layoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 5,
          page.getClientSize().width, page.getClientSize().height))!;

  textElement.text = 'Año ' + anio;

  layoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(
          page.getClientSize().width - 50,
          layoutResult.bounds.top,
          page.getClientSize().width,
          page.getClientSize().height))!;

  //Assign header text to PdfTextElement
  textElement.text = 'Nombres : ' + resumen.nombres;

  layoutResult = textElement.draw(
      page: page,
      bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 5,
          page.getClientSize().width, page.getClientSize().height))!;

  return layoutResult;
}

generarNumberPage(PdfDocument document) {
  //Create the page number field
  PdfPageNumberField pageNumber = PdfPageNumberField(
      font: PdfStandardFont(PdfFontFamily.helvetica, 8),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//Sets the number style for page number
  pageNumber.numberStyle = PdfNumberStyle.numeric;

//Create the page count field
  PdfPageCountField count = PdfPageCountField(
      font: PdfStandardFont(PdfFontFamily.helvetica, 8),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)));

  //set the number style for page count
  count.numberStyle = PdfNumberStyle.numeric;

  //Create the composite field with page number page count
  PdfCompositeField compositeField = PdfCompositeField(
      font: PdfStandardFont(PdfFontFamily.helvetica, 8),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      text: 'Pág {0} de {1}',
      fields: <PdfAutomaticField>[pageNumber, count]);

  PdfPageTemplateElement paginasHeader = PdfPageTemplateElement(
      Rect.fromLTWH(0, 0, document.pages[0].getClientSize().width, 100));

  compositeField.draw(
      paginasHeader.graphics,
      Offset(document.pages[0].getClientSize().width - 50,
          50 - PdfStandardFont(PdfFontFamily.timesRoman, 11).height));
  document.template.top = paginasHeader;
}

exportarPdf(PdfDocument document, ResumenEntity _resumen) {
  final List<int> bytes = document.save();
  document.dispose();
  // Espacios en blancos son remplazados por subguion para poder lanzar el archivo
  String nameFile =
      "${_resumen.dni}-${_resumen.nombres}.pdf".replaceAll(' ', '_');
  FileSaveHelper.saveAndLaunchFile(bytes, nameFile);

// Dispose the document.
}

footerPage(
    PdfDocument document, PdfPage _page, PdfLayoutResult? _layoutResult) {
  PdfTextElement(
          text:
              'Los funcionarios firmantes, declaran bajo responsabilidad que la presente liquidacion es veraz y respaldada por los archivos que obran en esta \n dependencia',
          font: PdfStandardFont(PdfFontFamily.timesRoman, 10))
      .draw(
          page: _page,
          bounds: Rect.fromLTWH(0, _layoutResult!.bounds.bottom + 10,
              _page.getClientSize().width, _page.getClientSize().height));
}

datePrint(PdfDocument _document) {
  PdfPageTemplateElement footer = PdfPageTemplateElement(
      Rect.fromLTWH(0, 0, _document.pages[0].getClientSize().width, 50));
  //Create the date and time field
  PdfDateTimeField dateTimeField = PdfDateTimeField(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)));
  //Sets the date and time
  dateTimeField.date = DateTime.now();

//Sets the date and time format
  dateTimeField.dateFormatString = 'dd-MM-yyyy hh\':\'mm\':\'ss';

//Create the composite field with page number page count
  PdfCompositeField compositeField = PdfCompositeField(
      font: PdfStandardFont(PdfFontFamily.timesRoman, 9),
      brush: PdfSolidBrush(PdfColor(0, 0, 0)),
      text: '{0}',
      fields: <PdfAutomaticField>[dateTimeField]);
  compositeField.bounds = footer.bounds;

//Add the composite field in footer
  compositeField.draw(footer.graphics,
      Offset(480, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 9).height));

//Add the footer at the bottom of the document
  _document.template.bottom = footer;
}

waterText(PdfGraphics _graphics) {
//Watermark text
  PdfGraphicsState state = _graphics.save();

  _graphics.setTransparency(0.25);

  _graphics.rotateTransform(-40);

  _graphics.drawString(
      'SIN VALOR OFICIAL', PdfStandardFont(PdfFontFamily.helvetica, 40),
      pen: PdfPens.red,
      brush: PdfBrushes.red,
      bounds: const Rect.fromLTWH(-150, 250, 0, 0));

  _graphics.restore(state);
}
