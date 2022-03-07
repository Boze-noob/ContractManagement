import 'package:contract_management/_all.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  RequestsBloc()
      : super(
          RequestsState(
            status: RequestsStateStatus.init,
          ),
        );

  @override
  Stream<RequestsState> mapEventToState(RequestsEvent event) async* {}
}
