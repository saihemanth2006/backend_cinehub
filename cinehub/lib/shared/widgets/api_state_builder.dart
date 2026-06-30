import 'package:flutter/material.dart';

/// Generic widget that renders different UI based on async state.
///
/// Eliminates repetitive loading/error/empty/data switch statements.
///
/// ```dart
/// ApiStateBuilder<List<ProjectDto>>(
///   isLoading: state.isLoading,
///   hasError: state.hasError,
///   errorMessage: state.errorMessage,
///   isEmpty: state.projects.isEmpty,
///   data: state.projects,
///   onRetry: () => ref.read(projectsListProvider.notifier).refresh(),
///   builder: (context, projects) => ProjectGrid(projects: projects),
/// )
/// ```
class ApiStateBuilder<T> extends StatelessWidget {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final bool isEmpty;
  final T? data;
  final Widget Function(BuildContext context, T data) builder;
  final VoidCallback? onRetry;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final Widget Function(String message, VoidCallback? onRetry)? errorBuilder;

  const ApiStateBuilder({
    super.key,
    required this.isLoading,
    required this.hasError,
    required this.isEmpty,
    required this.data,
    required this.builder,
    this.errorMessage,
    this.onRetry,
    this.loadingWidget,
    this.emptyWidget,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && data == null) {
      return loadingWidget ?? const _DefaultLoadingWidget();
    }

    if (hasError && data == null) {
      if (errorBuilder != null) {
        return errorBuilder!(errorMessage ?? 'Something went wrong', onRetry);
      }
      return _DefaultErrorWidget(
        message: errorMessage ?? 'Something went wrong',
        onRetry: onRetry,
      );
    }

    if (isEmpty && data == null) {
      return emptyWidget ?? const _DefaultEmptyWidget();
    }

    if (data != null) {
      return builder(context, data as T);
    }

    return const SizedBox.shrink();
  }
}

class _DefaultLoadingWidget extends StatelessWidget {
  const _DefaultLoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _DefaultErrorWidget({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DefaultEmptyWidget extends StatelessWidget {
  const _DefaultEmptyWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 48, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              'Nothing here yet',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget that shows a "Load More" indicator at the bottom of scrollable lists.
class LoadMoreIndicator extends StatelessWidget {
  final bool isLoadingMore;
  final bool hasMore;
  final VoidCallback onLoadMore;

  const LoadMoreIndicator({
    super.key,
    required this.isLoadingMore,
    required this.hasMore,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasMore) return const SizedBox.shrink();

    if (isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    // Use a VisibilityDetector or NotificationListener in parent
    // to auto-trigger loadMore. This is the manual fallback.
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: TextButton(
          onPressed: onLoadMore,
          child: const Text('Load more'),
        ),
      ),
    );
  }
}

/// Mixin for scroll controllers to trigger pagination.
mixin InfiniteScrollMixin {
  void setupScrollListener(
    ScrollController controller, {
    required VoidCallback onLoadMore,
    double threshold = 200,
  }) {
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - threshold) {
        onLoadMore();
      }
    });
  }
}
