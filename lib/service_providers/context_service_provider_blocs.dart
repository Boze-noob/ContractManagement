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
        BlocProvider<CreateUserBloc>(
          create: (BuildContext context) => CreateUserBloc(
            accountRepo: context.serviceProvider.accountRepo,
          ),
        ),
        BlocProvider<CurrentUserBloc>(
          lazy: false,
          create: (BuildContext context) => CurrentUserBloc(
            accountRepo: context.serviceProvider.accountRepo,
            authBloc: context.authBloc,
          ),
        ),
        BlocProvider<NotificationsBloc>(
          lazy: false,
          create: (BuildContext context) => NotificationsBloc(
            notificationsRepo: context.serviceProvider.notificationsRepo,
            currentUserBloc: context.currentUserBloc,
          ),
        ),
        BlocProvider<ContractsBloc>(
          lazy: false,
          create: (BuildContext context) => ContractsBloc(contractsRepo: context.serviceProvider.contractsRepo)
            ..add(
              ContractsCheckDateEvent(),
            ),
        ),
      ],
      child: child,
    );
  }
}
