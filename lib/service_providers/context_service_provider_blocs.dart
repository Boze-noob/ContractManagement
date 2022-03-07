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
            userAuth: context.serviceProvider.userAuth,
          ),
        ),
      ],
      child: child,
    );
  }
}
