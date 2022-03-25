import 'package:contract_management/_all.dart';

enum CompanyEditStateStatus {
  init,
  submitting,
  submittedSuccessfully,
  error,
  loading,
  loaded,
}

class CompanyEditState {
  final CompanyEditStateStatus status;
  final UserModel companyModel;
  final String? errorMessage;

  CompanyEditState({required this.status, required this.companyModel, this.errorMessage});

  CompanyEditState copyWith({
    CompanyEditStateStatus? status,
    UserModel? companyModel,
    String? errorMessage,
  }) =>
      CompanyEditState(
        status: status ?? this.status,
        companyModel: companyModel ?? this.companyModel,
      );
}
