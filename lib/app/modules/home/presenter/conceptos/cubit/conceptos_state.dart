part of 'conceptos_cubit.dart';

abstract class ConceptosState extends Equatable {
  const ConceptosState();

  @override
  List<Object> get props => [];
}

class ConceptosInitial extends ConceptosState {}

class LoadingConceptosState extends ConceptosState {}

class SavedConceptosState extends ConceptosState {}

class ErrorConceptosState extends ConceptosState {}

class LoadedConceptosState extends ConceptosState {
  final List<ConceptoEntity> conceptos;
  const LoadedConceptosState({
    required this.conceptos,
  });
}
