import 'dart:developer';
import 'dart:io';

import 'package:albazar_app/Features/ads/data/models/ad.dart';
import 'package:albazar_app/Features/ads/presentation/cubit/new_ad_cubit.dart';
import 'package:albazar_app/Features/ads/presentation/view/google_map_screen.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/check_boxes_section.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/chip_section.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/custom_check_box.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/number_field.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/submit_ad_button.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/upload_photos_section.dart';
import 'package:albazar_app/Features/category/data/models/category.dart';
import 'package:albazar_app/core/di/locator.dart';
import 'package:albazar_app/core/helper/messages.dart';
import 'package:albazar_app/core/helper/user_helper.dart';
import 'package:albazar_app/core/utils/constants.dart';
import 'package:albazar_app/core/widgets/custom_drob_down.dart';
import 'package:albazar_app/core/widgets/fields/custom_labeled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../numbers_section.dart';

class CarsForSaleForm extends StatefulWidget {
  final Category category;
  const CarsForSaleForm({super.key, required this.category});

  @override
  State<CarsForSaleForm> createState() => _CarsForSaleFormState();
}

class _CarsForSaleFormState extends State<CarsForSaleForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, GlobalKey> _fieldKeys = {
    'brand': GlobalKey(),
    'version': GlobalKey(),
    'model': GlobalKey(),
    'color': GlobalKey(),
    'doors': GlobalKey(),
    'interior': GlobalKey(),
    'seats': GlobalKey(),
    'condition': GlobalKey(),
    'owner': GlobalKey(),
    'saleType': GlobalKey(),
    'adTitle': GlobalKey(),
    'description': GlobalKey(),
    'city': GlobalKey(),
    'location': GlobalKey(),
    'currency': GlobalKey(),
    'payment': GlobalKey(),
    'price': GlobalKey(),
    'addons': GlobalKey(),
    'fuel': GlobalKey(),
    'transmission': GlobalKey(),
    'mileage': GlobalKey(),
    'name': GlobalKey(),
    'phone': GlobalKey(),
    'contact': GlobalKey(),
  };

  final TextEditingController _adTitleController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _locationController = TextEditingController(),
      _priceController = TextEditingController(),
      _nameController = TextEditingController(),
      _phoneController = TextEditingController(),
      _kilometerController = TextEditingController(),
      _colorController = TextEditingController(),
      _modelController = TextEditingController(),
      _versionController = TextEditingController(),
      _doorsController = TextEditingController(),
      _innerPartController = TextEditingController(),
      _sypController = TextEditingController();
  final List<File> _images = [];
  String _selectedFuelType = '',
      _selectedTransmission = '',
      _selectedPaymentMethod = '',
      _owner = '',
      _dollarOrLera = 'ليره',
      _selectedSaleOrRent = '',
      // ignore: prefer_final_fields
      _selectedCarType = '';
  String? _selectedCity;
  String? _selectedBrand;
  int? _selectedseats = 0;
  bool _negotiable = false;
  double? lat;
  double? long;
  final List<String> _selectedAddOns = [];
  List<String> _selectedContactMethod = [];
  final List<String> contactMethods = [
    "موبايل",
    "شات",
  ];
  final List<String> isOwner = [
    "المالك",
    "وكيل",
  ];
  final List<String> paymentMethods = [
    "كاش",
    "تقسيط",
    "كاش أو تقسيط",
  ];
  final List<String> addOns = [
    "وسائد هوائية",
    "راديو",
    "نوافذ كهربائية",
    "مرايا كهربائية",
    "نظام بلوتوث",
    "شاحن يو اس بى",
  ];
  final List<String> fuelTypes = [
    "بنزين",
    "كهرباء",
    "غاز طبيعى",
    "ديزل",
  ];
  final List<String> transmissions = [
    "اتوماتيك",
    "يدوى/عادى",
  ];
  final List<String> saleOrRentChoices = [
    "بيع",
    "إيجار",
  ];
  final List<String> newOrUsedChoices = [
    "جديد",
    "مستعمل",
  ];
  final List<String> dollarOrLera = [
    "دولار",
    "ليره",
  ];
  void _scrollToFirstInvalidField() {
    final invalidFields = [
      if (_selectedBrand == null) _fieldKeys['brand'],
      if (_versionController.text.isEmpty) _fieldKeys['version'],
      if (_modelController.text.isEmpty) _fieldKeys['model'],
      if (_colorController.text.isEmpty) _fieldKeys['color'],
      if (_doorsController.text.isEmpty) _fieldKeys['doors'],
      if (_innerPartController.text.isEmpty) _fieldKeys['interior'],
      if (_selectedseats == null) _fieldKeys['seats'],
      if (_selectedCarType.isEmpty) _fieldKeys['condition'],
      if (_owner.isEmpty) _fieldKeys['owner'],
      if (_selectedSaleOrRent.isEmpty) _fieldKeys['saleType'],
      if (_adTitleController.text.isEmpty) _fieldKeys['adTitle'],
      if (_descriptionController.text.isEmpty) _fieldKeys['description'],
      if (_selectedCity == null) _fieldKeys['city'],
      if (_locationController.text.isEmpty) _fieldKeys['location'],
      if (_selectedPaymentMethod.isEmpty) _fieldKeys['payment'],
      if (_priceController.text.isEmpty) _fieldKeys['price'],
      if (_selectedFuelType.isEmpty) _fieldKeys['fuel'],
      if (_selectedTransmission.isEmpty) _fieldKeys['transmission'],
      if (_kilometerController.text.isEmpty) _fieldKeys['mileage'],
      if (_nameController.text.isEmpty) _fieldKeys['name'],
      if (_phoneController.text.isEmpty) _fieldKeys['phone'],
    ];

    if (invalidFields.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          invalidFields.first!.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      });
    }
  }

  @override
  void dispose() {
    _adTitleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _kilometerController.dispose();
    _sypController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        cacheExtent: 10000,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        children: [
          UploadPhotosSection(
            images: _images,
            onImagesUpload: (images) {
              setState(() {
                _images.clear();
                _images.addAll(images);
              });
            },
          ),
          const SizedBox(height: 25),
          Text(
            'الماركة',
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontSize: 16,
              fontFamily: 'Noor',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            key: _fieldKeys['brand'],
            selectedValue: _selectedBrand,
            hint: "اختار ماركة السيارة ...",
            carOptions: AppConstants.cars,
            onChanged: (brand) => setState(() => _selectedBrand = brand!),
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['version'],
            controller: _versionController,
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل نسخة السيارة' : null,
            label: 'نسخة السيارة',
            hint: "نسخة السيارة",
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['model'],
            controller: _modelController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل موديل السيارة' : null,
            label: 'موديل السيارة',
            hint: "موديل السيارة",
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['color'],
            controller: _colorController,
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل لون السيارة' : null,
            label: 'لون السيارة',
            hint: "لون السيارة",
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['doors'],
            controller: _doorsController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل عدد الابواب' : null,
            label: 'عدد الابواب',
            hint: "عدد الابواب",
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['interior'],
            controller: _innerPartController,
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل الجزء الداخلى' : null,
            label: 'الجزء الداخلى',
            hint: "الجزء الداخلى",
          ),
          const SizedBox(height: 25),
          NumbersSection(
            key: _fieldKeys['seats'],
            title: 'عدد المقاعد',
            maxNumbers: 7,
            selectedNumber: _selectedseats ?? 0,
            onSelect: (seats) => setState(() => _selectedseats = seats),
          ),
          const SizedBox(height: 25),
          ChipSection(
            key: _fieldKeys['condition'],
            title: 'جديد/مستعمل',
            items: newOrUsedChoices,
            selectedItems: [_selectedCarType],
            onSelect: (choice) => setState(() => _selectedCarType = choice),
          ),
          const SizedBox(height: 25),
          CheckBoxesSection(
            key: _fieldKeys['owner'],
            title: 'تم النشر من قبل',
            items: isOwner,
            selectedItems: [_owner],
            onChanged: (status) {
              setState(() {
                _owner = _owner == status ? '' : status;
              });
            },
          ),
          const SizedBox(height: 25),
          ChipSection(
            key: _fieldKeys['saleType'],
            title: 'بيع/ايجار',
            items: saleOrRentChoices,
            selectedItems: [_selectedSaleOrRent],
            onSelect: (choice) => setState(() => _selectedSaleOrRent = choice),
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['adTitle'],
            controller: _adTitleController,
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل عنوان الاعلان' : null,
            label: 'عنوان الاعلان',
            hint: "ادخل عنوان الاعلان",
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['description'],
            controller: _descriptionController,
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل وصف الاعلان' : null,
            label: 'وصف الاعلان',
            hint: "الوصف",
            maxLines: 4,
          ),
          const SizedBox(height: 25),
          Text(
            'المحافظة',
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontSize: 16,
              fontFamily: 'Noor',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            key: _fieldKeys['city'],
            selectedValue: _selectedCity,
            hint: 'اختر المحافظة',
            options: AppConstants.cityLists,
            onChanged: (city) => setState(() => _selectedCity = city!),
          ),
          const SizedBox(height: 25),
          InkWell(
            onTap: () async {
              final locationData = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => locator<NewAdCubit>())
                    ],
                    child: const GoogleMapScreen(),
                  ),
                ),
              );

              if (locationData != null) {
                setState(() {
                  _locationController.text = locationData['address'] ??
                      "${locationData['lat']}, ${locationData['lng']}";
                  lat = locationData['lat'] is double
                      ? locationData['lat']
                      : double.tryParse(locationData['lat'].toString());
                  long = locationData['lng'] is double
                      ? locationData['lng']
                      : double.tryParse(locationData['lng'].toString());
                });
              }
            },
            child: CustomLabeledTextField(
              key: _fieldKeys['location'],
              enabled: false,
              controller: _locationController,
              validator: (value) => value!.isEmpty ? 'ادخل موقع السيارة' : null,
              label: 'موقع السيارة',
              hint: "ادخل موقع السيارة",
              suffix: const Icon(Icons.location_on),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "العملة",
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontSize: 16,
              fontFamily: 'Noor',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            key: _fieldKeys['currency'],
            selectedValue: _dollarOrLera,
            hint: "اختر العملة",
            options: const ['دولار', 'ليره'],
            onChanged: (currency) => setState(() => _dollarOrLera = currency!),
          ),
          const SizedBox(height: 25),
          CheckBoxesSection(
            key: _fieldKeys['payment'],
            title: 'طريقة الدفع',
            items: paymentMethods,
            selectedItems: [_selectedPaymentMethod],
            onChanged: (paymentMethod) {
              setState(() {
                _selectedPaymentMethod = _selectedPaymentMethod == paymentMethod
                    ? ''
                    : paymentMethod;
              });
            },
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['price'],
            controller: _priceController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل سعر السيارة' : null,
            label: 'سعر السيارة',
            hint: _dollarOrLera != 'دولار'
                ? "ادخل سعر السيارة ... SYP"
                : "ادخل سعر السيارة ... USD",
          ),
          const SizedBox(height: 10),
          CustomCheckBox(
            text: "قابل للتفاوض",
            isChecked: _negotiable,
            onChanged: (value) => setState(() => _negotiable = value!),
          ),
          const SizedBox(height: 25),
          CheckBoxesSection(
            key: _fieldKeys['addons'],
            title: 'إضافات',
            isList: true,
            items: addOns,
            selectedItems: _selectedAddOns,
            onChanged: (addOn) {
              setState(() {
                _selectedAddOns.contains(addOn)
                    ? _selectedAddOns.remove(addOn)
                    : _selectedAddOns.add(addOn);
              });
            },
          ),
          const SizedBox(height: 25),
          CheckBoxesSection(
            key: _fieldKeys['fuel'],
            title: 'نوع الوقود',
            isList: true,
            items: fuelTypes,
            selectedItems: [_selectedFuelType],
            onChanged: (fuelType) {
              setState(() {
                _selectedFuelType =
                    _selectedFuelType == fuelType ? '' : fuelType;
              });
            },
          ),
          const SizedBox(height: 25),
          CheckBoxesSection(
            key: _fieldKeys['transmission'],
            title: 'ناقل الحركة',
            isList: true,
            items: transmissions,
            selectedItems: [_selectedTransmission],
            onChanged: (transmission) {
              setState(() {
                _selectedTransmission =
                    _selectedTransmission == transmission ? '' : transmission;
              });
            },
          ),
          const SizedBox(height: 25),
          NumberField(
            key: _fieldKeys['mileage'],
            title: 'كيلومترات',
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل كيلومترات السيارة' : null,
            controller: _kilometerController,
            metric: 'Kms',
          ),
          const SizedBox(height: 25),
          Text(
            'معلومات التواصل',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontSize: 16,
              fontFamily: 'Noor',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['name'],
            controller: _nameController,
            validator: (value) => value!.isEmpty ? 'من فضلك ادخل الاسم' : null,
            label: 'الاسم',
            hint: "ادخل الاسم",
          ),
          const SizedBox(height: 25),
          CustomLabeledTextField(
            key: _fieldKeys['phone'],
            controller: _phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11)
            ],
            validator: (value) =>
                value!.isEmpty ? 'من فضلك ادخل رقم الهاتف' : null,
            label: 'رقم الهاتف المحمول',
            hint: "ادخل رقم الهاتف",
          ),
          const SizedBox(height: 25),
          CheckBoxesSection(
            key: _fieldKeys['contact'],
            title: 'طريقه التواصل',
            items: contactMethods,
            selectedItems: _selectedContactMethod,
            onChanged: (contactMethod) {
              setState(() {
                _selectedContactMethod.contains(contactMethod)
                    ? _selectedContactMethod.remove(contactMethod)
                    : _selectedContactMethod.add(contactMethod);
              });
            },
          ),
          const SizedBox(height: 25),
          SubmitAdButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form is valid, proceed with submission
                _submit(context);
                // Your submission logic here
              } else {
                // Scroll to first invalid field
                _scrollToFirstInvalidField();
              }
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  void _submit(BuildContext context) {
    if (!_validate()) return;
    final ad = Ad(
      category: widget.category.id,
      currency: _dollarOrLera,
      publishedVia: _owner,
      type: _selectedCarType,
      color: _colorController.text.trim(),
      year: _modelController.text.trim(),
      doors: _doorsController.text.trim(),
      version: _versionController.text.trim(),
      innerpart: _innerPartController.text.trim(),
      seats: _selectedseats.toString(),
      listingstatus: _selectedSaleOrRent,
      city: _selectedCity,
      brand: _selectedBrand,
      adTitle: _adTitleController.text.trim(),
      description: _descriptionController.text.trim(),
      propertyLocation: _locationController.text.trim(),
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      contactMethod: _selectedContactMethod,
      paymentMethod: _selectedPaymentMethod,
      price: _priceController.text.trim(),
      negotiable: _negotiable,
      imageFiles: _images,
      additionalFeatures: _selectedAddOns,
      transmissionType: _selectedTransmission,
      fuelType: [_selectedFuelType],
      kilometers: _kilometerController.text.trim(),
      downPayment: _sypController.text.trim(),
      user: UserHelper.user?.id,
      lat: lat,
      long: long,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    log(ad.toJson().toString());
    context.read<NewAdCubit>().submitAd(ad: ad);
  }

  bool _validate() {
    if (_images.length < 5) {
      AppMessages.showError(context, 'ادخل علي الاقل 5 صور للإعلان');
      return false;
    }
    if (_adTitleController.text.length < 5) {
      AppMessages.showError(context, 'ادخل علي ما بين 5 و 20 حرف للعنوان');
      return false;
    }
    if (_adTitleController.text.length > 20) {
      AppMessages.showError(context, 'ادخل ما بين 5 و 20 حرف للعنوان');
      return false;
    }

    if (_descriptionController.text.length < 20) {
      AppMessages.showError(context, 'ادخل علي الاقل 20 حرف للوصف');
      return false;
    }
    if (_selectedPaymentMethod.isEmpty) {
      AppMessages.showError(context, 'ادخل طريقه الدفع');
      return false;
    }
    if (_selectedCity == null) {
      AppMessages.showError(context, 'اختر المحافظة');
      return false;
    }
    if (_dollarOrLera.isEmpty) {
      AppMessages.showError(context, 'اختر العملة');
      return false;
    }
    if (_selectedCarType.isEmpty) {
      AppMessages.showError(context, 'اختر بيع / مستعمل');
      return false;
    }
    if (_selectedseats == 0) {
      AppMessages.showError(context, 'اختر عدد المقاعد');
      return false;
    }
    if (_selectedAddOns.isEmpty) {
      AppMessages.showError(context, 'اختر الإضافات');
      return false;
    }
    if (_selectedFuelType.isEmpty) {
      AppMessages.showError(context, 'اختر نوع الوقود');
      return false;
    }
    if (_selectedTransmission.isEmpty) {
      AppMessages.showError(context, 'اختر نوع الناقل');
      return false;
    }

    if (_selectedContactMethod.isEmpty) {
      AppMessages.showError(context, 'ادخل طريقه التواصل');
      return false;
    }

    return _formKey.currentState!.validate();
  }
}
