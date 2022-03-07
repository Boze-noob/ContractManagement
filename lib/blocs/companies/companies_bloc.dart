import 'package:contract_management/_all.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  CompaniesBloc()
      : super(CompaniesState(
          status: CompaniesStateStatus.init,
        ));

  @override
  Stream<CompaniesState> mapEventToState(CompaniesEvent event) async* {}
}
