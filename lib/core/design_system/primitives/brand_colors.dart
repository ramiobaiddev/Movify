// Raw palette. Mirrors the Figma "brand" collection. Widgets must not use this;
// reference semantic tokens (AppColors) instead.
import 'dart:ui' show Color;

abstract final class BrandColors {
  static const Color blue50 = Color(0xFFE6EFFF); // blue/50
  static const Color blue100 = Color(0xFFCCDDFF); // blue/100
  static const Color blue200 = Color(0xFF9ABBFF); // blue/200
  static const Color blue300 = Color(0xFF679AFF); // blue/300
  static const Color blue400 = Color(0xFF3478FF); // blue/400
  static const Color blue500 = Color(0xFF0156FF); // blue/500
  static const Color blue550 = Color(0xFF2F5BEA); // blue/550
  static const Color blue600 = Color(0xFF0145CC); // blue/600
  static const Color blue700 = Color(0xFF013499); // blue/700
  static const Color blue800 = Color(0xFF012266); // blue/800
  static const Color blue900 = Color(0xFF001133); // blue/900
  static const Color blue950 = Color(0xFF14151A); // blue/950
  static const Color blueTint = Color(0xFF101A36); // blue/tint
  static const Color neutral0 = Color(0xFFFFFFFF); // neutral/0
  static const Color neutral100 = Color(0xFFF9FAFC); // neutral/100
  static const Color neutral200 = Color(0xFFF4F4F8); // neutral/200
  static const Color neutral300 = Color(0xFFE3E4EB); // neutral/300
  static const Color neutral400 = Color(0xFFCACBD4); // neutral/400
  static const Color neutral500 = Color(0xFFA8A9B2); // neutral/500
  static const Color neutral600 = Color(0xFF717188); // neutral/600
  static const Color neutral650 = Color(0xFF57576C); // neutral/650
  static const Color neutral700 = Color(0xFF323241); // neutral/700
  static const Color neutral750 = Color(0xFF1E2029); // neutral/750
  static const Color neutral800 = Color(0xFF000000); // neutral/800
  static const Color green200 = Color(0xFF37FF57); // green/200
  static const Color green300 = Color(0xFF29E682); // green/300
  static const Color green400 = Color(0xFF02BFB0); // green/400
  static const Color green500 = Color(0xFF279E82); // green/500
  static const Color red500 = Color(0xFFFF2B01); // red/500
  static const Color amber500 = Color(0xFFF5C451); // amber/500
  static const Color amber700 = Color(0xFF8A6100); // amber/700
  static const Color orange500 = Color(0xFFF7971E); // orange/500

  // From the remote library (orange scale); used by button accent tokens.
  static const Color orangeDefault = Color(0xFFFFAA01); // orange/default
  static const Color orange300 = Color(0xFFFFCC67); // orange/300
  static const Color orange400 = Color(0xFFFFBB34); // orange/400
  static const Color orange600 = Color(0xFFCC8801); // orange/600
  static const Color orange700 = Color(0xFF996601); // orange/700
  static const Color orange800 = Color(0xFF664401); // orange/800
}
