import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_le_app/components/ui/button.dart';
import 'package:tcc_le_app/components/ui/icon_button.dart';
import 'package:tcc_le_app/core/styles/styles.dart';
import 'package:tcc_le_app/pages/chat/controllers/chat_controller.dart';

class InputMessage extends StatelessWidget {
  InputMessage({super.key});

  final ChatController _controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(CustomSpacing.xs),
      decoration: BoxDecoration(
        color: CustomColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(CustomBorders.radiusMD),
          topRight: Radius.circular(CustomBorders.radiusMD),
        ),
        boxShadow: [
          BoxShadow(
            color: CustomColors.shadow,
            blurRadius: CustomShadow.blurSM,
            spreadRadius: CustomShadow.spreadRadiusSM,
            offset: Offset(CustomShadow.offsetXNone, -CustomShadow.offsetYSM),
          ),
        ],
      ),
      child: Row(
        children: [
          InputField(
            hintText: "Type message",
            controller: _controller.textController,
          ),
          Obx(
            () => CustomIconButton(
              onPressed: () {
                _controller.sendMessage();
              },
              enable: _controller.isButtonEnabled.value,
              variant: ButtonVariant.secondary,
              padding: EdgeInsets.all(CustomSpacing.xs),
              child: Icon(Icons.send_rounded, size: CustomFonts.xxl),
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final Function? validator;
  const InputField({
    super.key,
    this.hintText = "",
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: CustomSpacing.xxs),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomBorders.radiusMD),
          color: CustomColors.neutralLightest,
        ),

        child: TextFormField(
          controller: controller,
          minLines: 1,
          maxLines: 3,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          onFieldSubmitted: (value) {
            if (onFieldSubmitted != null) {
              onFieldSubmitted!(value);
            }
          },
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            }
            return value;
          },
          style: CustomTextStyles.input,

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: CustomTextStyles.inputHint,

            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(CustomBorders.radiusMD),
            ),
          ),
        ),
      ),
    );
  }
}
