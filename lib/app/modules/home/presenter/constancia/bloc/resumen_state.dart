part of 'resumen_cubit.dart';

abstract class ResumenState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialResumenState extends ResumenState {}

class EmptyResumenState extends ResumenState {}

class ErrorResumenState extends ResumenState {
  final String message;
  ErrorResumenState({
    required this.message,
  });
}

class LoadedResumenState extends ResumenState {
  final ResumenEntity resumenEntity;
  LoadedResumenState({
    required this.resumenEntity,
  });

  @override
  List<Object?> get props => [resumenEntity];
}

class LoadingResumenState extends ResumenState {}
