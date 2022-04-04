part of 'consolidado_cubit.dart';

abstract class ConsolidadoState extends Equatable {
  const ConsolidadoState();

  @override
  List<Object> get props => [];
}

class ConsolidadoInitial extends ConsolidadoState {}

class ConsolidadoLoading extends ConsolidadoState {}

class ConsolidadoLoaded extends ConsolidadoState {
  final List<ConsolidadoEntity> consolidadoEntityList;
  const ConsolidadoLoaded({
    required this.consolidadoEntityList,
  });
  @override
  List<Object> get props => [consolidadoEntityList];
}
