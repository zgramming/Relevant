import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:intl/intl.dart';

import '../../../../injection.dart';
import '../../../data/model/category/category_model.dart';
import '../../../data/model/event/event_create_form_model.dart';
import '../../../utils/utils.dart';
import '../../riverpod/category/category_notifier.dart';
import '../widgets/form_content.dart';
import '../widgets/modal_pick_image.dart';

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

  File? _selectedImage;

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

  Widget _buildImage() {
    if (_selectedImage == null) {
      return Center(
        child: Transform.scale(
          scale: 3,
          child: const Icon(Icons.image, color: Colors.white),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.file(
          File(_selectedImage!.path),
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      InkWell(
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (context) => ModalBottomPickImage(
                              onPickImage: (image) => setState(() => _selectedImage = image),
                            ),
                          );
                        },
                        child: Ink(
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
                          child: _buildImage(),
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
                            final _future = ref.watch(futureGetCategory);
                            return _future.when(
                              data: (data) {
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
                              error: (error, stackTrace) =>
                                  Center(child: Text((error as Failure).message)),
                              loading: () => const Center(child: CircularProgressIndicator()),
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
                      final _state = ref.watch(
                        eventNotifier.select((value) => value.state),
                      );
                      return ElevatedButton(
                        onPressed: _state == RequestState.loading
                            ? null
                            : () async {
                                try {
                                  if (startDate == null || endDate == null) {
                                    throw Exception(
                                      'Tanggal mulai / selesai tidak boleh kosong',
                                    );
                                  }

                                  if (_selectedCategory == null) {
                                    throw Exception('Kategori tidak boleh kosong');
                                  }

                                  if (_selectedImage == null) {
                                    throw Exception('Gambar belum dipilih');
                                  }

                                  final user = ref.read(userNotifier).item;
                                  final form = EventCreateFormModel(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    location: locationController.text,
                                    startDate: startDate!,
                                    endDate: endDate!,
                                    idOrganization: user?.id ?? 0,
                                    eventType: _selectedEventType,
                                    quota: int.tryParse(quotaController.text) ?? 0,
                                    idCategory: _selectedCategory!.id,
                                    file: _selectedImage,
                                  );

                                  await ref.read(eventNotifier.notifier).create(form);
                                  final message = ref.read(eventNotifier).message;

                                  if (_state == RequestState.loaded) {
                                    Future.delayed(Duration.zero, () {
                                      GlobalFunction.showSnackBar(
                                        context,
                                        content: Text(message),
                                        behaviour: SnackBarBehavior.floating,
                                        snackBarType: SnackBarType.success,
                                      );
                                    });
                                    globalNavigation.pop();
                                  } else if (_state == RequestState.error) {
                                    Future.delayed(Duration.zero, () {
                                      GlobalFunction.showSnackBar(
                                        context,
                                        content: Text(message),
                                        behaviour: SnackBarBehavior.floating,
                                        snackBarType: SnackBarType.error,
                                      );
                                    });
                                  }
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
