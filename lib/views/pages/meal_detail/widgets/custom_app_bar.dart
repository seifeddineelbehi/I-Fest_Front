import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/utils/size_config.dart';

class CustomAppBar extends StatelessWidget {
  final Function? leftCallBack;
  final Function rightCallBack;
  final String imageUrl;

  const CustomAppBar({
    Key? key,
    required this.leftCallBack,
    required this.rightCallBack,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.safeBlockVertical * 40,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: leftCallBack != null ? () => leftCallBack!() : null,
                  child: Container(
                    height: SizeConfig.kDefaultSize * 15,
                    width: SizeConfig.kDefaultSize * 15,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6F7B88),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.kDefaultSize * 2),
                      child: SvgPicture.asset(
                        "assets/svgs/left_arrow.svg",
                      ),
                    ),
                  ),
                ),
                // Container(
                //   height: SizeConfig.kDefaultSize * 15,
                //   width: SizeConfig.kDefaultSize * 15,
                //   padding: const EdgeInsets.all(8),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(80),
                //     color: const Color(0xFF6F7B88),
                //   ),
                //   child: GestureDetector(
                //     onTap: () => rightCallBack(),
                //     child: Padding(
                //       padding: EdgeInsets.all(SizeConfig.kDefaultSize * 2),
                //       child: SvgPicture.asset(
                //         "assets/svgs/heart.svg",
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
