import 'package:contract_management/_all.dart';

enum CompanyRequestsStateStatus {
  init,
  loading,
  loaded,
  error,
  empty,
  //I need two editsSuccessful because bloc listener
  orderEditSuccessful,
  announcementEditSuccessful,
}

class CompanyRequestsState {
  final CompanyRequestsStateStatus status;
  final List<OrderModel> orderModels;
  final List<AnnouncementModel> announcementsModels;
  final String? message;

  CompanyRequestsState(
      {required this.status, required this.orderModels, required this.announcementsModels, this.message});

  CompanyRequestsState copyWith({
    final CompanyRequestsStateStatus? status,
    final List<OrderModel>? orderModels,
    final List<AnnouncementModel>? announcementsModels,
    final String? message,
  }) =>
      CompanyRequestsState(
        status: status ?? this.status,
        orderModels: orderModels ?? this.orderModels,
        announcementsModels: announcementsModels ?? this.announcementsModels,
        message: message ?? this.message,
      );
}
