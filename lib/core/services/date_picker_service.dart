import 'package:flutter/material.dart';
import '../helpers/colors.dart';

class DatePickerService {
  /// Show a themed date picker matching the app's color scheme
  static Future<DateTime?> showThemedDatePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
      helpText: helpText,
      cancelText: cancelText ?? 'Cancel',
      confirmText: confirmText ?? 'OK',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // Color scheme for the date picker
            colorScheme: const ColorScheme.light(
              primary: kPrimaryGreen, // Header background and selected date
              onPrimary: colorWhite, // Header text color
              surface: colorWhite, // Background color
              onSurface: colorBlack, // Body text color
            ),
            
            // Date picker theme
            datePickerTheme: DatePickerThemeData(
              // Header colors
              backgroundColor: colorWhite,
              headerBackgroundColor: kPrimaryGreen,
              headerForegroundColor: colorWhite,
              
              // Day selection
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorWhite; // Selected date text
                }
                return colorBlack; // Normal date text
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return kPrimaryGreen; // Selected date background
                }
                return Colors.transparent;
              }),
              
              // Today's date highlight
              todayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorWhite;
                }
                return kPrimaryGreen; // Today's date in green
              }),
              todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return kPrimaryGreen;
                }
                return Colors.transparent;
              }),
              todayBorder: const BorderSide(color: kPrimaryGreen, width: 1),
              
              // Year selection
              yearForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorWhite;
                }
                return colorBlack;
              }),
              yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return kPrimaryGreen;
                }
                return Colors.transparent;
              }),
              
              // Divider color
              dividerColor: Colors.grey.shade300,
              
              // Shape
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            
            // Text button theme for Cancel and OK buttons
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: kPrimaryGreen,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            
            // Dialog theme
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  /// Format date as YYYY-MM-DD
  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Format date as DD/MM/YYYY
  static String formatDateDDMMYYYY(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Format date as Month DD, YYYY (e.g., "January 15, 2025")
  static String formatDateLong(DateTime? date) {
    if (date == null) return '';
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Parse date string (YYYY-MM-DD or ISO format)
  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    return DateTime.tryParse(dateString);
  }
}

