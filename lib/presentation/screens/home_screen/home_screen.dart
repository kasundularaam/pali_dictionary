import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pali_dictionary/logic/bloc/navigater_bloc/navigater_bloc.dart';
import 'package:pali_dictionary/logic/cubit/dictionary_cubit/dictionary_cubit.dart';
import 'package:pali_dictionary/logic/cubit/search_box_cubit/search_box_cubit.dart';
import 'package:pali_dictionary/presentation/screens/home_screen/tabs/meaning_tab.dart';
import 'package:pali_dictionary/presentation/screens/home_screen/tabs/pali_tab.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSanskrit = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade500,
      body: SafeArea(
        child: BlocBuilder<NavigaterBloc, NavigaterState>(
          builder: (context, state) {
            if (state is NavigaterMeaningTab) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => DictionaryCubit(),
                  ),
                  BlocProvider(
                    create: (context) => SearchBoxCubit(),
                  ),
                ],
                child: const MeaningTab(),
              );
            } else {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => DictionaryCubit(),
                  ),
                  BlocProvider(
                    create: (context) => SearchBoxCubit(),
                  ),
                ],
                child: const PaliTab(),
              );
            }
          },
        ),
      ),
    );
  }
}
