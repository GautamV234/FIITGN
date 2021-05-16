import 'dart:io';
import 'package:http/io_client.dart';
import 'package:http/src/base_request.dart';
import 'package:http/src/response.dart';
import 'package:connectivity/connectivity.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;

class CalendarSchedule {
  //------------------------------------CALENDAR EVENTS--------------------------------------------//

  var events;
  Future reloadEvents() async {
    for (int i = 1; i < 8; i++) {
      events[i] = [];
    }
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      final GoogleSignIn googleSignInObject = GoogleSignIn();
      FirebaseUser fireBaseUser;
      final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
      googleSignInObject.signInSilently().then((value) async {
        final authHeaders = await googleSignInObject.currentUser.authHeaders;
        final httpClient = GoogleHttpClient(authHeaders);
        createAndGetCalendarEvents(httpClient);
      });
    }
  }

  Future createAndGetCalendarEvents(GoogleHttpClient httpClient) async {
    var eventsData =
        await calendar.CalendarApi(httpClient).events.list('primary');
    print(eventsData);
    print("Checking if the code works");
  }

  Future getEventsOnline(httpClient) async {
    var eventData =
        await calendar.CalendarApi(httpClient).events.list('primary');
    List<calendar.Event> tempEvents = [];
    tempEvents.addAll(eventData.items);
    makeListWithoutRepetitionEvent(tempEvents);
  }

  void makeListWithoutRepetitionEvent(List<calendar.Event> tempEvents) {
    List<calendar.Event> withoutRepeat = [];

    tempEvents.forEach((calendar.Event event) {
      bool notHave = true;
      withoutRepeat.forEach((calendar.Event _event) {
        if (_event.id == event.id) {
          notHave = false;
        }
      });
      if (notHave &&
          event != null &&
          event.start != null &&
          event.start.dateTime != null &&
          event.start.dateTime.year == DateTime.now().year &&
          event.start.dateTime.month == DateTime.now().month &&
          event.start.dateTime.day == DateTime.now().day) {
        withoutRepeat.add(event);
      }
    });

    for (int i = 1; i < 8; i++) {
      events[i] = [];
    }

    withoutRepeat.forEach((calendar.Event event) {
      if (event != null) {
        // events[DateTime.now().weekday].add(Event(
        //     startTime: (event.start != null && event.start.dateTime != null)
        //         ? event.start.dateTime.toLocal()
        //         : DateTime(2021, 1, 1, 1),
        //     endTime: (event.end != null && event.end.dateTime != null)
        //         ? event.end.dateTime.toLocal()
        //         : DateTime(2021, 1, 1, 2),
        //     name: (event.description != null) ? event.description : "",
        //     host: (event.creator != null && event.creator.displayName != null)
        //         ? event.creator.displayName
        //         : "",
        //     link: (event.htmlLink != null)
        //         ? event.htmlLink
        //         : "" //TODO: Have to check how to obtain link from calendar.event object
        //     ));
      }
    });
  }
}

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}
