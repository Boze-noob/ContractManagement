import 'package:contract_management/_all.dart';

enum CompaniesStateStatus {
  init,
  loading,
  loaded,
  deletedSuccessfully,
  error,
}

class CompaniesState {
  final CompaniesStateStatus status;
  final List<UserModel> companies;
  final String? errorMessage;

  CompaniesState({
    required this.status,
    required this.companies,
    this.errorMessage,
  });

  CompaniesState copyWith({
    CompaniesStateStatus? status,
    List<UserModel>? companies,
    String? errorMessage,
  }) =>
      CompaniesState(
        status: status ?? this.status,
        companies: companies ?? this.companies,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
