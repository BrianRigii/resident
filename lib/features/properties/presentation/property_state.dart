import 'package:resident/features/properties/models/property.dart';

abstract class PropertyState {}

class PropertyStateIdle extends PropertyState {}

class PropertyStateLoading extends PropertyState {}

class PropertyStateError extends PropertyState {
  final String message;
  PropertyStateError(this.message);
}

class PropertyAddedSuccess extends PropertyState {
  final Property property;
  PropertyAddedSuccess(this.property);
}
