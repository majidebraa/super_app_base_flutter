enum ResourceState { loading, success, error }

class Resource<T> {
  final ResourceState state;
  final T? data;
  final String? message;

  const Resource.loading()
      : state = ResourceState.loading,
        data = null,
        message = null;

  const Resource.success(this.data)
      : state = ResourceState.success,
        message = null;

  const Resource.error(this.message)
      : state = ResourceState.error,
        data = null;

  T getOrThrow() {
    if (state == ResourceState.success && data != null) {
      return data!;
    } else if (state == ResourceState.error) {
      throw Exception(message!);
    } else {
      throw Exception('Data not loaded');
    }
  }
}