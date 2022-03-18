abstract class GetContractRequestEvent {}

class GetContractRequestInitEvent extends GetContractRequestEvent {}

class GetContractForCurrentCompanyRequest extends GetContractRequestEvent {
  final String companyId;

  GetContractForCurrentCompanyRequest({required this.companyId});
}
