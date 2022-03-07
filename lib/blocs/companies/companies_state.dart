enum CompaniesStateStatus {
  init,
}

class CompaniesState {
  final CompaniesStateStatus? status;

  CompaniesState({this.status});

  CompaniesState copyWith({
    CompaniesStateStatus? status,
  }) =>
      CompaniesState(
        status: status ?? this.status,
      );
}
