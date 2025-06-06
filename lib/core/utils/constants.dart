import 'package:albazar_app/core/utils/icons.dart';
import 'package:albazar_app/core/widgets/custom_drob_down.dart';

class AppConstants {
  const AppConstants._();

  static List<String> cityLists = [
    'دمشق',
    ' ريف دمشق',
    'القنيطرة',
    'درعا',
    'السويداء',
    'حمص',
    'طرطوس',
    'اللاذقية',
    'حماة',
    'إدلب',
    'حلب',
    'الرقة',
    'دير الزور',
    'الحسكة',
  ];
  
  static const List<String> carBrands = [
    "أوبل",
    "أودى",
    "ألتيما",
    "أنفينيتى",
    "أيسوزو",
    "أولدزموبيل",
    "أوستن مارتن",
    "ألفا روميو",
    "أسيا",
    "إم جى",
    "بايك",
    "باربوس",
    "بريليانس",
    "برودوا",
    "بروتون",
    "بلايموث",
    "بنتلى",
    "بوغاتى",
    "بويك",
    "بي إم دبليو",
    "بيجو",
    "بى واى دى",
    "تاتا",
    "تاترا",
    "تويوتا",
    "جاك",
    "جاكوار",
    "ج ام سى",
    "جينيسيس",
    "جينبى",
    "جيب",
    "جوندا",
    "جيلى",
    "جى أم سى",
    "حميشو",
    "دايو",
    "دايهاتسو",
    "داتسون",
    "داسيا",
    "دوماى",
    "دودج",
    "دونغ فينج",
    "دى إف إم",
    "رانج روفر",
    "روفر",
    "روفى",
    "رولز رايس",
    "رينو",
    "رينو سامسونج",
    "زوتاي",
    "زاز",
    "زد اكس",
    "سامسونج",
    "سايبا",
    "سانج يونج",
    "سبرينتر",
    "سيتروين",
    "سيا",
    "سيت",
    "سيات",
    "سيريس",
    "سوزوكي",
    "سوبارو",
    "سكودا",
    "سمارت",
    "سما",
    "ساب",
    "شاهين",
    "شاحنة صغيرة",
    "شانا",
    "شانجان",
    "شانغ فينغ",
    "شانجى",
    "شام",
    "شيرى",
    "شيفروليه",
    "صنى",
    "طوكيو",
    "فاو",
    "فورد",
    "فوكس فاكن",
    "فولفو",
    "فيرارى",
    "فيات",
    "فينغ",
    "كاديلاك",
    "كاما",
    "كرايسلر",
    "كيا",
    "لادا",
    "لابمرغينى",
    "لانسيا",
    "لاندروفر",
    "لاندويند",
    "لكزس",
    "ليونسيل",
    "ليفان",
    "لينكولن",
    "لوتوس",
    "ماروتى",
    "مازاراتى",
    "مازدا",
    "ماي باخ",
    "ميتسوبيشى",
    "ميركورى",
    "مينى كوبر",
    "نيسان",
    "هافال",
    "هايما",
    "هافى ميني",
    "هامر",
    "هوندا",
    "هيونداى"
  ];
  static List<CarModel> cars = [
    CarModel(name: 'أوبل', image: CarsLogo.opel),
    CarModel(name: 'أودى', image: CarsLogo.audit),
    CarModel(name: 'أنفينيتى', image: CarsLogo.infiniti),
    CarModel(name: 'أيسوزو', image: CarsLogo.isuzu),
    CarModel(name: 'أولدزموبيل', image: CarsLogo.oldsmobile),
    CarModel(name: 'أوستن مارتن', image: CarsLogo.astonmartin),
    CarModel(name: 'ألفا روميو', image: CarsLogo.alfaRomeo),
    CarModel(name: 'أسيا', image: CarsLogo.asia),
    CarModel(name: 'إم جى', image: CarsLogo.mg),
    CarModel(name: 'بايك', image: CarsLogo.baic),
    CarModel(name: 'بريليانس', image: CarsLogo.brilliance),
    CarModel(name: 'برودوا', image: CarsLogo.perodua),
    CarModel(name: 'بروتون', image: CarsLogo.bertone),
    CarModel(name: 'بلايموث', image: CarsLogo.plymouth),
    CarModel(name: 'بنتلى', image: CarsLogo.bentley),
    CarModel(name: 'بوغاتى', image: CarsLogo.bugatti),
    CarModel(name: 'بويك', image: CarsLogo.bac),
    CarModel(name: 'بي إم دبليو', image: CarsLogo.bmw),
    CarModel(name: 'بيجو', image: CarsLogo.peugeot),
    CarModel(name: 'بى واى دى', image: CarsLogo.byd),
    CarModel(name: 'تاتا', image: CarsLogo.tata),
    CarModel(name: 'تاترا', image: CarsLogo.tatra),
    CarModel(name: 'تويوتا', image: CarsLogo.toyota),
    CarModel(name: 'جاك', image: CarsLogo.jacMotors),
    CarModel(name: 'جاكوار', image: CarsLogo.jaguar),
    CarModel(name: 'جينيسيس', image: CarsLogo.genesis),
    CarModel(name: 'جينبى', image: CarsLogo.ginetta),
    CarModel(name: 'جيب', image: CarsLogo.jeep),
    CarModel(name: 'جيلى', image: CarsLogo.geely),
    CarModel(name: 'جى أم سى', image: CarsLogo.gmc),
    CarModel(name: 'دايو', image: CarsLogo.daewoo),
    CarModel(name: 'دايهاتسو', image: CarsLogo.daihatsu),
    CarModel(name: 'داتسون', image: CarsLogo.datsun),
    CarModel(name: 'داسيا', image: CarsLogo.dacia),
    CarModel(name: 'دودج', image: CarsLogo.dodge),
    CarModel(name: 'دونغ فينج', image: CarsLogo.dongfeng),
    CarModel(name: 'لاند روفر', image: CarsLogo.landRover),
    CarModel(name: 'روفى', image: CarsLogo.ruf),
    CarModel(name: 'رولز رايس', image: CarsLogo.rolls),
    CarModel(name: 'رينو', image: CarsLogo.renault),
    CarModel(name: 'رينو سامسونج', image: CarsLogo.samsung),
    CarModel(name: 'زوتاي', image: CarsLogo.zotye),
    CarModel(name: 'زاز', image: CarsLogo.zaz),
    CarModel(name: 'سايبا', image: CarsLogo.saipa),
    CarModel(name: 'سانج يونج', image: CarsLogo.suangYong),
    CarModel(name: 'سيتروين', image: CarsLogo.citroen),
    CarModel(name: 'سيات', image: CarsLogo.seat),
    CarModel(name: 'سوزوكي', image: CarsLogo.suzuki),
    CarModel(name: 'سوبرا', image: CarsLogo.subaru),
    CarModel(name: 'سكودا', image: CarsLogo.skoda),
    CarModel(name: 'سمارت', image: CarsLogo.smart),
    CarModel(name: 'ساب', image: CarsLogo.saab),
    CarModel(name: 'شانجان', image: CarsLogo.changan),
    CarModel(name: 'شانغ فينغ', image: CarsLogo.changfeng),
    CarModel(name: 'شيرى', image: CarsLogo.chery),
    CarModel(name: 'شيفروليه', image: CarsLogo.chevrolet),
    CarModel(name: 'نيسان', image: CarsLogo.nissan),
    CarModel(name: 'فاو', image: CarsLogo.faw),
    CarModel(name: 'فورد', image: CarsLogo.ford),
    CarModel(name: 'فولفو', image: CarsLogo.volvo),
    CarModel(name: 'فيرارى', image: CarsLogo.ferrari),
    CarModel(name: 'فيات', image: CarsLogo.fiat),
    CarModel(name: 'كاما', image: CarsLogo.camco),
    CarModel(name: 'كيا', image: CarsLogo.kia),
    CarModel(name: 'لادا', image: CarsLogo.lada),
    CarModel(name: 'لابمرغينى', image: CarsLogo.lamborghini),
    CarModel(name: 'لانسيا', image: CarsLogo.lancia),
    CarModel(name: 'لاندويند', image: CarsLogo.landwind),
    CarModel(name: 'لكزس', image: CarsLogo.lexus),
    CarModel(name: 'لوتوس', image: CarsLogo.lotus),
    CarModel(name: 'مازاراتى', image: CarsLogo.maserati),
    CarModel(name: 'مازدا', image: CarsLogo.mazda),
    CarModel(name: 'ماي باخ', image: CarsLogo.maybach),
    CarModel(name: 'ميتسوبيشى', image: CarsLogo.mitsubishi),
    CarModel(name: 'ميركورى', image: CarsLogo.mercury),
    CarModel(name: 'مينى كوبر', image: CarsLogo.mini),
    CarModel(name: 'هافال', image: CarsLogo.haval),
    CarModel(name: 'هايما', image: CarsLogo.haima),
    CarModel(name: 'هامر', image: CarsLogo.hummer),
    CarModel(name: 'هوندا', image: CarsLogo.honda),
    CarModel(name: 'هيونداى', image: CarsLogo.hyundai),
  ];
}
