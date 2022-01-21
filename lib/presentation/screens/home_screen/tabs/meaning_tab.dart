import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pali_dictionary/logic/bloc/navigater_bloc/navigater_bloc.dart';
import 'package:pali_dictionary/logic/cubit/dictionary_cubit/dictionary_cubit.dart';
import 'package:pali_dictionary/logic/cubit/search_box_cubit/search_box_cubit.dart';
import 'package:pali_dictionary/presentation/globle_widgets/app_text_input.dart';
import 'package:pali_dictionary/presentation/screens/home_screen/widgets/meaning_card.dart';
import 'package:sizer/sizer.dart';

import 'package:pali_dictionary/data/models/word_model.dart';

class MeaningTab extends StatefulWidget {
  const MeaningTab({
    Key? key,
  }) : super(key: key);

  @override
  State<MeaningTab> createState() => _MeaningTabState();
}

class _MeaningTabState extends State<MeaningTab> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.addListener(() {
      final String searchText = controller.text;
      if (searchText.isNotEmpty) {
        BlocProvider.of<SearchBoxCubit>(context).showCloseBtn();
      }
      if (searchText.isEmpty) {
        BlocProvider.of<SearchBoxCubit>(context).showSearchBtn();
      }
      BlocProvider.of<DictionaryCubit>(context).searchWord(
        isSanskrit: false,
        searchText: searchText,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DictionaryCubit>(context).getAllWords(isSanskrit: false);
    return Column(
      children: [
        Container(
          color: Colors.green.shade600,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: "SANSKRIT SINHALA DICTIONARY",
                    applicationVersion: "Version 1.0",
                    applicationLegalese: "wimalabuddhiing@gmail.com",
                    applicationIcon: Image.asset(
                      "assets/statue.png",
                      width: 20.w,
                      height: 20.w,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                child: Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 22.sp,
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Expanded(
                child: AppTextInput(
                  controller: controller,
                  bgColor: Colors.black.withOpacity(0.2),
                  textColor: Colors.white,
                  hintText: "සොයන්න...",
                  onChanged: (searchText) {},
                  isPassword: false,
                  textInputAction: TextInputAction.search,
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              BlocBuilder<SearchBoxCubit, SearchBoxState>(
                builder: (context, state) {
                  if (state is SearchBoxSearch) {
                    return Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 22.sp,
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        controller.clear();
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Container(
          width: 100.w,
          height: 0.1.h,
          color: Colors.black38,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 1.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<NavigaterBloc>(context)
                            .add(NavigateToPaliTab());
                      },
                      child: Text(
                        "සංස්කෘත",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 0.3.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "සිංහල",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 0.5.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.25.h),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<DictionaryCubit, DictionaryState>(
                    listener: (context, state) {
                      if (state is DictionaryFailed) {
                        SnackBar snackBar =
                            SnackBar(content: Text(state.errorMsg));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    builder: (context, state) {
                      if (state is DictionaryLoaded) {
                        List<WordModel> wordModels = state.wordModels;
                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            ListView.builder(
                              itemCount: wordModels.length,
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                WordModel wordModel = wordModels[index];
                                return MeaningCard(wordModel: wordModel);
                              },
                            ),
                          ],
                        );
                      } else if (state is DictionaryLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
