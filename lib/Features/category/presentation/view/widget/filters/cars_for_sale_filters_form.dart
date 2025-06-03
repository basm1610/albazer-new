import 'package:albazar_app/Features/ads/presentation/widgets/check_boxes_section.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/chip_section.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/custom_check_box.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/number_field.dart';
import 'package:albazar_app/Features/ads/presentation/widgets/numbers_section.dart';
import 'package:albazar_app/core/utils/constants.dart';
import 'package:albazar_app/core/utils/icons.dart';
import 'package:albazar_app/core/widgets/custom_drob_down.dart';
import 'package:albazar_app/core/widgets/fields/custom_labeled_text_field.dart';
import 'package:flutter/material.dart';

class CarsForSaleFiltersForm extends StatefulWidget {
  final Map<String, dynamic>? filters;
  const CarsForSaleFiltersForm({super.key, this.filters});

  @override
  State<CarsForSaleFiltersForm> createState() => CarsForSaleFiltersFormState();
}

class CarsForSaleFiltersFormState extends State<CarsForSaleFiltersForm> {
  // ignore: unused_field
  String _selectedBrand = '',
      _selectedFuelType = '',
      _selectedContactMethod = '',
      _selectedTransmission = '';
  int? _selectedseats = 0;
  final TextEditingController _priceFromController = TextEditingController(),
      _priceToController = TextEditingController(),
      _providedFromController = TextEditingController(),
      _providedToController = TextEditingController(),
      _kilometerFromController = TextEditingController(),
      _kilometerToController = TextEditingController(),
      _cityController = TextEditingController(),
      _currencyController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _innerPartController = TextEditingController(),
      _doorsController = TextEditingController(),
      _colorController = TextEditingController(),
      _modelController = TextEditingController(),
      _versionController = TextEditingController(),
      _saleorRentController = TextEditingController();

  final List<String> _selectedAddOns = [];
  bool isChecked = false;
  String? _selectedCity;
  final List<String> addOns = [
    "وسائد هوائية",
    "راديو",
    "نوافذ كهربائية",
    "مرايا كهربائية",
    "نظام بلوتوث",
    "شاحن يو اس بى",
  ];
  final List<String> fuelTypes = [
    "البنزين",
    "كهرباء",
    "غاز طبيعى",
    "ديزل",
  ];
  final List<String> saleOrRentChoices = [
    "بيع",
    "إيجار",
  ];

  final List<String> carLogo = [
    AppIcons.ads,
    AppIcons.age,
    AppIcons.back,
    AppIcons.bathroom,
    AppIcons.chat,
  ];

  final List<String> newOrUsedChoices = [
    "جديد",
    "مستعمل",
  ];
  final List<String> isOwner = [
    "المالك",
    "وكيل",
  ];
  final List<String> transmissions = [
    "اتوماتيك",
    "يدوى/عادى",
  ];
  final List<String> contactMethods = [
    "كاش",
    "تقسيط",
    "كاش أو تقسيط",
  ];
  String _dollarOrLeraa = 'ليره',
      _selectedSaleOrRentvalue = '',
      _selectedCarType = '',
      _publishedVia = '';

  @override
  void initState() {
    _selectedBrand = widget.filters?["brand"] ?? '';
    _publishedVia = widget.filters?["publishedVia"] ?? '';
    _selectedFuelType = widget.filters?["fuel type"] ?? '';
    _selectedTransmission = widget.filters?["transmission type"] ?? '';
    _selectedCarType = widget.filters?["type"]?.toString() ?? '';
    _selectedseats = widget.filters?["number of sets"] ?? 0;
    _priceFromController.text = widget.filters?["price[gte]"]?.toString() ?? '';
    _priceToController.text = widget.filters?["price[lte]"]?.toString() ?? '';
    _providedFromController.text =
        widget.filters?["down payment[gte]"]?.toString() ?? '';
    _providedToController.text =
        widget.filters?["down payment[lte]"]?.toString() ?? '';
    _kilometerFromController.text =
        widget.filters?["kilometer[gte]"]?.toString() ?? '';
    _kilometerToController.text =
        widget.filters?["kilometer[lte]"]?.toString() ?? '';
    _descriptionController.text =
        widget.filters?["description"]?.toString() ?? '';
    _innerPartController.text = widget.filters?["inner part"]?.toString() ?? '';
    _doorsController.text =
        widget.filters?["number of doors"]?.toString() ?? '';
    _colorController.text = widget.filters?["color"]?.toString() ?? '';
    _modelController.text = widget.filters?["year"]?.toString() ?? '';
    _versionController.text = widget.filters?["virsion"]?.toString() ?? '';
    _saleorRentController.text =
        widget.filters?["listing status"]?.toString() ?? '';
    _cityController.text = widget.filters?["city"]?.toString() ?? '';
    _currencyController.text = widget.filters?["currency"]?.toString() ?? '';

    if (widget.filters?["additional features"] != null) {
      _selectedAddOns.add(widget.filters?["additional features"]);
    }
    super.initState();
  }

  Map<String, dynamic> search() => {
        if (_selectedBrand.isNotEmpty) "brand": _selectedBrand,
        if (_publishedVia.isNotEmpty) "publishedVia": _publishedVia,
        if (_selectedFuelType.isNotEmpty) "fuel type": _selectedFuelType,
        if (_selectedseats != 0) "number of sets": _selectedseats,
        if (_selectedCarType.isNotEmpty) "type": _selectedCarType,
        if (_selectedTransmission.isNotEmpty)
          "transmission type": _selectedTransmission,
        if (_selectedAddOns.isNotEmpty)
          "additional features": _selectedAddOns.first,
        if (_priceFromController.text.trim().isNotEmpty)
          "price[gte]": num.parse(_priceFromController.text.trim()),
        if (_priceToController.text.trim().isNotEmpty)
          "price[lte]": num.parse(_priceToController.text.trim()),
        if (_kilometerFromController.text.trim().isNotEmpty)
          "kilometer[gte]": num.parse(_kilometerFromController.text.trim()),
        if (_kilometerToController.text.trim().isNotEmpty)
          "kilometer[lte]": num.parse(_kilometerToController.text.trim()),
        if (_descriptionController.text.trim().isNotEmpty)
          "description": _descriptionController.text.trim(),
        if (_innerPartController.text.trim().isNotEmpty)
          "inner part": _innerPartController.text.trim(),
        if (_doorsController.text.trim().isNotEmpty)
          "number of doors": _doorsController.text.trim(),
        if (_colorController.text.trim().isNotEmpty)
          "color": _colorController.text.trim(),
        if (_modelController.text.trim().isNotEmpty)
          "year": _modelController.text.trim(),
        if (_versionController.text.trim().isNotEmpty)
          "version": _versionController.text.trim(),
        if (_cityController.text.trim().isNotEmpty)
          "city": _cityController.text.trim(),
        if (_currencyController.text.trim().isNotEmpty)
          "currency": _currencyController.text.trim(),
        if (_saleorRentController.text.trim().isNotEmpty)
          "listing status": _saleorRentController.text.trim(),
      };

  @override
  void dispose() {
    _priceFromController.dispose();
    _priceToController.dispose();
    _kilometerFromController.dispose();
    _kilometerToController.dispose();
    _descriptionController.dispose();
    _innerPartController.dispose();
    _doorsController.dispose();
    _colorController.dispose();
    _modelController.dispose();
    _versionController.dispose();
    _cityController.dispose();
    _currencyController.dispose();
    _saleorRentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      cacheExtent: 10000,
      children: [
        Text(
          'المحافظة',
          style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: 16,
            fontFamily: 'Noor',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDropdown(
            selectedValue: _selectedCity,
            // label: 'المحافظة',
            // carLogo: ,
            hint: 'اختر المحافظة',
            options: AppConstants.cityLists,
            onChanged: (city) {
              setState(() {
                _selectedCity = city!;
                _cityController.text = city;
              });
            }),
        const SizedBox(
          height: 20,
        ),
        // CustomLabeledDropDownField(
        //   label: 'الماركة',
        //   hint: "اختار ماركة السيارة ...",
        //   items: AppConstants.carBrands,
        //   value: _selectedBrand.isEmpty ? null : _selectedBrand,
        //   onChanged: (brand) {
        //     setState(() {
        //       _selectedBrand = brand!;
        //     });
        //   },
        // ),
        Text(
          'الماركة',
          style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: 16,
            fontFamily: 'Noor',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        CustomDropdown(
            selectedValue: _selectedCity,

            // label: 'المحافظة',
            hint: "اختار ماركة السيارة ...",
            // options: AppConstants.carBrands,
            carOptions: AppConstants.cars,
            onChanged: (brand) {
              setState(() {
                _selectedBrand = brand!;
                // _cityController.text = brand;
              });
            }),
        const SizedBox(
          height: 25,
        ),
        CustomLabeledTextField(
          controller: _versionController,
          validator: (adTitle) {
            if (adTitle!.isEmpty) {
              return 'من فضلك ادخل نسخة السيارة';
            }
            return null;
          },
          label: 'نسخة السيارة',
          hint: "نسخة السيارة",
        ),
        const SizedBox(
          height: 25,
        ),
        CustomLabeledTextField(
          controller: _modelController,
          keyboardType: TextInputType.number,
          validator: (adTitle) {
            if (adTitle!.isEmpty) {
              return 'من فضلك ادخل موديل السيارة';
            }
            return null;
          },
          label: 'موديل السيارة',
          hint: "موديل السيارة",
        ),
        const SizedBox(
          height: 25,
        ),
        CustomLabeledTextField(
          controller: _colorController,
          validator: (adTitle) {
            if (adTitle!.isEmpty) {
              return 'من فضلك ادخل لون السيارة';
            }
            return null;
          },
          label: 'لون السيارة',
          hint: "لون السيارة",
        ),
        const SizedBox(
          height: 25,
        ),
        CustomLabeledTextField(
          controller: _doorsController,
          keyboardType: TextInputType.number,
          validator: (adTitle) {
            if (adTitle!.isEmpty) {
              return 'من فضلك ادخل عدد الابواب';
            }
            return null;
          },
          label: 'عدد الابواب',
          hint: "عدد الابواب",
        ),
        const SizedBox(
          height: 25,
        ),
        CustomLabeledTextField(
          controller: _innerPartController,
          validator: (adTitle) {
            if (adTitle!.isEmpty) {
              return 'من فضلك ادخل الجزء الداخلى';
            }
            return null;
          },
          label: 'الجزء الداخلى',
          hint: "الجزء الداخلى",
        ),
        const SizedBox(
          height: 25,
        ),
        NumbersSection(
          title: 'عدد المقاعد',
          maxNumbers: 7,
          selectedNumber: _selectedseats!,
          onSelect: (room) {
            setState(() {
              _selectedseats = room;
            });
          },
        ),
        const SizedBox(
          height: 25,
        ),
        ChipSection(
          title: 'جديد/مستعمل',
          items: newOrUsedChoices,
          selectedItems: [_selectedCarType],
          onSelect: (choice) {
            setState(() {
              _selectedCarType = choice;
            });
          },
        ),
        const SizedBox(
          height: 25,
        ),
        CheckBoxesSection(
            title: 'تم النشر من قبل ',
            items: isOwner,
            selectedItems: [_publishedVia],
            onChanged: (status) {
              setState(() {
                if (_publishedVia == status) {
                  _publishedVia = '';
                  return;
                }
                _publishedVia = status;
              });
            }),
        const SizedBox(
          height: 25,
        ),
        ChipSection(
          title: 'بيع/ايجار',
          items: saleOrRentChoices,
          selectedItems: [_selectedSaleOrRentvalue],
          onSelect: (choice) {
            setState(() {
              _selectedSaleOrRentvalue = choice;
              _saleorRentController.text = choice;
            });
          },
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          "العملة",
          style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: 16,
            fontFamily: 'Noor',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomDropdown(
            selectedValue: _dollarOrLeraa,
            // label: 'العملة',
            hint: "اختر العملة",
            options: const ['دولار', 'ليره'],
            onChanged: (curruncy) {
              setState(() {
                _dollarOrLeraa = curruncy!;
                _currencyController.text = curruncy;
              });
            }),
        const SizedBox(
          height: 25,
        ),
        Text(
          'السعر',
          style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: 16,
            fontFamily: 'Noor',
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          children: [
            NumberField(
              isExpanded: true,
              controller: _priceFromController,
              title: 'من',
              metric: _dollarOrLeraa == 'دولار' ? "USD" : 'SYP',
            ),
            const SizedBox(
              width: 10,
            ),
            NumberField(
              isExpanded: true,
              controller: _priceToController,
              title: 'إلى',
              metric: _dollarOrLeraa == 'دولار' ? "USD" : 'SYP',
            ),
          ],
        ),
        CustomCheckBox(
          text: "قابل للتفاوض",
          isChecked: isChecked,
          onChanged: (value) {
            setState(() {
              if (isChecked == value) {
                isChecked = true;
                return;
              }
              isChecked = value!;
            });
          },
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'كيلومترات',
          style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: 16,
            fontFamily: 'Noor',
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          children: [
            NumberField(
              isExpanded: true,
              controller: _kilometerFromController,
              title: 'من',
              metric: 'kms',
            ),
            const SizedBox(
              width: 10,
            ),
            NumberField(
              isExpanded: true,
              controller: _kilometerToController,
              title: 'إلى',
              metric: 'kms',
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        CheckBoxesSection(
            title: 'طريقة الدفع',
            items: contactMethods,
            selectedItems: [_selectedContactMethod],
            onChanged: (contactMethod) {
              setState(() {
                if (_selectedContactMethod == contactMethod) {
                  _selectedContactMethod = '';
                  return;
                }
                _selectedContactMethod = contactMethod;
              });
            }),
        const SizedBox(
          height: 25,
        ),
        CheckBoxesSection(
            title: 'إضافات',
            isList: true,
            items: addOns,
            selectedItems: _selectedAddOns.isEmpty ? [] : _selectedAddOns,
            onChanged: (addOn) {
              setState(() {
                if (_selectedAddOns.contains(addOn)) {
                  _selectedAddOns.remove(addOn);
                } else {
                  _selectedAddOns.clear();
                  _selectedAddOns.add(addOn);
                }
              });
            }),
        const SizedBox(
          height: 25,
        ),
        CheckBoxesSection(
            title: 'نوع الوقود',
            isList: true,
            items: fuelTypes,
            selectedItems: [_selectedFuelType],
            onChanged: (fuelType) {
              setState(() {
                if (_selectedFuelType == fuelType) {
                  _selectedFuelType = '';
                  return;
                }
                _selectedFuelType = fuelType;
              });
            }),
        const SizedBox(
          height: 25,
        ),
        CheckBoxesSection(
            title: 'ناقل الحركة',
            isList: true,
            items: transmissions,
            selectedItems: [_selectedTransmission],
            onChanged: (transmission) {
              setState(() {
                if (_selectedTransmission == transmission) {
                  _selectedTransmission = '';
                  return;
                }
                _selectedTransmission = transmission;
              });
            }),
        const SizedBox(
          height: 25,
        ),
        CustomLabeledTextField(
          label: "المزيد من التفاصيل الفنية",
          maxLines: 4,
          hint: "اكتب مزيد من التفاصيل...",
          controller: _descriptionController,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'مقدم',
          style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: 16,
            fontFamily: 'Noor',
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          children: [
            NumberField(
              isExpanded: true,
              controller: _providedFromController,
              title: 'من',
              metric: _dollarOrLeraa == 'دولار' ? "USD" : 'SYP',
            ),
            const SizedBox(
              width: 10,
            ),
            NumberField(
              isExpanded: true,
              controller: _providedToController,
              title: 'إلى',
              metric: _dollarOrLeraa == 'دولار' ? "USD" : 'SYP',
            ),
          ],
        ),
      ],
    );
  }
}
