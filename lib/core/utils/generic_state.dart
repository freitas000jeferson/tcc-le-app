enum RequestStatus { idle, loading, success, failure }

class GenericState<T> {
  RequestStatus status;
  T? data;
  String? error;
  GenericState({required this.status, this.data, this.error});

  bool hasLoading() => status == RequestStatus.loading;
  bool hasError() => status == RequestStatus.failure;
  bool hasSuccess() => status == RequestStatus.success;

  factory GenericState.loading() => GenericState(status: RequestStatus.loading);
  factory GenericState.idle() => GenericState(status: RequestStatus.idle);

  factory GenericState.success(T data) =>
      GenericState(status: RequestStatus.success, data: data);

  factory GenericState.failure(String error) =>
      GenericState(status: RequestStatus.failure, error: error);

  @override
  String toString() {
    return 'Query(status: $status, data: $data, error: $error)';
  }
}
