import 'package:contract_management/_all.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrder orderRepo;
  OrderBloc({
    required this.orderRepo,
  }) : super(initialState()) {
    on<OrderInitEvent>(_init);
    on<OrderGetEvent>(_get);
    on<OrderUpdateEvent>(_update);
    on<OrderSendEvent>(_send);
    on<OrderDeleteEvent>(_delete);
  }

  static OrderState initialState() => OrderState(
        status: OrderStateStatus.init,
        orderModel: OrderModel(
          contractItems: [],
          senderName: '',
          receiverName: '',
          employerName: '',
          createdDateTime: DateTime.now(),
          sentDateTime: DateTime.now(),
          paymentType: PaymentType.cash,
          orderStatusType: OrderStatusType.waiting,
          orderLocation: '',
          adminRequestType: AdminRequestType.order,
        ),
        orderModels: List.empty(),
      );

  Future<void> _init(OrderInitEvent event, Emitter<OrderState> emit) async {
    emit(initialState());
  }

  Future<void> _get(OrderGetEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStateStatus.loading));
    final result = await orderRepo.getOrders();
    if (result != null)
      emit(state.copyWith(status: OrderStateStatus.loaded, orderModels: result));
    else
      emit(state.copyWith(status: OrderStateStatus.error, message: 'Error happen', orderModels: List.empty()));
  }

  Future<void> _update(OrderUpdateEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(orderModel: event.orderModel));
  }

  Future<void> _send(OrderSendEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      status: OrderStateStatus.loading,
    ));
    final result = await orderRepo.sendOrder(event.orderId, event.companyId);
    if (result == null)
      emit(state.copyWith(status: OrderStateStatus.submitSuccessful, message: 'Submitted successfully'));
    else
      emit(state.copyWith(status: OrderStateStatus.error, message: result));
  }

  Future<void> _delete(OrderDeleteEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStateStatus.loading));
    final result = await orderRepo.deleteOrder(event.orderId);
    if (result == null)
      emit(state.copyWith(status: OrderStateStatus.deleteSuccessful));
    else
      emit(state.copyWith(status: OrderStateStatus.error, message: result));
  }
}
