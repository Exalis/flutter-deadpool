part of 'form_validation_bloc.dart';
enum Status { signIn, signUp }

abstract class FormValidationEvent extends Equatable {
  const FormValidationEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends FormValidationEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends FormValidationEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class UserNameChanged extends FormValidationEvent {
  final String userName;
  const UserNameChanged(this.userName);

  @override
  List<Object> get props => [userName];
}

class FormSubmitted extends FormValidationEvent {
  final Status value;
  const FormSubmitted({required this.value});

  @override
  List<Object> get props => [value];
}
