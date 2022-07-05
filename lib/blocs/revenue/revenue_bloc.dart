import 'package:contract_management/_all.dart';
import 'package:contract_management/data/repositories/revenue.dart';
import 'package:collection/collection.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  IRevenue revenueRepo;
  RevenueBloc({
    required this.revenueRepo,
  }) : super(initialState()) {
    on<RevenueInitEvent>(_init);
    on<RevenueLoadEvent>(_load);
    on<RevenueProfitEvent>(_update);
    on<RevenueUpdateModelEvent>(_updateModel);
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
          weeklyRevenueDateTime: List.filled(7, 0),
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
    var result = await revenueRepo.getData();
    if (result != null) {
      result = result.copyWith(totalWeeklyRevenue: result.weeklyRevenue.sum);
      emit(
        state.copyWith(status: RevenueStateStatus.loaded, revenueModel: result),
      );
    } else
      emit(state.copyWith(status: RevenueStateStatus.error, errorMessage: 'Error message'));
  }

  //this should be done on server side, it would be nice if we could just send profit
  void _update(RevenueProfitEvent event, Emitter<RevenueState> emit) async {
    int profit = event.profit;
    final RevenueModel currentRevenueModel = state.revenueModel;
    currentRevenueModel.weeklyRevenue[0] = currentRevenueModel.weeklyRevenue.first + profit;
    final RevenueModel newRevenueModel = RevenueModel(
      dailyRevenue: currentRevenueModel.dailyRevenue + profit,
      totalWeeklyRevenue: currentRevenueModel.totalWeeklyRevenue + profit,
      weeklyRevenue: currentRevenueModel.weeklyRevenue,
      monthlyRevenue: currentRevenueModel.monthlyRevenue + profit,
      yearlyRevenue: currentRevenueModel.yearlyRevenue + profit,
      revenueYear: currentRevenueModel.revenueYear,
      dayNumber: currentRevenueModel.dayNumber,
      weekNumber: currentRevenueModel.weekNumber,
      weeklyRevenueDateTime: currentRevenueModel.weeklyRevenueDateTime,
      monthNumber: currentRevenueModel.monthNumber,
    );
    final result = await revenueRepo.updateData(newRevenueModel);
    if (result)
      emit(state.copyWith(status: RevenueStateStatus.edited, revenueModel: newRevenueModel));
    else
      emit(state.copyWith(status: RevenueStateStatus.error, errorMessage: 'Error happen'));
  }

  void _updateModel(RevenueUpdateModelEvent event, Emitter<RevenueState> emit) async {
    emit(state.copyWith(status: RevenueStateStatus.loading));
    final result = await revenueRepo.updateData(event.revenueModel);
    if (result)
      emit(state.copyWith(status: RevenueStateStatus.edited, revenueModel: event.revenueModel));
    else
      emit(state.copyWith(status: RevenueStateStatus.error, errorMessage: 'Error happen'));
  }
}
