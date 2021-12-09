import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:intl/intl.dart';

import '../../../../injection.dart';
import '../../../data/model/category/category_model.dart';
import '../../../data/model/event/event_create_form_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/event/event_notifier.dart';
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

class CreateEventPage extends ConsumerStatefulWidget {
  static const routeNamed = '/create-event-page';
  const CreateEventPage({Key? key}) : super(key: key);

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends ConsumerState<CreateEventPage> {
  final titleController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final quotaController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  Category? _selectedCategory;
  EventType _selectedEventType = EventType.online;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(categoryNotifier.notifier).get());
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
    ref.listen<EventState>(eventNotifier, (previous, next) {
      if (next.state == RequestState.error) {
        GlobalFunction.showSnackBar(
          context,
          behaviour: SnackBarBehavior.floating,
          content: Text(next.message),
          snackBarType: SnackBarType.error,
        );
      } else if (next.state == RequestState.loaded) {
        // globalNavigation.pushNamedAndRemoveUntil(
        //   routeName: WelcomePage.routeNamed,
        //   predicate: (route) => false,
        // );
        globalNavigation.pop();
        GlobalFunction.showSnackBar(
          context,
          content: const Text('Berhasil membuat event'),
          snackBarType: SnackBarType.success,
        );
      }
    });
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                        title: 'Kategori',
                        child: Consumer(
                          builder: (context, ref, child) {
                            final categories =
                                ref.watch(categoryNotifier.select((value) => value.items));
                            return DropdownFormFieldCustom<Category>(
                              items: categories,
                              itemBuilder: (item) => Text('${item?.name}'),
                              labelText: '',
                              hint: const Text('Pilih Kategori'),
                              onChanged: (item) {
                                setState(() => _selectedCategory = item);
                              },
                            );
                          },
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
                            for (final item in eventTypeToValue.keys)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      if (item == EventType.online) {
                                        setState(() {
                                          _selectedEventType = item;
                                        });
                                      } else {
                                        setState(() {
                                          _selectedEventType = item;
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(16.0),
                                      primary: _selectedEventType == item ? Colors.green : null,
                                    ),
                                    child: Text(
                                      '${toBeginningOfSentenceCase(eventTypeToValue[item])}',
                                      style: latoWhite.copyWith(
                                        color: _selectedEventType == item
                                            ? Colors.white
                                            : Colors.green,
                                      ),
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
                  child: Consumer(
                    builder: (context, ref, child) {
                      return ElevatedButton(
                        onPressed: () async {
                          try {
                            if (startDate == null || endDate == null) {
                              throw Exception('Tanggal mulai / selesai tidak boleh kosong');
                            }

                            if (_selectedCategory == null) {
                              throw Exception('Kategori tidak boleh kosong');
                            }

                            final user = ref.read(userNotifier).item;
                            final form = EventCreateFormModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              location: locationController.text,
                              startDate: startDate!,
                              endDate: endDate!,
                              idOrganization: user.id,
                              eventType: _selectedEventType,
                              quota: int.tryParse(quotaController.text) ?? 0,
                              idCategory: _selectedCategory!.id,
                            );
                            await ref.read(eventNotifier.notifier).create(form);
                          } catch (e) {
                            GlobalFunction.showSnackBar(
                              context,
                              content: Text(e.toString()),
                              snackBarType: SnackBarType.error,
                            );
                          }
                        },
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
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
