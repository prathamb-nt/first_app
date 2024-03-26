import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditDateWidget extends StatefulWidget {
  final String postDate;

  const EditDateWidget({super.key, required this.postDate});

  @override
  State<EditDateWidget> createState() => _EditDateWidgetState();
}

class _EditDateWidgetState extends State<EditDateWidget> {
  late String selectedDate = widget.postDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Post Date',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Color(0xff353535),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: Text(
                  'Select Date',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff1C1C1C),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 310,
              width: 342,
              child: SfDateRangePicker(
                allowViewNavigation: false,
                selectionMode: DateRangePickerSelectionMode.single,
                enablePastDates: false,
                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: Color(0xff353535),
                    ),
                  ),
                ),
                navigationMode: DateRangePickerNavigationMode.snap,
                showNavigationArrow: true,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                todayHighlightColor: const Color(0xffED4D86),
                selectionColor: const Color(0xffED4D86),
                selectionShape: DateRangePickerSelectionShape.rectangle,
                selectionRadius: 4,
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  setState(
                    () {
                      selectedDate = DateFormat.yMMMd()
                          .format(dateRangePickerSelectionChangedArgs.value);
                      Navigator.pop(context, selectedDate);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
