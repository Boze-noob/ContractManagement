import 'package:contract_management/_all.dart';

class CompanyEditBloc extends Bloc<CompanyEditEvent, CompanyEditState> {
  ICompanies companiesRepo;
  CompanyEditBloc({
    required this.companiesRepo,
  }) : super(initialState()) {
    on<CompanyEditInitEvent>(_init);
    on<CompanyEditUpdateEvent>(_update);
    on<CompanyEditSubmitEvent>(_submit);
  }

  static CompanyEditState initialState() => CompanyEditState(
        status: CompanyEditStateStatus.init,
        companyModel: UserModel(
          id: '',
          role: '',
          email: '',
          displayName: '',
        ),
      );

  void _init(CompanyEditInitEvent event, Emitter<CompanyEditState> emit) async {
    emit(
      state.copyWith(
        status: CompanyEditStateStatus.loading,
      ),
    );
    await Future.delayed(Duration(seconds: 1));
    emit(state.copyWith(status: CompanyEditStateStatus.loaded, companyModel: event.companyModel));
  }

  void _update(CompanyEditUpdateEvent event, Emitter<CompanyEditState> emit) {
    emit(state.copyWith(companyModel: event.companyModel));
  }

  void _submit(CompanyEditSubmitEvent event, Emitter<CompanyEditState> emit) async {
    emit(state.copyWith(status: CompanyEditStateStatus.submitting));
    final result = await companiesRepo.editCompany(state.companyModel);
    if (result)
      emit(state.copyWith(
        status: CompanyEditStateStatus.submittedSuccessfully,
      ));
    else
      emit(state.copyWith(status: CompanyEditStateStatus.error, errorMessage: 'Error happen'));
  }
}
