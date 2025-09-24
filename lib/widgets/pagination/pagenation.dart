import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/core/core_ui.dart';
import 'package:task_manager/widgets/common_fucntion/common_function.dart';
import 'package:task_manager/widgets/pagination/buttons.dart';

class Pagination extends StatelessWidget {
  Pagination({
    super.key,
    required this.onTapNxtBtn,
    required this.onTapPrvBtn,
    required this.currentPage,
    required this.isShowRowperpage,
    required this.shouldShowDecoration,
    // required this.theme,
    this.dropDownValue,
    this.dropOnChanged,
    this.isLoadingNxtPage = false,
    this.isLoadingPrvPage = false,
    this.isShowTotalCount = false,
    this.totalIteamCount = 0,
    this.onPageJump,
    this.isjumpPage = false,
  });

  final Function() onTapNxtBtn;
  final Function() onTapPrvBtn;
  Function(String)? onPageJump;
  final int currentPage;
  final bool isShowRowperpage;
  final bool shouldShowDecoration;

  final int? dropDownValue;
  final Function(dynamic)? dropOnChanged;
  final bool isLoadingNxtPage;
  final bool isLoadingPrvPage;
  final bool isShowTotalCount;
  final int totalIteamCount;
  final bool isjumpPage;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 10, left: 5, right: 5),
        width: double.maxFinite,
        decoration: shouldShowDecoration
            ? BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)))
            : null,
        child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              isShowTotalCount
                  ? Padding(
                      padding: const EdgeInsets.only(left: 3, bottom: 5),
                      child: Text(
                          (currentPage * dropDownValue!) > totalIteamCount
                              ? "${((currentPage - 1) * dropDownValue!) + 1} -$totalIteamCount of $totalIteamCount"
                              : "${((currentPage - 1) * dropDownValue!) + 1} - ${currentPage * dropDownValue!} of $totalIteamCount",
                          style: InnerPageStyles().pagenationStyle),
                    )
                  : const SizedBox(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Tooltip(
                      message: "Previous Page",
                      child: CustomButton(
                        onTap: () {},
                        text: "",
                        color: Colors.white30,
                        leadingImage: Icon(Icons.arrow_back),
                      )),
                  isjumpPage
                      ? Tooltip(
                          message: "Go To Page",
                          child: Container(
                            margin: const EdgeInsets.only(left: 11, right: 11),
                            height: 30, // Keep the same height as the button
                            width: 50,
                            child: TextField(
                              controller: TextEditingController(
                                  text: currentPage.toString()),
                              keyboardType: TextInputType
                                  .number, // Ensure only numbers are entered
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Allow only digits (0-9)
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'^[1-9]\d*$')), // Must be 1 or greater
                              ],
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled:
                                    true, // Required to apply the fill color
                                fillColor: Colors.white30, // White background
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      color: Color(0xffC9C9C9), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      color: Color(0xffC9C9C9), width: 1.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      color: Color(0xffC9C9C9), width: 1.5),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5),
                              ),
                              // style: const TextStyle(),
                              onSubmitted: onPageJump,
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(left: 11, right: 11),
                          child: Container()
                          //  CustomButtonFromJson(
                          //   onTap: () {},
                          //   text: currentPage.toString(),
                          //   height: 30, // Keep the same height as the button
                          //   width: 50,
                          //   style: theme.uiConfig!.paginationPrvBtn,
                          // ),
                          ),
                  Tooltip(
                      message: "Next Page",
                      child: CustomButton(
                        onTap: () {},
                        text: "",
                        color: Colors.white30,
                        leadingImage: Icon(Icons.arrow_forward),
                      )
                      //    CustomButtonFromJson(
                      //       isShowBorder: true,
                      //       trailingImage: isLoadingNxtPage
                      //           ? null
                      //           : SvgWidget(
                      //               size: 10,
                      //               isCode: true,
                      //               url: SvgImages.pagenationRight,
                      //               color: theme.parseColor(
                      //                   theme.uiConfig!.paginationNxtBtn.color),
                      //             ),
                      //       style: theme.uiConfig!.paginationNxtBtn,
                      //       isLoading: isLoadingNxtPage,
                      //       onTap: onTapNxtBtn,
                      //       text: "",
                      //       height: 30,
                      //       loaderSize: 10,
                      //       width: 48),
                      ),
                ],
              ),
              isShowRowperpage
                  ? RowPerCout(
                      dropDownValue: dropDownValue!,
                      drpDnTextStyel: TextStyle(),
                      labelStyle: TextStyle(),
                      // labelStyle: theme.textStyleFromJson(
                      //   theme.uiConfig!.dataGrideRow,
                      // ),
                      // dropDownValue: dropDownValue!,
                      // drpDnTextStyel: theme.textStyleFromJson(
                      //   theme.uiConfig!.textfieldLabel,
                      // ),
                      onChanged: dropOnChanged,
                    )
                  : const SizedBox(width: 0),
            ]));
  }
}

class RowPerCout extends StatelessWidget {
  final TextStyle labelStyle;
  final int dropDownValue;
  final TextStyle drpDnTextStyel;
  final Function(dynamic)? onChanged;
  bool? isfordashboard = false;

  RowPerCout({
    super.key,
    required this.labelStyle,
    required this.dropDownValue,
    required this.drpDnTextStyel,
    required this.onChanged,
    this.isfordashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isfordashboard == true
              ? Text("")
              : Text('Row per page', style: labelStyle),
          const SizedBox(width: 15),
          Container(
            height: 30,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                    color: Color(0xff9c9c9c29),
                    spreadRadius: 0.5,
                    blurRadius: 0.5,
                    offset: Offset(0, 0.5))
              ],
            ),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isDense: true,
                  iconSize: 15,
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color(0xFF555555)),
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  value: dropDownValue,
                  onChanged: onChanged,
                  items: CommonFunction.rowPerPageList
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          value.toString(),
                          style: drpDnTextStyel,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
