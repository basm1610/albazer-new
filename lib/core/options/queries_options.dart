import 'package:equatable/equatable.dart';

abstract class QueryOptions extends Equatable {
  final String? query, sortBy;
  const QueryOptions({this.query, this.sortBy});

  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [query, sortBy];
}

class AdsQueryOptions extends QueryOptions {
  final String? user, category;
  final bool? post, pending, rejected;
  final Map<String, dynamic>? others;

  const AdsQueryOptions({
    this.user,
    this.category,
    this.others,
    super.query,
    super.sortBy,
    this.post,
    this.pending,
    this.rejected,
  });

  @override
  Map<String, dynamic> toJson() => {
        if (user != null && user!.isNotEmpty) 'user': user,
        if (category != null && category!.isNotEmpty) 'category': category,
        if (query != null && query!.isNotEmpty) 'keyword': query,
        if (sortBy != null && sortBy!.isNotEmpty) 'sort': sortBy,
        if (post != null) 'post': post,
        if (pending != null) 'pending': pending,
        if (rejected != null) 'rejected': rejected,
        if (others != null) ...others!
      };

  @override
  List<Object?> get props => [user, category, others, ...super.props];
}
