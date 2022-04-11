import 'package:contract_management/_all.dart';

class WorkDiariesBloc extends Bloc<WorkDiariesEvent, WorkDiariesState> {
  final IWorkDiaries workDiariesRepo;
  WorkDiariesBloc({required this.workDiariesRepo}) : super(initialState()) {
    on<WorkDiariesInitEvent>(_init);
    on<WorkDiariesCreateEvent>(_create);
    on<WorkDiariesGetEvent>(_get);
    on<WorkDiariesUpdateEvent>(_update);
    on<WorkDiariesSubmitUpdateEvent>(_submitUpdate);
  }

  static WorkDiariesState initialState() => WorkDiariesState(
        status: WorkDiariesStateStatus.init,
        workDiaryModels: List.empty(),
      );

  Future<void> _init(
      WorkDiariesInitEvent event, Emitter<WorkDiariesState> emit) async {
    emit(
      state.copyWith(
        workingDayModel: event.workingDayModel,
        status: WorkDiariesStateStatus.initializing,
      ),
    );
    await Future.delayed(Duration(milliseconds: 200));
    emit(
      state.copyWith(
        status: WorkDiariesStateStatus.init,
      ),
    );
  }

  Future<void> _get(
      WorkDiariesGetEvent event, Emitter<WorkDiariesState> emit) async {
    emit(state.copyWith(status: WorkDiariesStateStatus.loading));
    final result = await workDiariesRepo.getDiaries(event.companyId);
    if (result != null)
      emit(state.copyWith(
          status: WorkDiariesStateStatus.loaded, workDiaryModels: result));
    else
      emit(state.copyWith(
          status: WorkDiariesStateStatus.error, message: 'Error happen'));
  }

  Future<void> _update(
      WorkDiariesUpdateEvent event, Emitter<WorkDiariesState> emit) async {
    emit(
      state.copyWith(
        workDiaryModel: event.workDiaryModel,
        workingDayModel: event.workingDayModel,
      ),
    );
    //Added cuz textFormFiled(loading widget)
    await Future.delayed(Duration(milliseconds: 200));
    emit(
      state.copyWith(
        status: WorkDiariesStateStatus.init,
      ),
    );
  }

  Future<void> _submitUpdate(WorkDiariesSubmitUpdateEvent event,
      Emitter<WorkDiariesState> emit) async {
    //If its first working day
    if (event.workingDayModels != null && state.workDiaryModel != null) {
      final WorkDiaryModel workDiaryModel = state.workDiaryModel!
          .copyWith(workingDayModels: event.workingDayModels!);
      final result = await workDiariesRepo.editDiary(workDiaryModel);
      if (result)
        emit(state.copyWith(
            status: WorkDiariesStateStatus.updateSuccessful,
            message: 'Update successful'));
      else
        emit(state.copyWith(
            status: WorkDiariesStateStatus.error, message: 'Error happen'));
    } else {
      if (state.workDiaryModel != null) {
        final int index = state.workDiaryModel!.workingDayModels.indexWhere(
            (workingDay) =>
                workingDay.dateTime == state.workingDayModel!.dateTime);

        final List<WorkingDayModel> workingDaysList =
            state.workDiaryModel!.workingDayModels;

        workingDaysList[index] = state.workingDayModel!;

        final WorkDiaryModel workDiaryModel = state.workDiaryModel!;
        workDiaryModel.copyWith(workingDayModels: workingDaysList);

        final result = await workDiariesRepo.editDiary(workDiaryModel);
        if (result)
          emit(state.copyWith(
              status: WorkDiariesStateStatus.updateSuccessful,
              message: 'Update successful'));
        else
          emit(state.copyWith(
              status: WorkDiariesStateStatus.error, message: 'Error happen'));
      } else
        emit(state.copyWith(
            status: WorkDiariesStateStatus.error,
            message: 'Error happen, please try again'));
    }
  }

  Future<void> _create(
      WorkDiariesCreateEvent event, Emitter<WorkDiariesState> emit) async {
    final result = await workDiariesRepo.createDiary(event.workDiaryModel);
    if (result)
      emit(state.copyWith(
        status: WorkDiariesStateStatus.created,
      ));
    else
      emit(state.copyWith(
          status: WorkDiariesStateStatus.error, message: 'Error happen'));
  }
}
