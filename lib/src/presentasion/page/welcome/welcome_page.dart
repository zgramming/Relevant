import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:intl/intl.dart';

import '../../../utils/utils.dart';
import '../home/home_page.dart';
import '../my_account/my_account_page.dart';
import '../my_bookmark/my_bookmark_page.dart';
import '../my_event/my_event_page.dart';
import '../widgets/form_content.dart';

class WelcomePage extends StatefulWidget {
  static const routeNamed = '/welcome-page';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _items = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Eventku'),
    BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Favoritku'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
  ];

  final _screens = const [
    HomePage(),
    MyEventPage(),
    MyBookmarkPage(),
    MyAccountPage(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(12.0),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
          ),
        ),
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      // body: const HomePage(),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() => _selectedIndex = value),
        items: _items,
        backgroundColor: primary,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class CreateEventPage extends StatefulWidget {
  static const routeNamed = '/create-event-page';
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final titleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final quotaController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    quotaController.dispose();
    descriptionController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Event'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: primary4,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Judul',
                      child: TextFormFieldCustom(
                        controller: titleController,
                        disableOutlineBorder: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Tanggal Mulai',
                      child: TextFormFieldCustom(
                        controller: startDateController,
                        disableOutlineBorder: false,
                        readOnly: true,
                        onTap: () async {
                          final dateResult = await GlobalFunction.showDateTimePicker(context);
                          if (dateResult != null) {
                            startDate = dateResult;
                            startDateController.text = GlobalFunction.formatYMDHM(dateResult);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Tanggal Selesai',
                      child: TextFormFieldCustom(
                        controller: endDateController,
                        disableOutlineBorder: false,
                        readOnly: true,
                        onTap: () async {
                          final dateResult = await GlobalFunction.showDateTimePicker(context);
                          if (dateResult != null) {
                            endDate = dateResult;
                            endDateController.text = GlobalFunction.formatYMDHM(dateResult);
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Tipe Event',
                      child: Row(
                        children: [
                          for (final item in typeEventToValue.keys)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(16.0),
                                    // primary: Colors.green,
                                  ),
                                  child: Text(
                                    '${toBeginningOfSentenceCase(typeEventToValue[item])}',
                                    style: latoWhite.copyWith(color: Colors.green),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Kuota',
                      child: TextFormFieldCustom(
                        controller: quotaController,
                        disableOutlineBorder: false,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Lokasi',
                      child: TextFormFieldCustom(
                        controller: locationController,
                        disableOutlineBorder: false,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormContent(
                      title: 'Deskripsi',
                      child: TextFormFieldCustom(
                        controller: descriptionController,
                        disableOutlineBorder: false,
                        minLines: 5,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          KeyboardVisibilityBuilder(
            builder: (context, child, isKeyboardVisible) {
              if (isKeyboardVisible) {
                return const SizedBox();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                    primary: primary,
                    padding: const EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'Buat Event',
                    style: latoWhite.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
