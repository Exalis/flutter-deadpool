part of 'form_validation_bloc.dart';

abstract class FormValidationState extends Equatable {
  const FormValidationState();
}

class FormInitial extends FormValidationState {
  @override
  List<Object?> get props => [];
}

class FormValidate extends FormValidationState {
  const FormValidate({required this.email, required this.password, required this.userName});

  final String email;
  final String password;
  final String userName;

  FormValidate copyWith({String? email, String? password, String? userName}) {
    return FormValidate(
      email: email ?? this.email,
      password: password ?? this.password,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        userName
      ];
}


class FormSucceeded extends FormValidate {
  const FormSucceeded({required super.email, required super.password, required super.userName});

  @override
  List<Object> get props => [];
}

class FormFailed extends FormValidate {
  const FormFailed({required super.email, required super.password, required this.errorMessage, required super.userName});
  
  final String errorMessage;
  
  @override
  List<Object> get props => [errorMessage];
}