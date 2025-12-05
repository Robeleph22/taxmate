import 'package:flutter/foundation.dart';

/// Generic view status used across the app.
enum ViewStatus { idle, loading, success, empty, error }

/// Base state used by all controllers.
@immutable
class BaseState<T> {
  final ViewStatus status;
  final T? data;
  final String? message;
  final bool isRefreshing;

  const BaseState({
    required this.status,
    this.data,
    this.message,
    this.isRefreshing = false,
  });

  const BaseState.idle()
      : status = ViewStatus.idle,
        data = null,
        message = null,
        isRefreshing = false;

  BaseState<T> copyWith({
    ViewStatus? status,
    T? data,
    String? message,
    bool? isRefreshing,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  factory BaseState.loading({T? data, bool isRefreshing = false}) => BaseState<T>(
        status: ViewStatus.loading,
        data: data,
        isRefreshing: isRefreshing,
      );

  factory BaseState.success(T data, {String? message}) => BaseState<T>(
        status: ViewStatus.success,
        data: data,
        message: message,
      );

  factory BaseState.empty({String? message}) => BaseState<T>(
        status: ViewStatus.empty,
        message: message,
      );

  factory BaseState.error(String message, {T? data}) => BaseState<T>(
        status: ViewStatus.error,
        data: data,
        message: message,
      );

  bool get isIdle => status == ViewStatus.idle;
  bool get isLoading => status == ViewStatus.loading;
  bool get isSuccess => status == ViewStatus.success;
  bool get isEmpty => status == ViewStatus.empty;
  bool get isError => status == ViewStatus.error;
}
