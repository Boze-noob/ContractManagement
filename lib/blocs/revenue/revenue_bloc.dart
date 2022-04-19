import 'package:contract_management/_all.dart';
import 'package:contract_management/data/repositories/revenue.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  IRevenue revenueRepo;
  RevenueBloc({
    required this.revenueRepo,
  }) : super(initialState()) {
    on<RevenueInitEvent>(_init);
    on<RevenueLoadEvent>(_load);
    on<RevenueUpdateEvent>(_update);
  }

  static RevenueState initialState() => RevenueState(
        status: RevenueStateStatus.init,
        revenueModel: RevenueModel(
          dailyRevenue: 0,
          totalWeeklyRevenue: 0,
          weeklyRevenue: List.filled(7, 0),
          monthlyRevenue: 0,
          yearlyRevenue: 0,
          monthNumber: 1,
          weekNumber: 1,
          revenueYear: DateTime.now().year,
          revenueListDateTime: [],
          dayNumber: 1,
        ),
      );

  void _init(RevenueInitEvent event, Emitter<RevenueState> emit) {
    initialState();
  }

  void _load(RevenueLoadEvent event, Emitter<RevenueState> emit) async {
    emit(state.copyWith(
      status: RevenueStateStatus.loading,
    ));
    final result = await revenueRepo.getData();
    if (result != null)
      emit(
        state.copyWith(status: RevenueStateStatus.loaded, revenueModel: result),
      );
    else
      emit(state.copyWith(status: RevenueStateStatus.error, errorMessage: 'Error message'));
  }

  void _update(RevenueUpdateEvent event, Emitter<RevenueState> emit) async {
    final result = await revenueRepo.updateData(event.revenueModel);
    if (result)
      emit(state.copyWith(status: RevenueStateStatus.edited, revenueModel: event.revenueModel));
    else
      emit(state.copyWith(status: RevenueStateStatus.error, errorMessage: 'Error happen'));
  }
}
