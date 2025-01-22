

import 'package:flutter/material.dart';

import '../../domain/utils/resources.dart';

extension ResourceExt<T> on Resource<T> {
  Widget when({
    required Widget Function(T data) success,
    required Widget Function(String message) error,
    required Widget Function() loading,
  }) {
    switch (state) {
      case ResourceState.loading:
        return loading();
      case ResourceState.success:
        return data !=null ? success(data as T) : error("Unexpected error: data is null");
      case ResourceState.error:
        return error(message!);
    }
  }
}