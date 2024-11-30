import 'package:flutter/material.dart';
import 'package:tasky/core/text_styles.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: TooltipShape(),
      color: Colors.white,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'edit',
            padding: EdgeInsets.zero, // إزالة البادينج الافتراضي
            height: 30, // تحديد الارتفاع مثل التصميم
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 20.5, bottom: 12.5),
              child: Text(
                'Edit',
                style: Styles.styleMedium16(context).copyWith(
                  color: const Color(0xff00060D),
                  height: 0.09,
                ),
              ),
            ),
          ),
          const PopupMenuItem(
              height: 0,
              padding: EdgeInsets.zero,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  thickness: .4,
                ),
              )),
          PopupMenuItem<String>(
            value: 'delete',
            padding: EdgeInsets.zero, // إزالة البادينج الافتراضي
            height: 30, // تحديد الارتفاع مثل التصميم
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 12.5, bottom: 20.5),
              child: Text(
                'Delete',
                textAlign: TextAlign.center, // محاذاة النص في المنتصف
                style: Styles.styleMedium16(context).copyWith(
                  color: const Color(0xFFFF7D53),
                  height: 0.09,
                ),
              ),
            ),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert), iconSize: 24,
      elevation: 8, padding: EdgeInsets.zero,
      offset: const Offset(-8, 48), // المسافة بين الأيقونة والقائمة
    );
  }
}

class TooltipShape extends ShapeBorder {
  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    const double arrowWidth = 16; // عرض السهم
    const double arrowHeight = 12; // ارتفاع السهم
    const double radius = 12; // نصف قطر الزوايا

    final Path path = Path();

    // السهم في الزاوية اليمنى العلوية
    path.moveTo(rect.right - radius - arrowWidth / 2, rect.top); // بداية السهم
    path.lineTo(rect.right - radius, rect.top - arrowHeight); // رأس السهم
    path.lineTo(rect.right - radius + arrowWidth / 2, rect.top); // نهاية السهم

    // الزاوية العلوية اليمنى
    path.lineTo(rect.right - radius, rect.top);
    path.arcToPoint(Offset(rect.right, rect.top + radius),
        radius: const Radius.circular(radius));

    // الجانب الأيمن
    path.lineTo(rect.right, rect.bottom - radius);
    path.arcToPoint(Offset(rect.right - radius, rect.bottom),
        radius: const Radius.circular(radius));

    // الزاوية السفلية اليسرى
    path.lineTo(rect.left + radius, rect.bottom);
    path.arcToPoint(Offset(rect.left, rect.bottom - radius),
        radius: const Radius.circular(radius));

    // الجانب الأيسر
    path.lineTo(rect.left, rect.top + radius);
    path.arcToPoint(Offset(rect.left + radius, rect.top),
        radius: const Radius.circular(radius));

    // الزاوية العلوية اليسرى
    path.lineTo(rect.right - radius - arrowWidth / 2, rect.top);

    path.close();
    return path;
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
