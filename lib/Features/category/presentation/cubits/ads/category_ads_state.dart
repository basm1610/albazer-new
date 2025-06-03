part of 'category_ads_cubit.dart';

class CategoryAdsState extends Equatable {
  final List<Ad> ads;
  final RequestStatus status;
  final String error;
  final bool isLastPage;
  final int page;
  const CategoryAdsState({
    this.ads = const [],
    this.status = RequestStatus.initial,
    this.error = '',
    this.isLastPage = false,
    this.page = 1,
  });

  CategoryAdsState copyWith({
    List<Ad>? ads,
    RequestStatus? status,
    String? error,
    bool? isLastPage,
    int? page,
  }) {
    return CategoryAdsState(
      ads: ads ?? this.ads,
      status: status ?? this.status,
      error: error ?? this.error,
      isLastPage: isLastPage ?? this.isLastPage,
      page: page ?? this.page,
    );
  }

  @override
  List<Object> get props => [
        ads,
        status,
        error,
        isLastPage,
        page,
      ];
}
