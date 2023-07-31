import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import '../../authentication/authentication_repository_impl.dart';

part 'form_validation_event.dart';
part 'form_validation_state.dart';

class FormValidationBloc extends Bloc<FormValidationEvent, FormValidate> {
  final AuthenticationRepository _authenticationRepository;

  FormValidationBloc(this._authenticationRepository)
      : super(const FormValidate(
          email: "",
          password: "",
          userName: ""
        )) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<UserNameChanged>(_onUsernameChanged);
  }
  _onEmailChanged(EmailChanged event, Emitter<FormValidate> emit) {
    emit(state.copyWith(
      email: event.email,
    ));
  }

  _onPasswordChanged(PasswordChanged event, Emitter<FormValidate> emit) {
    emit(state.copyWith(
      password: event.password,
    ));
  }

   _onUsernameChanged(UserNameChanged event, Emitter<FormValidate> emit) {
    emit(state.copyWith(
      userName: event.userName,
    ));
  }

  _onFormSubmitted(FormSubmitted event, Emitter<FormValidate> emit) async {
    UserModel user = UserModel(
      email: state.email,
      password: state.password,
      displayName: state.userName
    );

    final UserCredential? credentials;
    if (event.value == Status.signUp) {
      credentials = await _authenticationRepository.signUp(user);
    } else {
      credentials = await _authenticationRepository.signIn(user);
    }

    if(credentials == null){
      emit(FormFailed(email: user.email!, password: user.password!, userName: user.displayName!, errorMessage: 'Erreur, merci de réessayer'));
    }else{
      emit(FormSucceeded(email: user.email!, password: user.password!, userName: user.displayName!));
    }
  }
}
