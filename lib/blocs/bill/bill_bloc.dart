import 'package:contract_management/_all.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  final IBill billRepo;
  BillBloc({required this.billRepo}) : super(initialState()) {
    on<BillInitEvent>(_init);
    on<BillGetSingleEvent>(_get);
    on<BillGetAllEvent>(_getAll);
    on<BillUpdateEvent>(_update);
    on<BillSubmitEvent>(_submit);
  }

  static BillState initialState() => BillState(
        status: BillStateStatus.init,
        billModel: BillModel(price: '0', announcementId: '', id: ''),
        billsModels: [],
      );

  Future<void> _init(BillInitEvent event, Emitter<BillState> emit) async {
    emit(
      state.copyWith(
        billModel: BillModel(
          price: event.price,
          id: '',
          announcementId: event.announcementId,
        ),
      ),
    );
  }

  Future<void> _get(BillGetSingleEvent event, Emitter<BillState> emit) async {
    emit(state.copyWith(status: BillStateStatus.loading));
    final result = await billRepo.getBill(event.announcementId);
    if (result != null) {
      emit(state.copyWith(status: BillStateStatus.loaded, billModel: result.first));
    } else
      emit(state.copyWith(status: BillStateStatus.error, message: 'Could not load bill'));
  }

  Future<void> _getAll(BillGetAllEvent event, Emitter<BillState> emit) async {
    emit(state.copyWith(status: BillStateStatus.loading));
    final result = await billRepo.getBills();
    if (result != null)
      emit(state.copyWith(status: BillStateStatus.loaded, billsModels: result));
    else
      emit(state.copyWith(status: BillStateStatus.error, message: 'Could not load bills'));
  }

  Future<void> _update(BillUpdateEvent event, Emitter<BillState> emit) async {
    emit(
      state.copyWith(
        billModel: event.billModel,
      ),
    );
  }

  Future<void> _submit(BillSubmitEvent event, Emitter<BillState> emit) async {
    final result = await billRepo.submitBill(state.billModel);
    if (result)
      emit(state.copyWith(status: BillStateStatus.submitSuccessful, message: 'Submit successful'));
    else
      emit(state.copyWith(status: BillStateStatus.error, message: 'Error happen, please try again'));
  }
}
