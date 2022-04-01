import 'package:contract_management/_all.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrder orderRepo;
  OrderBloc({
    required this.orderRepo,
  }) : super(initialState()) {
    on<OrderInitEvent>(_init);
    on<OrderGetEvent>(_get);
    on<OrderUpdateEvent>(_update);
    on<OrderCreateEvent>(_create);
    on<OrderSendEvent>(_send);
    on<OrderDeleteEvent>(_delete);
  }

  static OrderState initialState() => OrderState(
        status: OrderStateStatus.init,
        orderModel: OrderModel(
          contractItems: [],
          senderName: '',
          employerName: '',
          createdDateTime: DateTime.now(),
          paymentType: PaymentType.cash,
          orderStatusType: OrderStatusType.waiting,
          orderLocation: '',
          adminRequestType: AdminRequestType.order,
          clientName: '',
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

  Future<void> _create(OrderCreateEvent event, Emitter<OrderState> emit) async {
    emit(
      state.copyWith(
        status: OrderStateStatus.loading,
        orderModel: state.orderModel.copyWith(
          id: generateRandomId(),
          clientName: event.clientName,
        ),
      ),
    );
    final result = await orderRepo.createOrder(state.orderModel);
    if (result)
      emit(state.copyWith(status: OrderStateStatus.submitSuccessful, message: 'Order created'));
    else
      emit(state.copyWith(status: OrderStateStatus.error, message: 'Error happen'));
  }

  Future<void> _send(OrderSendEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      status: OrderStateStatus.loading,
    ));
    final result = await orderRepo.sendOrder(event.orderId, event.companyId);
    if (result == null) {
      emit(state.copyWith(
        status: OrderStateStatus.submitSuccessful,
        message: 'Submitted successfully',
      ));
      emit(initialState());
    } else
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

  //This should be done on backend
  String generateRandomId() {
    var uuid = Uuid();
    return uuid.v4();
  }
}
