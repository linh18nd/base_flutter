import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScreenUtilExtension on num {
  double get w => ScreenUtil().setWidth(this);

  double get h => ScreenUtil().setHeight(this);

  double get sp => ScreenUtil().setSp(this);

  double get r => ScreenUtil().radius(this);

  double get sw => ScreenUtil().screenWidth * (this / 100);

  double get sh => ScreenUtil().screenHeight * (this / 100);
}



