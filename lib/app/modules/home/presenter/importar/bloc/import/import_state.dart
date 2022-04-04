part of 'import_bloc.dart';

abstract class ImportState extends Equatable {
  const ImportState();

  @override
  List<Object> get props => [];
}

class ImportInitial extends ImportState {}

class ErrorImportState extends ImportState {
  final String message;
  final String nombres;
  const ErrorImportState({
    required this.message,
    required this.nombres,
  });
  @override
  List<Object> get props => [message];
}

class LoadingImportState extends ImportState {}

class DeletedImportState extends ImportState {}

class ImportedPlanillaState extends ImportState {
  final int anio;
  final int mes;
  final int registros;
  final ResumenImportEntity resumenImportEntity;

  const ImportedPlanillaState({
    required this.anio,
    required this.mes,
    required this.registros,
    required this.resumenImportEntity,
  });
  @override
  List<Object> get props => [anio, mes, registros, resumenImportEntity];
}
