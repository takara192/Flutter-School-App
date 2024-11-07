import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
//
String? enumToString(dynamic e) {
  if (e == null) {
    return null;
  }
  return e.toString().split('.').last;
}

extension DoubleExtension on num {
  String get removeTrailingZero =>
      toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
}

extension StringsExtension on String {
  String noAccentVietnamese([final bool? enable]) {
    String result = this;
    if (enable == null || !enable) {
      result = result.replaceAll(RegExp('[áàảãạăắằẳẵặâấầẩẫậ]'), 'a');
      result = result.replaceAll(RegExp('[ÁÀẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬ]'), 'A');
      result = result.replaceAll(RegExp('[éèẻẽẹêếềểễệ]'), 'e');
      result = result.replaceAll(RegExp('[ÉÈẺẼẸÊẾỀỂỄỆ]'), 'E');
      result = result.replaceAll(RegExp('[óòỏõọôốồổỗộơớờởỡợ]'), 'o');
      result = result.replaceAll(RegExp('[ÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢ]'), 'O');
      result = result.replaceAll(RegExp('[íìỉĩị]'), 'i');
      result = result.replaceAll(RegExp('[ÍÌỈĨỊ]'), 'I');
      result = result.replaceAll(RegExp('[úùủũụưứừửữự]'), 'u');
      result = result.replaceAll(RegExp('[ÚÙỦŨỤƯỨỪỬỮỰ]'), 'U');
      result = result.replaceAll(RegExp('[ýỳỷỹỵ]'), 'y');
      result = result.replaceAll(RegExp('[ÝỲỶỸỴ]'), 'Y');
      result = result.replaceAll(RegExp('đ'), 'd');
      result = result.replaceAll(RegExp('Đ'), 'D');
    }
    return result;
  }

  T? toEnum<T>(List<T> list) {
    try {
      final T item = list.firstWhere(
        (T e) {
          final String t = e.toString().split('.').last;
          return t == this;
        },
      );
      return item;
    } catch (_) {}
    return null;
  }

  String pageParams([Map<String, dynamic> params = const {}]) {
    var router = this;
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        if (key == params.keys.first) {
          router = '$router?$key=$value';
        } else {
          router = '$router&$key=$value';
        }
      });
    }
    return router;
  }
}

extension Color2StringExtension on Color {
  String get toHexTriplet =>
      (value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase();
}

extension SVGExtension on String {
  String get svg => 'assets/icons/$this.svg';

  SvgPicture svgWidget({Color? color, double? size}) => SvgPicture.asset(
        'assets/icons/$this.svg',
        colorFilter: color != null ? ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ) : null,
        width: size,
        height: size,
      );

  String get riv => 'assets/rive/$this.riv';

  String get lottie => 'assets/lottie/$this.json';

  String get png => 'assets/image/$this.png';
}

extension ColorExtension on String {
  Color get color => isEmpty
      ? Color(int.parse('0xFF34499D'))
      : (substring(0,4)) == '0xff'
          ? Color(int.parse(replaceAll('0xff', '0xFF')))
      : Color(substring(0, 1) != '#'
          ? int.parse('0xFF$this')
          : int.parse(replaceAll('#', '0xFF')));
}

extension FontSizeExtension on String {
  Text get size32 => Text(
        this,
        style: TextStyle(
          fontSize: 32.sp,
          color: '151515'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size30 => Text(
        this,
        style: TextStyle(
          fontSize: 30.sp,
          color: '151515'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size28 => Text(
        this,
        style: TextStyle(
          fontSize: 28.sp,
          color: '151515'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size26 => Text(
        this,
        style: TextStyle(
          fontSize: 26.sp,
          color: '151515'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size24 => Text(
        this,
        style: TextStyle(
          fontSize: 24.sp,
          color: '151515'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size22 => Text(
        this,
        style: TextStyle(
          fontSize: 22.sp,
          color: '151515'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size20 => Text(
        this,
        style: TextStyle(
          fontSize: 20.sp,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size18 => Text(
        this,
        style: TextStyle(
          fontSize: 18.sp,
          color: '151515'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size17 => Text(
        this,
        style: TextStyle(
          fontSize: 17.sp,
          color: '535353'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size16 => Text(
        this,
        style: TextStyle(
          fontSize: 16.sp,
          color: '535353'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size15 => Text(
        this,
        style: TextStyle(
          fontSize: 15.sp,
          color: '535353'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size14 => Text(
        this,
        style: TextStyle(
          fontSize: 14.sp,
          color: '535353'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size13 => Text(
        this,
        style: TextStyle(
          fontSize: 13.sp,
          color: '535353'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size12 => Text(
        this,
        style: TextStyle(
          fontSize: 12.sp,
          color: '535353'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size11 => Text(
        this,
        style: TextStyle(
          fontSize: 11.sp,
          color: '535353'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );

  Text get size10 => Text(
        this,
        style: TextStyle(
          fontSize: 10.sp,
          color: '535353'.color,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      );
}

extension FontWeightExtension on Text {
  Text get w100 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w100),
      );

  Text get w200 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w200),
      );

  Text get w300 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w300),
      );

  Text get w400 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w400),
      );

  Text get w500 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w500),
      );

  Text get w600 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w600),
      );

  Text get w700 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w700),
      );

  Text get w800 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w800),
      );

  Text get w900 => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.w900),
      );

  Text get bold => Text(
        data!,
        style: style?.copyWith(fontWeight: FontWeight.bold),
      );

  Text weight(FontWeight weight) => Text(
    data!,
    style: style?.copyWith(fontWeight: weight),
  );
}

extension TextDecorationExtension on Text {
  Text get lineThrough => Text(
        data!,
        style: style?.copyWith(decoration: TextDecoration.lineThrough),
      );

  Text get overline => Text(
        data!,
        style: style?.copyWith(decoration: TextDecoration.overline),
      );

  Text get underline => Text(
        data!,
        style: style?.copyWith(decoration: TextDecoration.underline),
      );
}

extension TextOverflowExtension on Text {
  Text get clip => Text(
        data!,
        style: style?.copyWith(overflow: TextOverflow.clip),
      );

  Text get ellipsis => Text(
        data!,
        style: style?.copyWith(overflow: TextOverflow.ellipsis),
      );

  Text get fade => Text(
        data!,
        style: style?.copyWith(overflow: TextOverflow.fade),
      );
}

extension TextAlignExtension on Text {
  Text get center => Text(
        data!,
        textAlign: TextAlign.center,
        style: style,
      );

  Text get end => Text(
        data!,
        textAlign: TextAlign.end,
        style: style,
      );

  Text get justify => Text(
        data!,
        textAlign: TextAlign.justify,
        style: style,
      );

  Text get left => Text(
        data!,
        textAlign: TextAlign.left,
        style: style,
      );

  Text get right => Text(
        data!,
        textAlign: TextAlign.right,
        style: style,
      );

  Text get start => Text(
        data!,
        textAlign: TextAlign.start,
        style: style,
      );
}

extension FontColorExtension on Text {
  Text color(final Color color) {
    return Text(
      data!,
      style: style?.copyWith(color: color),
    );
  }

  Text get black {
    return Text(
      data!,
      style: style?.copyWith(color: Colors.black),
    );
  }

  Text get white {
    return Text(
      data!,
      style: style?.copyWith(color: Colors.white),
    );
  }
}

extension HeightStyleExtension on Text {
  Text height(final double height) {
    return Text(
      data!,
      style: style?.copyWith(height: height),
    );
  }
}

extension FontStyleExtension on Text {
  Text get italic => Text(
        data!,
        style: style?.copyWith(fontStyle: FontStyle.italic),
      );

  Text lineHeight(final double height) => Text(
        data!,
        style: style?.copyWith(height: height / 100),
      );
}

extension TextExtension on String {
  Text requiredText({
    final Color? color,
    final double fontSize = 14,
    final FontWeight? fontWeight,
  }) {
    return Text.rich(
      TextSpan(
          text: this,
          style: TextStyle(
            color: color ?? '535353'.color,
            fontSize: fontSize.sp,
            fontWeight: fontWeight,
          ),
          children: [
            TextSpan(
              text: '*',
              style: TextStyle(
                color: Colors.red,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            )
          ]),
    );
  }
}
