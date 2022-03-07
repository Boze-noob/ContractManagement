import 'package:contract_management/_all.dart';

class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  ContractsBloc()
      : super(
          ContractsState(
            status: ContractsStateStatus.init,
          ),
        );

  @override
  Stream<ContractsState> mapEventToState(ContractsEvent event) async* {}
}
