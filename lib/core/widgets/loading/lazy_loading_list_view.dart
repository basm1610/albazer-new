import 'package:flutter/material.dart';

class LazyLoadingView extends StatefulWidget {
  const LazyLoadingView._({
    this.shrinkWrap = false,
    this.primary = false,
    this.physics,
    required this.items,
    required this.scrollController,
    required this.onRequest,
    required this.isGrid,
    this.padding,
    this.firstPageLoader,
    this.loader,
    this.firstPageError,
    this.errorWidget,
    this.firstPageEmptyWidget,
    this.page = 1,
    this.limit = 10,
    this.error = '',
    this.isLoading = false,
    this.isLastPage = false,
    this.crossAxisCount,
    this.childAspectRatio,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
  });

  factory LazyLoadingView.list({
    bool shrinkWrap = false,
    bool primary = false,
    ScrollPhysics? physics,
    required List<Widget> items,
    required ScrollController scrollController,
    required VoidCallback onRequest,
    EdgeInsetsGeometry? padding,
    Widget? firstPageLoader,
    Widget? loader,
    Widget? firstPageError,
    Widget? errorWidget,
    Widget? firstPageEmptyWidget,
    int page = 1,
    int limit = 10,
    String error = '',
    bool isLoading = false,
    bool isLastPage = false,
  }) =>
      LazyLoadingView._(
        isGrid: false,
        shrinkWrap: shrinkWrap,
        primary: primary,
        physics: physics,
        items: items,
        scrollController: scrollController,
        onRequest: onRequest,
        padding: padding,
        firstPageLoader: firstPageLoader,
        loader: loader,
        firstPageError: firstPageError,
        errorWidget: errorWidget,
        firstPageEmptyWidget: firstPageEmptyWidget,
        page: page,
        limit: limit,
        error: error,
        isLoading: isLoading,
        isLastPage: isLastPage,
      );
  factory LazyLoadingView.grid({
    bool shrinkWrap = false,
    bool primary = false,
    ScrollPhysics? physics,
    required List<Widget> items,
    required ScrollController scrollController,
    required VoidCallback onRequest,
    int? crossAxisCount,
    double? childAspectRatio,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    EdgeInsetsGeometry? padding,
    Widget? firstPageLoader,
    Widget? loader,
    Widget? firstPageError,
    Widget? errorWidget,
    Widget? firstPageEmptyWidget,
    int page = 1,
    int limit = 10,
    String error = '',
    bool isLoading = false,
    bool isLastPage = false,
  }) =>
      LazyLoadingView._(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        isGrid: true,
        shrinkWrap: shrinkWrap,
        primary: primary,
        physics: physics,
        items: items,
        scrollController: scrollController,
        onRequest: onRequest,
        padding: padding,
        firstPageLoader: firstPageLoader,
        loader: loader,
        firstPageError: firstPageError,
        errorWidget: errorWidget,
        firstPageEmptyWidget: firstPageEmptyWidget,
        page: page,
        limit: limit,
        error: error,
        isLoading: isLoading,
        isLastPage: isLastPage,
      );

  final String error;
  final Widget? firstPageLoader,
      loader,
      firstPageError,
      errorWidget,
      firstPageEmptyWidget;

  final bool isLoading, isLastPage, shrinkWrap, primary, isGrid;
  final List<Widget> items;
  final int page, limit;
  final VoidCallback onRequest;
  final EdgeInsetsGeometry? padding;
  final ScrollController scrollController;
  final ScrollPhysics? physics;
  final int? crossAxisCount;
  final double? childAspectRatio, crossAxisSpacing, mainAxisSpacing;

  @override
  State<LazyLoadingView> createState() => _LazyLoadingViewState();
}

class _LazyLoadingViewState extends State<LazyLoadingView> {
  @override
  void initState() {
    if (widget.page == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.scrollController.addListener(_requestListener);
        widget.onRequest();
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_requestListener);
    super.dispose();
  }

  void _requestListener() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.scrollController.position.pixels >
          widget.scrollController.position.maxScrollExtent - 200) {
        if (widget.isLastPage || widget.isLoading) return;
        widget.onRequest();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.page == 1) {
      if (widget.isLoading) {
        return widget.firstPageLoader ??
            const Center(child: CircularProgressIndicator());
      }
      if (widget.error.isNotEmpty) {
        return widget.firstPageError ??
            widget.errorWidget ??
            Center(child: Text(widget.error));
      }
    }
    if (widget.items.isEmpty) {
      return widget.firstPageEmptyWidget ??
          const Center(child: Text('لا يوجد بيانات'));
    }
    if (widget.isGrid) {
      return GridView.builder(
        shrinkWrap: widget.shrinkWrap,
        physics: widget.physics,
        controller: widget.scrollController,
        padding: widget.padding,
        primary: widget.primary,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount ?? 2,
// 3 columns
          crossAxisSpacing: widget.crossAxisSpacing ?? 0,
          mainAxisSpacing: widget.mainAxisSpacing ?? 0,
          childAspectRatio: widget.childAspectRatio ?? 0.7,
        ),
        itemCount: widget.items.length +
            ((widget.isLoading && !widget.isLastPage) ||
                    (widget.error.isNotEmpty && !widget.isLastPage)
                ? 1
                : 0),
        itemBuilder: (context, index) {
          if (index == widget.items.length) {
            if (widget.isLoading) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.loader ??
                    const Center(child: CircularProgressIndicator()),
              );
            }
            if (widget.error.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.errorWidget ?? Center(child: Text(widget.error)),
              );
            }
            return const SizedBox.shrink();
          }
          return widget.items[index];
        },
      );
    }
    return ListView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      controller: widget.scrollController,
      padding: widget.padding,
      primary: widget.primary,
      itemCount: widget.items.length +
          ((widget.isLoading && !widget.isLastPage) ||
                  (widget.error.isNotEmpty && !widget.isLastPage)
              ? 1
              : 0),
      itemBuilder: (context, index) {
        if (index == widget.items.length) {
          if (widget.isLoading) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.loader ??
                  const Center(child: CircularProgressIndicator()),
            );
          }
          if (widget.error.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.errorWidget ?? Center(child: Text(widget.error)),
            );
          }
          return const SizedBox.shrink();
        }
        return widget.items[index];
      },
    );
  }
}
