import 'package:deadpool/features/bets/bets_repository_impl.dart';
import 'package:deadpool/features/bets/bloc/bets_bloc.dart';
import 'package:deadpool/features/form-validation/bloc/form_validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'features/authentication/authentication_repository_impl.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/friends_group/bloc/friends_group_bloc.dart';
import 'features/friends_group/friends_group_repository_impl.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(AuthenticationRepositoryImpl())
                ..add(AuthenticationStarted()),
        ),
        BlocProvider(
            create: (context) =>
                FormValidationBloc(AuthenticationRepositoryImpl())),
        BlocProvider(
            create: (context) => FriendsGroupBloc(FriendsGroupRepositoyImpl())
              ..add(FriendsGroupsFetched())),
        BlocProvider(create: (context) => BetsBloc(BetsRepositoyImpl())),
      ],
      child: const App(),
    ),
  );
}
