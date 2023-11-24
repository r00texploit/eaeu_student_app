import 'package:student/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:student/ui/widgets/svgButton.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function? onPressBackButton;
  final String? subTitle;
  final bool? showBackButton;
  const CustomAppBar({
    Key? key,
    this.onPressBackButton,
    required this.title,
    this.subTitle,
    this.showBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTopBackgroundContainer(
      padding: EdgeInsets.zero,
      heightPercentage: UiUtils.appBarSmallerHeightPercentage,
      child: LayoutBuilder(
        builder: (context, boxConstraints) {
          return Stack(
            children: [
              (showBackButton ?? true)
                  ? Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: UiUtils.screenContentHorizontalPadding,
                        ),
                        child: SvgButton(
                          onTap: () {
                            if (onPressBackButton != null) {
                              onPressBackButton!.call();
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          svgIconUrl: UiUtils.getBackButtonPath(context),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Align(
                child: Container(
                  alignment: Alignment.center,
                  width: boxConstraints.maxWidth * (0.6),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: UiUtils.screenTitleFontSize,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
              Align(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: boxConstraints.maxHeight * (0.28) +
                        UiUtils.screenTitleFontSize,
                  ),
                  child: Text(
                    subTitle ?? "",
                    style: TextStyle(
                      fontSize: UiUtils.screenSubTitleFontSize,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
