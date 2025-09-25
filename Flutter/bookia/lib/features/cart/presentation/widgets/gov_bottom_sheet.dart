import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/cart/data/source/governorates_list.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';

Future<dynamic> showGovList(BuildContext context, CartCubit cubit) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return GovBottomSheet(cubit: cubit);
    },
  );
}

class GovBottomSheet extends StatelessWidget {
  const GovBottomSheet({super.key, required this.cubit});
  final CartCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Select Governorate', style: TextStyles.getSize18()),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                var governorate = governorateList[index];
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(governorate.governorateNameEn),
                  onTap: () {
                    cubit.governorateController.text =
                        governorate.governorateNameEn;
                    cubit.selectedGovernorateId = governorate.id;
                    Navigator.pop(context);
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(color: AppColors.borderColor),
              itemCount: governorateList.length,
            ),
          ),
        ],
      ),
    );
  }
}
