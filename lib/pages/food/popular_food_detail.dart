import 'package:bcommerce/controllers/cart_controller.dart';
import 'package:bcommerce/controllers/popular_product_controller.dart';
import 'package:bcommerce/pages/home/main_food_page.dart';
import 'package:bcommerce/utils/app_constants.dart';
import 'package:bcommerce/utils/colors.dart';
import 'package:bcommerce/utils/dimentions.dart';
import 'package:bcommerce/utils/dimentions.dart';
import 'package:bcommerce/widgets/app_colum.dart';
import 'package:bcommerce/widgets/app_icon.dart';
import 'package:bcommerce/widgets/big_text.dart';
import 'package:bcommerce/widgets/expandable_text.dart';
import 'package:bcommerce/widgets/icon_and_text.dart';
import 'package:bcommerce/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimentions.popularFoodImgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          product.img!))),
            ),
          ),
          Positioned(
            top: Dimentions.height45,
            left: Dimentions.width20,
            right: Dimentions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (() {
                      Get.to(() => MainFoodPage());
                    }),
                    child: AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
                              ),
                            )
                          : Container(),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              top: 3,
                              right: 6,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ),
                            )
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimentions.popularFoodImgSize - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimentions.width20,
                      right: Dimentions.width20,
                      top: Dimentions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimentions.radious20),
                      topRight: Radius.circular(Dimentions.radious20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      BigText(text: "Introduction"),
                      SizedBox(
                        height: Dimentions.height20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableText(text: product.description!),
                        ),
                      ),
                    ],
                  )))
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularproduct) {
        return Container(
          height: Dimentions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimentions.height30,
              left: Dimentions.width20,
              right: Dimentions.width20,
              bottom: Dimentions.height30),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimentions.radious30),
                topRight: Radius.circular(Dimentions.radious30),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(Dimentions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimentions.radious20),
                    color: Colors.white),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularproduct.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimentions.width10 / 2,
                    ),
                    BigText(text: popularproduct.inCartItem.toString()),
                    SizedBox(
                      width: Dimentions.width10 / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        popularproduct.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(Dimentions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimentions.radious20),
                    color: AppColors.mainColor),
                child: GestureDetector(
                  onTap: (() {
                    popularproduct.addItem(product);
                  }),
                  child: BigText(
                    text: "\$${product.price!}|Add to Cart",
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
