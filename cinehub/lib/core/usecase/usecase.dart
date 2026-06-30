import 'package:fpdart/fpdart.dart';
import '../error/failures.dart';

/// Base use case contract.
///
/// Every use case returns `Either<Failure, T>` to force callers
/// to handle both success and error paths.
///
/// ```dart
/// class GetProjects extends UseCase<List<Project>, NoParams> {
///   @override
///   Future<Either<Failure, List<Project>>> call(NoParams params) async { ... }
/// }
/// ```
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use when a use case requires no parameters.
class NoParams {
  const NoParams();
}

/// Paging parameters.
class PageParams {
  final int page;
  final int limit;

  const PageParams({this.page = 1, this.limit = 20});
}
