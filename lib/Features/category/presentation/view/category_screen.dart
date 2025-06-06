// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:albazar_app/core/widgets/custom_bottom_nav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:albazar_app/Features/ads/data/models/ad.dart';
import 'package:albazar_app/Features/category/data/models/category.dart';
import 'package:albazar_app/Features/category/presentation/cubits/ads/category_ads_cubit.dart';
import 'package:albazar_app/Features/category/presentation/view/widget/custom_category_item.dart';
import 'package:albazar_app/Features/category/presentation/view/widget/custom_filter_drawer.dart';
import 'package:albazar_app/core/enums/request_status.dart';
import 'package:albazar_app/core/extensions/navigation_extension.dart';
import 'package:albazar_app/core/helper/debounce_helper.dart';
import 'package:albazar_app/core/options/options.dart';
import 'package:albazar_app/core/options/queries_options.dart';
import 'package:albazar_app/core/routes/routes.dart';
import 'package:albazar_app/core/utils/colors.dart';
import 'package:albazar_app/core/utils/icons.dart';
import 'package:albazar_app/core/utils/styles.dart';
import 'package:albazar_app/core/widgets/loading/custom_skeleton_widget.dart';
import 'package:albazar_app/core/widgets/loading/lazy_loading_list_view.dart';
import 'package:flutter_xlider/flutter_xlider.dart';


class CategoryScreen extends StatefulWidget {
  final Category category;
  // final String title;
  const CategoryScreen({
    super.key,
    required this.category,
    // required this.title,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic>? _filters;

  String _query = "";

  final DebounceHelper _debounce = DebounceHelper();


  // final List<String> categoryItems = [
  //   "سكني",
  //   "تجاري",
  // ];
  // final List<String> typeCategory = [
  //   "بناء ",
  //   "بيت عربي",
  //   "بيت عربي",
  //   "فيلا",
  //   "فيلا",
  //   "فيلا",
  //   "فيلا",
  // ];

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomFilterDrawer(
        category: widget.category,
        filters: _filters,
        onResult: (filters) {
          if (filters == _filters) return;
          setState(() {
            _filters = filters;
            log("filters: $_filters");
            context.read<CategoryAdsCubit>().refreshCategoryAds(
                  options: PaginationOptions(
                    queryOptions: AdsQueryOptions(
                        category: widget.category.id,
                        sortBy: "-createdAt",
                        others: _filters,
                        post: true),
                  ),
                );
          });
        },
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              width: double.infinity, // Responsive width
              height: 210,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _debounce.cancel();
                          _query = "";
                          context.read<CategoryAdsCubit>().refreshCategoryAds(
                                options: PaginationOptions(
                                  queryOptions: AdsQueryOptions(
                                    category: widget.category.id,
                                    sortBy: "-createdAt",
                                    others: _filters,
                                    post: true,
                                  ),
                                ),
                              );
                          setState(() {});
                          return;
                        }
                        _debounce.debounce(callback: () {
                          log("query: $value");
                          _query = value.trim();
                          context.read<CategoryAdsCubit>().refreshCategoryAds(
                                options: PaginationOptions(
                                  queryOptions: AdsQueryOptions(
                                      category: widget.category.id,
                                      query: _query,
                                      sortBy: "-createdAt",
                                      others: _filters,
                                      post: true),
                                ),
                              );
                          setState(() {});
                        });
                      },
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن ${widget.category.name}',
                        fillColor: Theme.of(context).secondaryHeaderColor,
                        filled: true,
                        suffixIcon: Icon(
                          Icons.search,
                          color: Theme.of(context).hoverColor,
                          size: 25,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Theme.of(context).secondaryHeaderColor,
                              width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Theme.of(context).secondaryHeaderColor,
                              width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(Icons.filter_list)),
                      GestureDetector(
                        onTap: () => _scaffoldKey.currentState!.openDrawer(),
                        child: Container(
                          width: 35,
                          height: 35,
                          margin: const EdgeInsets.only(right: 10),
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: SvgPicture.asset(
                            AppIcons.filter,
                            // ignore: deprecated_member_use
                            color: Theme.of(context).focusColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("فلتر",
                          style: Styles.style13
                              .copyWith(color: Theme.of(context).focusColor)),
                      const Spacer(),
                      GestureDetector(
                        onTap:
                            // _restFilters
                            () {
                          (context).pushReplacementNamed(
                            AppRoutes.category,
                            arguments: widget.category,
                          );
                        },
                        child: Text(
                          'إعادة',
                          style: Styles.style13
                              .copyWith(color: Theme.of(context).focusColor),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height - 361.h,
              child: BlocBuilder<CategoryAdsCubit, CategoryAdsState>(
                builder: (context, state) {
                  log("page: ${state.page}");
                  return CustomRefreshWidget(
                    onRefresh: () async {
                      context.read<CategoryAdsCubit>().refreshCategoryAds(
                            options: PaginationOptions(
                              queryOptions: AdsQueryOptions(
                                category: widget.category.id,
                                others: _filters,
                                sortBy: "-createdAt",
                                post: true,
                              ),
                            ),
                          );
                    },
                    child: LazyLoadingView.list(
                      scrollController: _scrollController,

                      shrinkWrap: true,
                      primary: false,
                      onRequest: () async {
                        if (state.isLastPage) return;
                        context.read<CategoryAdsCubit>().getCategoryAds(
                              options: PaginationOptions(
                                queryOptions: AdsQueryOptions(
                                  category: widget.category.id,
                                  query: _query,
                                  others: _filters,
                                  sortBy: "-createdAt",
                                  post: true,
                                ),
                              ),
                            );
                        // await Future.delayed(const Duration(seconds: 2), () {
                        //   _page++;
                        //   setState(() {
                        //     _isLoading = false;
                        //   });
                        //   log("request end: $_page");
                        // });
                      },
                      firstPageLoader: CustomSkeletonWidget(
                        isLoading: true,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => _loadingAds[index],
                          itemCount: _loadingAds.length,
                        ),
                      ),
                      loader: CustomSkeletonWidget(
                        isLoading: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomCardItem(
                            showStar: false,
                            ad: _dummyAd,
                            category: widget.category,
                            onTap: () {},
                          ),
                        ),
                      ),
                      page: state.page,

                      // error: 'ssdsd',
                      limit: 10,
                      isLoading: state.status == RequestStatus.loading,
                      isLastPage: state.isLastPage,
                      error: state.error,
                      items: List.generate(
                        state.ads.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomCardItem(
                            showStar: false,
                            ad: state.ads[index],
                            category: widget.category,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
           
            // const Spacer(),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get _loadingAds => List.generate(
        10,
        (_) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CustomCardItem(
            showStar: false,
            ad: _dummyAd,
            category: widget.category,
          ),
        ),
      );

  final Ad _dummyAd = Ad(
    id: '',
    currency: '',
    adTitle: 'sdsdsd',
    description: 'sdsdsd',
    price: "sdsdsd",
    images: const [],
    category: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // ignore: unused_element
  void _restFilters() {
    if (_searchController.text.isEmpty) return;
    _searchController.clear();
    _query = "";

    context.read<CategoryAdsCubit>().refreshCategoryAds(
          options: PaginationOptions(
            queryOptions: AdsQueryOptions(
              category: widget.category.id,
              others: _filters,
            ),
          ),
        );
  }
}

class CustomCardFilter extends StatelessWidget {
  final String text;
  const CustomCardFilter({
    super.key,
    this.text = "sqft",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 110,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F9FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '0',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Simplified Arabic',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Simplified Arabic',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CustomRefreshWidget extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomRefreshWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CustomScrollView(
        // physics: const BouncingScrollPhysics(),
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: onRefresh,
          ),
          SliverToBoxAdapter(
            child: child,
          )
        ],
      );
    }
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColor.coverPageColor,
      backgroundColor: Colors.black,
      child: child,
    );
  }

   
}

