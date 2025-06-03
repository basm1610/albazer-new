import 'dart:developer';

import 'package:albazar_app/Features/ads/data/models/ad.dart';
import 'package:albazar_app/Features/ads/data/repositories/ads_repository.dart';
import 'package:albazar_app/core/enums/request_status.dart';
import 'package:albazar_app/core/errors/exceptions.dart';
import 'package:albazar_app/core/options/options.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_ads_state.dart';

class CategoryAdsCubit extends Cubit<CategoryAdsState> {
  final IAdsRepo repository;
  CategoryAdsCubit({
    required this.repository,
  }) : super(const CategoryAdsState());

  Future<void> getCategoryAds({required PaginationOptions options}) async {
    if (state.status == RequestStatus.loading) return;
    try {
      emit(
        state.copyWith(
          status: RequestStatus.loading,
          error: '',
          // page: state.page,
          // isLastPage: options.page == 1 ? false : state.isLastPage,
        ),
      );

      final ads = await repository.getCategoryAds(
          options: options.copyWith(
        page: state.page,
      ));
      emit(
        state.copyWith(
          ads: [...state.ads, ...ads],
          status: RequestStatus.success,
          error: '',
          page: state.page + 1,
          isLastPage: ads.length < options.limit,
        ),
      );
    } on AppException catch (e, s) {
      log('Error : $e  Stack : $s');
      emit(state.copyWith(error: e.message, status: RequestStatus.error));
    } catch (e, s) {
      log('Error : $e  Stack : $s');
      emit(state.copyWith(error: e.toString(), status: RequestStatus.error));
    }
  }

  Future<void> refreshCategoryAds({required PaginationOptions options}) async {
    if (state.status == RequestStatus.loading) return;
    try {
      emit(
        state.copyWith(
          status: RequestStatus.loading,
          ads: [],
          error: '',
          page: 1,
          isLastPage: false,
        ),
      );
      final ads = await repository.getCategoryAds(options: options);
      emit(
        state.copyWith(
          ads: [...state.ads, ...ads],
          status: RequestStatus.success,
          error: '',
          page: state.page + 1,
          isLastPage: ads.length < options.limit,
        ),
      );
    } on AppException catch (e) {
      emit(state.copyWith(error: e.message, status: RequestStatus.error));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), status: RequestStatus.error));
    }
  }
}
