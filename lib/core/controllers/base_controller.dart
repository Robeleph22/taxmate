import 'package:get/get.dart';

import '../state/base_state.dart';

/// Base GetX controller that exposes a [BaseState] and helpers for
/// loading/success/error handling.
abstract class BaseController<T> extends GetxController {
  final Rx<BaseState<T>> state = BaseState<T>.idle().obs;

  /// Called by views or by [onInit] to load initial data.
  Future<void> loadData() async {}

  Future<void> refreshData() async {
    try {
      setLoading(isRefreshing: true);
      await loadData();
    } catch (e) {
      setError(e.toString());
    }
  }

  void setLoading({bool isRefreshing = false}) {
    state.value = BaseState<T>.loading(
      data: state.value.data,
      isRefreshing: isRefreshing,
    );
  }

  void setSuccess(T data, {String? message}) {
    state.value = BaseState<T>.success(data, message: message);
  }

  void setEmpty({String? message}) {
    state.value = BaseState<T>.empty(message: message);
  }

  void setError(String message, {T? data}) {
    state.value = BaseState<T>.error(message, data: data ?? state.value.data);
  }
}
