import 'package:flutter/material.dart';
import 'package:pali_dictionary/data/models/word_model.dart';
import 'package:sizer/sizer.dart';


class DictItemCard extends StatelessWidget {
  final WordModel wordModel;
  const DictItemCard({
    Key? key,
    required this.wordModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w,
          decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), offset: Offset(0.2.w,0.2.w), blurRadius: 2)], borderRadius: BorderRadius.circular(2.w)),

          child: Container(
            padding: EdgeInsets.all(5.w),
            color: Colors.lime.withOpacity(0.1),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(wordModel.pali,style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 14.sp, fontWeight: FontWeight.bold),)),
                SizedBox(height: 1.4.h,),
                Container(width: 100.w,height: 0.1.h, color: Colors.black.withOpacity(0.3),),
                SizedBox(height: 1.4.h,),
                Padding(

                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(wordModel.meaning,style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 12.sp, fontWeight: FontWeight.w600), )),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        )
      ],
    );
  }
}
