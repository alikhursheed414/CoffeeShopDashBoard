import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'my_spacing.dart';
import 'my_text.dart';

class MyTextField extends StatefulWidget {
  final String text;
  final String? errorText;
  final String hintText;
  final String? helperText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final FormFieldValidator<String>? onSubmit;
  final void Function()? onTap;
  final bool? isPassword;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<String>? autoFillHint;
  final int? maxLines;
  final int? min;
  final int? max;
  final int? maxLength;
  final bool? isMinOrMaxField;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final bool isPercentageField;
  final EdgeInsets? contentPadding;

  const MyTextField({
    super.key,
    required this.text,
     this.errorText,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.onSubmit,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.autoFillHint,
    this.maxLines,
    this.min,
    this.max,
    this.maxLength,
    this.isMinOrMaxField,
    this.helperText,
    this.maxLengthEnforcement,
    this.isPercentageField = false,
    this.contentPadding
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
   RxBool isObscure= false.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isPassword == true){
      isObscure.value = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyLarge(
            fontWeight: 700,
            fontSize: 14,
           widget.text,
          ),
          MySpacing.height(5),
          Obx(()=>SizedBox(
            child: TextFormField(
              maxLines: isObscure.value ? 1 : widget.maxLines,
              maxLength: widget.maxLength,
              maxLengthEnforcement: widget.maxLengthEnforcement ?? MaxLengthEnforcement.none,
              cursorColor: Colors.black38,
              autofillHints: widget.autoFillHint,
              onTap: widget.onTap,
              readOnly:widget.readOnly ?? false,
              keyboardType: widget.keyboardType,
              inputFormatters:
              widget.isMinOrMaxField == true ? [
                FilteringTextInputFormatter.digitsOnly,
                _MaxValueInputFormatter(widget.max ?? 0),_MinValueInputFormatter(widget.min ?? 0),_MaximumValueInputFormatter(widget.max ?? 0),_NoLeadingZeroInputFormatter() ] :
              widget.keyboardType == TextInputType.number
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : (widget.keyboardType == const TextInputType.numberWithOptions(decimal: true)
                  ? [
                FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
                // FilteringTextInputFormatter.digitsOnly,
              ]
                  : []),
              controller: widget.controller,
              validator:widget.validator,
              onFieldSubmitted: widget.onSubmit,
              obscureText: isObscure.value,
              obscuringCharacter: '*',
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                // counterText: "500",
                // helperText: widget.helperText,
                helper: MyText.bodySmall(widget.helperText ?? "",fontSize: 12, color: Colors.grey.shade600),
                hintText: widget.hintText,
                contentPadding: widget.contentPadding ??
                    (widget.maxLines != null
                        ? const EdgeInsets.only(left: 10, right: 10, top: 10)
                        : const EdgeInsets.only(left: 10)),
                filled: true,
                fillColor: Colors.white,
                prefix: widget.prefixIcon ?? (widget.keyboardType == const TextInputType.numberWithOptions(decimal: true) && widget.isPercentageField == false ? const Padding(
                  padding: EdgeInsets.only(right: 2.0),
                  child: Text(""),
                  // child: Text(spUtil?.user.currencySymbol ?? ""),
                )  : null),
                suffixIcon: widget.isPassword == true ? IconButton(
                  onPressed: () {
                    isObscure.value =  !isObscure.value;
                  },
                  icon: Icon(
                    isObscure.value == true
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey[400]!,
                  ),
                ) : widget.suffixIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!, // Adjust the border color
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey[300]!, // Adjust the border color
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color:
                    Colors.grey[500]!, // Adjust the border color when focused
                  ),
                ),
              ),
            ),
          ),),
          // if(errorText!.isNotEmpty )
        if(widget.controller.text.isNotEmpty &&   widget.errorText != null &&  widget.errorText!.isNotEmpty)  Text(
            widget.errorText ?? "",
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

class _NoLeadingZeroInputFormatter extends TextInputFormatter {
  @override
TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, TextEditingValue newValue) {
  if (newValue.text.startsWith('-1') && newValue.text.length == 1) {
    return oldValue; // Prevent input if the first digit is '0'
  }
  return newValue;
}
}


class _MaxValueInputFormatter extends TextInputFormatter {
  final int maxValue;

  _MaxValueInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // If the new value is empty, allow it
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Parse the new value as an integer
    final intValue = int.tryParse(newValue.text);
    if (intValue == null) {
      return oldValue; // Revert to the old value if parsing fails
    }

    // If the new value is greater than maxValue, revert to the old value
    if (intValue > maxValue) {
      return oldValue;
    }

    // Otherwise, allow the new value
    return newValue;
  }
}

// Custom TextInputFormatter for minimum value
class _MinValueInputFormatter extends TextInputFormatter {
  final int minValue;

  _MinValueInputFormatter(this.minValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final intValue = int.tryParse(newValue.text);
    if (intValue == null || intValue < minValue) {
      return oldValue; // Revert to old value if invalid
    }

    return newValue;
  }
}

// Custom TextInputFormatter for maximum value
class _MaximumValueInputFormatter extends TextInputFormatter {
  final int maxValue;

  _MaximumValueInputFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final intValue = int.tryParse(newValue.text);
    if (intValue == null || intValue > maxValue) {
      return oldValue; // Revert to old value if invalid
    }

    return newValue;
  }
}