import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../view_models/calendar_view_model.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarViewModel viewModel;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    viewModel = Provider.of<CalendarViewModel>(context, listen: false);
    viewModel.fetchAttendance(_selectedDay!);
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<CalendarViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Attendance Calendar')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  viewModel.fetchAttendance(selectedDay);
                });
              },
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronVisible: true,
                rightChevronVisible: true,
              ),
              onFormatChanged: (format) {},
            ),
            SizedBox(height: 20),
            Expanded(
              child: AnimatedOpacity(
                opacity: viewModel.isLoading ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: viewModel.isLoading 
                    ? Center(child: CircularProgressIndicator())
                    : viewModel.attendanceRecords.isEmpty
                        ? Center(child: Text('No attendance records for this day.'))
                        : ListView.builder(
                            itemCount: viewModel.attendanceRecords.length,
                            itemBuilder: (context, index) {
                              final record = viewModel.attendanceRecords[index];
                              return ListTile(
                                title: Text('Check In: ${_formatDate(record.checkIn)}'),
                                subtitle: Text('Check Out: ${record.checkOut != null ? _formatDate(record.checkOut!) : 'Not checked out'}'),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('HH:mm');
    final offsetHours = date.timeZoneOffset.inHours;
    final offsetString = offsetHours >= 0 ? '+$offsetHours' : '$offsetHours';

    return '${formatter.format(date)} GMT$offsetString';
  }
}
