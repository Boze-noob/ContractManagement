import 'package:contract_management/_all.dart';

class CompaniesBloc extends Bloc<CompaniesEvent, CompaniesState> {
  ICompanies companiesRepo;
  CompaniesBloc({
    required this.companiesRepo,
  }) : super(initialState()) {
    on<CompaniesInitEvent>(_init);
    on<CompaniesGetEvent>(_get);
    on<CompaniesDeleteEvent>(_delete);
    on<CompaniesGetCompaniesWithoutContract>(_getWithoutContract);
  }

  static CompaniesState initialState() => CompaniesState(
        status: CompaniesStateStatus.init,
        companies: List.empty(),
      );

  void _init(CompaniesInitEvent event, Emitter<CompaniesState> emit) async {
    initialState();
  }

  void _get(CompaniesGetEvent event, Emitter<CompaniesState> emit) async {
    emit(state.copyWith(status: CompaniesStateStatus.loading));
    emit(state.copyWith(status: CompaniesStateStatus.loaded, companies: await companiesRepo.getCompanies()));
  }

  void _delete(CompaniesDeleteEvent event, Emitter<CompaniesState> emit) async {
    emit(state.copyWith(status: CompaniesStateStatus.loading));
    final result = await companiesRepo.deleteCompany(event.companyId);
    if (result == null) {
      List<UserModel> companies = state.companies;
      companies.removeWhere((company) => company.id == event.companyId);
      emit(
        state.copyWith(status: CompaniesStateStatus.deletedSuccessfully, companies: companies),
      );
    } else
      emit(
        state.copyWith(status: CompaniesStateStatus.error, errorMessage: result),
      );
  }

  void _getWithoutContract(CompaniesGetCompaniesWithoutContract event, Emitter<CompaniesState> emit) async {
    emit(state.copyWith(status: CompaniesStateStatus.loading));
    final result = await companiesRepo.getCompaniesWithoutContract();

    if (result != null) {
      emit(state.copyWith(status: CompaniesStateStatus.loaded, companies: result));
    } else
      emit(state.copyWith(status: CompaniesStateStatus.error));
  }
}
