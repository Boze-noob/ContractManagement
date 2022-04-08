import 'package:contract_management/_all.dart';

class WorkDiariesBloc extends Bloc<WorkDiariesEvent, WorkDiariesState> {
  final IWorkDiaries workDiariesRepo;
  WorkDiariesBloc({required this.workDiariesRepo}) : super(initialState()) {
    on<WorkDiariesCreateEvent>(_create);
    on<WorkDiariesGetEvent>(_get);
    on<WorkDiariesUpdateEvent>(_update);
    on<WorkDiariesSubmitUpdateEvent>(_submitUpdate);
  }

  static WorkDiariesState initialState() => WorkDiariesState(
        status: WorkDiariesStateStatus.init,
        workDiaryModels: List.empty(),
      );

  Future<void> _get(WorkDiariesGetEvent event, Emitter<WorkDiariesState> emit) async {
    emit(state.copyWith(status: WorkDiariesStateStatus.loading));
    final result = await workDiariesRepo.getDiaries(event.companyId);
    if (result != null)
      emit(state.copyWith(status: WorkDiariesStateStatus.loaded, workDiaryModels: result));
    else
      emit(state.copyWith(status: WorkDiariesStateStatus.error, message: 'Error happen'));
  }

  Future<void> _update(WorkDiariesUpdateEvent event, Emitter<WorkDiariesState> emit) async {
    emit(
      state.copyWith(
        workDiaryModel: event.workDiaryModel,
        workingDayModel: event.workingDayModel,
      ),
    );
  }

  Future<void> _submitUpdate(WorkDiariesSubmitUpdateEvent event, Emitter<WorkDiariesState> emit) async {
    if (state.workDiaryModel != null) {
      final result = await workDiariesRepo.editDiary(state.workDiaryModel!);
      if (result)
        emit(state.copyWith(status: WorkDiariesStateStatus.updateSuccessful, message: 'Update successful'));
      else
        emit(state.copyWith(status: WorkDiariesStateStatus.error, message: 'Error happen'));
    } else
      emit(state.copyWith(status: WorkDiariesStateStatus.error, message: 'Error happen, please try again'));
  }

  Future<void> _create(WorkDiariesCreateEvent event, Emitter<WorkDiariesState> emit) async {
    final result = await workDiariesRepo.createDiary(event.workDiaryModel);
    if (result)
      emit(state.copyWith(
        status: WorkDiariesStateStatus.created,
      ));
    else
      emit(state.copyWith(status: WorkDiariesStateStatus.error, message: 'Error happen'));
  }
}
