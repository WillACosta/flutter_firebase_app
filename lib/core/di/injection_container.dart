import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/features/contacts/contacts.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/authentication.dart';
import '../../presentation/presentation.dart';

GetIt serviceLocator = GetIt.instance;

void setUpInjectionContainer() {
  // firebase services
  serviceLocator.registerSingleton(FirebaseAuth.instance);
  serviceLocator.registerSingleton(FirebaseFirestore.instance);

  // data layer
  serviceLocator.registerFactory(
    () => AuthenticationRepository(serviceLocator.get()),
  );

  serviceLocator.registerFactory(
    () => RegisterRepository(serviceLocator.get()),
  );

  serviceLocator.registerFactory(
    () => ContactsRepository(serviceLocator.get()),
  );

  // use cases
  serviceLocator.registerFactory(() => SignInUseCase(serviceLocator.get()));

  serviceLocator.registerFactory(
    () => GetAllContactsUseCase(
      serviceLocator.get(),
    ),
  );

  serviceLocator.registerFactory(
    () => RegisterUserUseCase(
      serviceLocator.get(),
      serviceLocator.get(),
    ),
  );

  // view models
  serviceLocator.registerFactory(() => SigInViewModel(serviceLocator.get()));
  serviceLocator.registerFactory(() => RegisterViewModel(serviceLocator.get()));

  serviceLocator.registerFactory(
    () => HomeViewModel(
      serviceLocator.get(),
      serviceLocator.get(),
    ),
  );

  serviceLocator.registerSingleton(SplashViewModel(serviceLocator.get()));
}
