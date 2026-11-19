import 'dart:async';

import 'package:base_flutter/core/error/failure.dart';
import 'package:base_flutter/core/l10n/failure_message.dart';
import 'package:base_flutter/core/pagination/paged_state.dart';
import 'package:base_flutter/core/widgets/status_views.dart';
import 'package:base_flutter/i18n/gen/translations.g.dart';
import 'package:material_ui/material_ui.dart';

/// List UI for a [PagedState]: loader, error, empty view, pull to refresh,
/// load-more on scroll and a footer for the next page's loader or error.
/// A failed pull to refresh shows a snackbar (needs a `Scaffold` above).
///
/// Pair it with a `PaginatedCubit`:
/// ```dart
/// BlocBuilder<OrdersCubit, PagedState<Order>>(
///   builder: (context, state) => PagedListView(
///     state: state,
///     onRefresh: context.read<OrdersCubit>().refresh,
///     onLoadMore: context.read<OrdersCubit>().loadMore,
///     itemBuilder: (_, order) => OrderTile(order: order),
///   ),
/// )
/// ```
class PagedListView<T> extends StatefulWidget {
  const PagedListView({
    required this.state,
    required this.onRefresh,
    required this.onLoadMore,
    required this.itemBuilder,
    this.emptyMessage,
    this.emptyIcon = Icons.inbox_outlined,
    super.key,
  });

  /// Used by E2E tests to tap "Retry" in the load-more footer.
  static const loadMoreRetryKey = Key('pagedListView.loadMoreRetryButton');

  final PagedState<T> state;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Defaults to the generic "no data" text.
  final String? emptyMessage;
  final IconData emptyIcon;

  @override
  State<PagedListView<T>> createState() => _PagedListViewState<T>();
}

class _PagedListViewState<T> extends State<PagedListView<T>> {
  /// Start loading the next page this many pixels before the end.
  static const _loadMoreThreshold = 300.0;

  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_maybeLoadMore);
  }

  @override
  void didUpdateWidget(PagedListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final refreshFailure = widget.state.refreshFailure;
    final isNewRefreshFailure =
        refreshFailure != null &&
        !identical(refreshFailure, oldWidget.state.refreshFailure);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (isNewRefreshFailure) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(content: Text(refreshFailure.message(context.t))),
        );
      }
      // A short first page may not fill the screen, so no scroll event
      // would ever trigger the next page; check again after layout.
      _maybeLoadMore();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _maybeLoadMore() {
    final state = widget.state;
    if (!mounted ||
        !_controller.hasClients ||
        state.hasReachedEnd ||
        state.isLoadingMore ||
        state.loadMoreFailure != null) {
      return;
    }
    if (_controller.position.extentAfter < _loadMoreThreshold) {
      unawaited(widget.onLoadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final state = widget.state;

    return switch (state.status) {
      PagedStatus.initial || PagedStatus.loading => const LoadingView(),
      PagedStatus.failure => FailureView(
        message: (state.failure ?? const UnknownFailure()).message(t),
        onRetry: widget.onRefresh,
      ),
      PagedStatus.success when state.items.isEmpty => RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: LayoutBuilder(
          // Scrollable so pull to refresh still works on an empty list.
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: constraints.maxHeight,
              child: MessageView(
                icon: widget.emptyIcon,
                message: widget.emptyMessage ?? t.no_data,
              ),
            ),
          ),
        ),
      ),
      PagedStatus.success => RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: ListView.separated(
          controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state.items.length + (_hasFooter(state) ? 1 : 0),
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) => index < state.items.length
              ? widget.itemBuilder(context, state.items[index])
              : _Footer(state: state, onRetry: widget.onLoadMore),
        ),
      ),
    };
  }

  bool _hasFooter(PagedState<T> state) =>
      state.isLoadingMore || state.loadMoreFailure != null;
}

class _Footer extends StatelessWidget {
  const _Footer({required this.state, required this.onRetry});

  final PagedState<dynamic> state;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = state.loadMoreFailure;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: failure == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(failure.message(context.t), textAlign: TextAlign.center),
                  TextButton(
                    key: PagedListView.loadMoreRetryKey,
                    onPressed: onRetry,
                    child: Text(context.t.retry),
                  ),
                ],
              ),
      ),
    );
  }
}
