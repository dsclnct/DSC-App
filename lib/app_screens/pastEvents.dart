import 'package:flutter/material.dart';
import 'package:gdsc_lnct/app_screens/upcomingevents.dart';

import '../constants.dart';

class PastEvent extends StatelessWidget {
  const PastEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Past Events',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        bottom: PreferredSize(
          preferredSize: Size(0, 0),
          child: kcoloredLine,
        ),
      ),
      body: ListEvents(
        event: EventType.pastEvents,
      ),
    );
  }
}
