import 'package:flutter/material.dart';
import 'package:organizzer/presenter/components/main_app_bar.dart';
import 'package:organizzer/presenter/controllers/calendario_controller.dart';
import 'package:organizzer/resources/colors.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: 'Mini diário'),
      body: Consumer<CalendarioController>(builder: (_, controller, __) {
        return Column(
          children: [
            TableCalendar(
              firstDay: DateTime(1997, 07, 03),
              lastDay: DateTime(2025, 12, 31),
              focusedDay: controller.diaSelecionado,
              onDaySelected: controller.setDiaSelecionado,
              onFormatChanged: (format) {},
              eventLoader: (dia) => [],
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  if (controller.getRecordacaoByDate() != null) ...[
                    ...controller.getRecordacaoByDate()!.acontecimentos.map((e) {
                      return ListTile(
                        leading: Icon(Icons.not_listed_location_outlined),
                        title: Text(e),
                      );
                    }).toList(),
                    ...controller.getRecordacaoByDate()!.aprendiDeNovo.map((e) {
                      return ListTile(
                        leading: Icon(Icons.lightbulb),
                        title: Text(e),
                      );
                    }).toList(),
                  ],
                ],
              ),
            ),
          ],
        );
      }),
      // bottomSheet: BottomSheet(
      //   onClosing: () {},
      //   builder: (_) {
      //     return Container(
      //       height: 200,
      //       color: Colors.amber,
      //     );
      //   },
      // ),
    );
  }
}
