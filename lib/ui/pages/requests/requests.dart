import 'package:contract_management/_all.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        if (state.userModel!.role == RoleType.company.translate())
          return CompanyRequestWidget();
        else
          return AdminRequestWidget();
      },
    );
  }
}
