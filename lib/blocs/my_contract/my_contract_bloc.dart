import 'dart:convert';
import 'dart:ui';
import 'package:contract_management/_all.dart';

class MyContractBloc extends Bloc<MyContractEvent, MyContractState> {
  final IContracts contractsRepo;
  MyContractBloc({
    required this.contractsRepo,
  }) : super(initialState()) {
    on<MyContractInitEvent>(_init);
    on<MyContractGetCurrentEvent>(_loadCurrent);
    on<MyContractGetRequestEvent>(_loadRequest);
    on<MyContractAcceptRequestEvent>(_acceptRequest);
  }

  static MyContractState initialState() => MyContractState(
        status: MyContractStateStatus.init,
      );

  void _init(MyContractInitEvent event, Emitter<MyContractState> emit) {
    emit(
      MyContractState(
        status: MyContractStateStatus.init,
      ),
    );
  }

  void _loadCurrent(MyContractGetCurrentEvent event, Emitter<MyContractState> emit) async {
    emit(state.copyWith(status: MyContractStateStatus.loading));
    //FOR UX
    await Future.delayed(Duration(seconds: 2));
    if (event.contractId != null) {
      final result = await contractsRepo.getCurrentActive(event.contractId!);
      if (result != null)
        emit(state.copyWith(status: MyContractStateStatus.loaded, model: Optional(result)));
      else
        emit(state.copyWith(status: MyContractStateStatus.error, errorMessage: 'Error happen'));
    } else
      emit(
        state.copyWith(status: MyContractStateStatus.loaded),
      );
  }

  void _loadRequest(MyContractGetRequestEvent event, Emitter<MyContractState> emit) async {
    print('loading request');
    emit(
      state.copyWith(status: MyContractStateStatus.loading),
    );
    //FOR UX
    await Future.delayed(Duration(seconds: 2));
    final result = await contractsRepo.getContractRequest(event.companyId);
    if (result != null) {
      final contractModel = await contractsRepo.loadSingleContractTemplate(result.contractId);
      if (contractModel != null) {
        print('loadSingleContractTemplate != null');
        emit(
          state.copyWith(
            status: MyContractStateStatus.loaded,
            model: Optional(contractModel),
          ),
        );
      } else
        emit(
          state.copyWith(
            status: MyContractStateStatus.error,
            errorMessage: 'Error happen',
            model: Optional(null),
          ),
        );
    } else
      emit(
        state.copyWith(
          status: MyContractStateStatus.error,
          errorMessage: 'Error happen',
          model: Optional(null),
        ),
      );
  }

  void _acceptRequest(MyContractAcceptRequestEvent event, Emitter<MyContractState> emit) async {
    emit(state.copyWith(status: MyContractStateStatus.loading));
    final signatureBase64 = await imageBase64Encoded(event.signatureImg);
    final result = await contractsRepo.acceptContract(event.companyId, event.contractId, signatureBase64);
    if (result == null) {
      emit(
        state.copyWith(
          status: MyContractStateStatus.contractAccepted,
          model: Optional(null),
        ),
      );
    }
  }

  Future imageBase64Encoded(var image) async {
    if (image != null) {
      try {
        final bytes = await image?.toByteData(format: ImageByteFormat.png);
        final uInt8List = bytes!.buffer.asUint8List();
        return base64.encode(uInt8List);
      } catch (e) {
        print(e);
      }
    }
    return '';
  }
}
