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
    on<OrderSubmitUpdateEvent>(_submitUpdate);
    on<OrderGetCompaniesForOrderEvent>(_getCompanies);
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
          id: '',
          price: '',
        ),
        orderModels: List.empty(),
        companiesForOrder: {},
      );

  Future<void> _init(OrderInitEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStateStatus.loading));
    await Future.delayed(Duration(seconds: 1));
    emit(state.copyWith(orderModel: event.orderModel, status: OrderStateStatus.init));
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

  Future<void> _submitUpdate(OrderSubmitUpdateEvent event, Emitter<OrderState> emit) async {
    final result = await orderRepo.editOrder(state.orderModel);
    if (result) {
      emit(state.copyWith(
        status: OrderStateStatus.submitSuccessful,
        message: 'Edit successful',
      ));
    } else
      emit(state.copyWith(status: OrderStateStatus.error, message: 'Error message'));
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
    final result = await orderRepo.sendOrder(event.orderId, event.receiverId, event.receiverName);
    if (result == null) {
      emit(state.copyWith(
        status: OrderStateStatus.submitSuccessful,
        message: 'Submitted successfully',
      ));
      //emit(initialState());
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

  Future<void> _getCompanies(OrderGetCompaniesForOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStateStatus.loading));
    final result = await orderRepo.getCompanies(event.contractItems.map((item) => item.index).toList());
    if (result != null)
      emit(state.copyWith(status: OrderStateStatus.loaded, companiesForOrder: result));
    else
      emit(state.copyWith(status: OrderStateStatus.error, message: 'Error happen'));
  }
}
