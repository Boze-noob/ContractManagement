import 'package:contract_management/_all.dart';

class ContextServiceProviderBlocs extends StatelessWidget {
  final Widget child;

  const ContextServiceProviderBlocs({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // ! Keep Blocs sorted by dependencies (only dependencies to other Blocs)
      providers: [
        // *
        // * Without dependencies
        // *

        BlocProvider<AuthBloc>(
          lazy: false,
          create: (BuildContext context) => AuthBloc(
            userAuthRepo: context.serviceProvider.userAuth,
          )..add(AuthCheckAuthenticationEvent()),
        ),
        BlocProvider(
          create: (BuildContext context) => CreateUserBloc(
            accountRepo: context.serviceProvider.accountRepo,
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => CurrentUserBloc(
            accountRepo: context.serviceProvider.accountRepo,
            authBloc: context.authBloc,
          ),
        ),
      ],
      child: child,
    );
  }
}
