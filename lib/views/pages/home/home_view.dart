import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/model/events_model.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/events_view_model.dart';
import 'package:flutter_template/viewModel/schedule_view_model.dart';
import 'package:flutter_template/views/pages/Ifest/ifest_view.dart';
import 'package:flutter_template/views/pages/home/widgets/current_next_widget.dart';
import 'package:flutter_template/views/pages/home/widgets/event_card.dart';
import 'package:flutter_template/views/pages/meal_detail/meal_detail_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String id = 'home_View';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<Map<String, dynamic>> fetchedSchedule;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    fetchedSchedule = context.read<ScheduleViewModel>().GetSchedule();
    super.initState();
  }

  Future<void> onRefrech() async {
    setState(() {
      fetchedSchedule = context.read<ScheduleViewModel>().GetSchedule();
    });
  }

  String search = "";
  TextEditingController controllerText = TextEditingController();
  List<EventsModel> filteredEvents = [];
  bool enabled = false;
  DateTime eventDate = DateTime.parse('2023-03-17');
  EventsModel ifest = EventsModel(
      id: "",
      eventName: "I-fest²",
      eventLocation: "MAHDIA PALACE",
      eventPrice: 0,
      eventDate: DateTime.parse('2023-03-17'),
      eventStartTime: "8:00",
      eventEndTime: "eventEndTime",
      eventAbout: "eventAbout",
      likes: [],
      unlikes: [],
      planing: [],
      image:
          "https://firebasestorage.googleapis.com/v0/b/ifest-38db9.appspot.com/o/IFEST_logo.png?alt=media&token=7fed89bd-ebc5-4166-8d60-06b237f22483",
      createdAt: DateTime.parse('2023-03-17'),
      updatedAt: DateTime.parse('2023-03-17'),
      v: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.PageMainColor,
        body: RefreshIndicator(
          onRefresh: onRefrech,
          key: _refreshIndicatorKey,
          child: SizedBox(
            height: SizeConfig.safeBlockVertical * 88,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topBar(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          EventCard(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                IfestView.id,
                                arguments: {'role': "guest"},
                              );
                            },
                            event: ifest,
                            imageUrl: ifest.image,
                          ),
                          SizedBox(
                            height: SizeConfig.kDefaultSize * 4,
                          ),
                          eventsFutureBuilder(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<Map<String, dynamic>> eventsFutureBuilder(
      BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: context.read<EventsViewModel>().GetEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: SizeConfig.safeBlockVertical * 40,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (!snapshot.hasData) {
          return SizedBox(
            height: SizeConfig.safeBlockVertical * 40,
            width: SizeConfig.safeBlockHorizontal * 100,
            child: Center(
              child: Text(
                "Check your internet connection and then refresh!!",
                style: GoogleFonts.poppins(
                  color: const Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w300,
                  fontSize: SizeConfig.kDefaultSize * 4,
                ),
              ),
            ),
          );
        } else {
          filteredEvents = Provider.of<EventsViewModel>(context, listen: false)
              .filteredEvents!;
          print(filteredEvents);
          if (filteredEvents.isEmpty) {
            return SizedBox(
              height: SizeConfig.safeBlockVertical * 40,
              width: SizeConfig.safeBlockHorizontal * 100,
              child: Center(
                child: Text(
                  "There are no events for the moment!!",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w300,
                    fontSize: SizeConfig.kDefaultSize * 4,
                  ),
                ),
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: SizeConfig.kDefaultSize * 4,
                  ),
                ],
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) =>
                  filteredEvents[index].eventName.toLowerCase().contains(search)
                      ? EventCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventsDetailView(
                                  event: filteredEvents[index],
                                ),
                              ),
                            );
                          },
                          event: filteredEvents[index],
                          imageUrl: filteredEvents[index].image,
                        )
                      : SizedBox.shrink(),
            );
          }
        }
      },
    );
  }

  Column topBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        Text(
          "Hello there!!",
          style: GoogleFonts.poppins(
            color: const Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.kDefaultSize * 10,
          ),
        ),
        Text(
          "Here’s a list of events",
          style: GoogleFonts.poppins(
            color: const Color(0xFFCCD2D4),
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.kDefaultSize * 4.6,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 2,
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 10,
          width: SizeConfig.safeBlockHorizontal * 100,
          child: TextField(
            controller: controllerText,
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: SizeConfig.kDefaultSize * 5,
            ),
            onChanged: searchProduct,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              fillColor: const Color(0xFFE5E5E5).withOpacity(0.43),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80),
                  borderSide: BorderSide.none),
              hintText: 'Search',
              hintStyle: TextStyle(
                color: const Color(0xFFCDCDCD),
                fontSize: SizeConfig.kDefaultSize * 5,
              ),
              prefixIcon: Container(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  "assets/svgs/search.svg",
                  width: SizeConfig.kDefaultSize * 6,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void searchProduct(String query) {
    query = query.trim();
    setState(() {
      search = query.toLowerCase();
    });
    if (query.isEmpty) {
      setState(() {
        filteredEvents = context.read<EventsViewModel>().event!;
        controllerText.clear();
      });
    } else {
      Provider.of<EventsViewModel>(context, listen: false).filteredEvents =
          context.read<EventsViewModel>().event!.where((event) {
        final commandNum = event.eventName.toLowerCase();
        final input = query.toLowerCase();
        return commandNum.contains(input);
      }).toList();
      print("aaaaaaaaaaaaaaaaaaaaaaa");
      print(
          Provider.of<EventsViewModel>(context, listen: false).filteredEvents!);
      setState(() {
        filteredEvents = Provider.of<EventsViewModel>(context, listen: false)
            .filteredEvents!;
      });
    }
  }
}
