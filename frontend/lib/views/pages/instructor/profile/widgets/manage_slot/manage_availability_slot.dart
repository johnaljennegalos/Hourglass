import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/slot/add_slot.dart';
import 'package:hourglass/services/instructor_service.dart';
import 'package:intl/intl.dart';



class ManageAvailabilitySlot extends StatefulWidget {
  const ManageAvailabilitySlot({super.key});

  @override
  State<ManageAvailabilitySlot> createState() => _ManageAvailabilitySlotState();
}

class _ManageAvailabilitySlotState extends State<ManageAvailabilitySlot> {

  Future<void> _confirmAndDeleteSlot(Map<String, dynamic> slot) async {
    final bool? confirmed = await showDialog<bool>(
        context: context,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Delete Consultation Slot'),
            content: Text('Delete ${slot['date']}?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext, false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext, true);
                },
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        }
    );

    if (confirmed != true) {
      return;
    }

    final int slotId = slot['id'];
    final success = await InstructorService.deleteConsultationSlot(slotId);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Slot successfully deleted!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 35.0,
            left: 16.0,
            right: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );

      _fetchSlots();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Slot deletion failed!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 35.0,
            left: 16.0,
            right: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }

  }

  Widget _buildSlotList(){
    if (_slots.isEmpty){
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.event_busy, color: Colors.blue),
            SizedBox(width: 8.0),
            Text(
              'No consultation slots available',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _slots.map((slot) {

        final DateTime parsedDate = DateTime.parse(slot['date']);
        final String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(parsedDate);
        final DateTime parsedStartTime = DateTime.parse('2000-01-01 ' + slot['start_time']);
        final String formattedStartTime = DateFormat('h:mm a').format(parsedStartTime);
        final DateTime parsedEndTime = DateTime.parse('2000-01-01 ' + slot['end_time']);
        final String formattedEndTime = DateFormat('h:mm a').format(parsedEndTime);
        final MenuController menuController = MenuController();


        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(color: Colors.black12),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF2563EB),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$formattedDate', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          Text('${formattedStartTime} - ${formattedEndTime}', style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600]
                          ),),
                          Text('Location: ${slot['location']}', style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700]
                          ),),
                          Text('Capacity: ${slot['max_capacity']}', style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700]
                          ),),
                        ],
                      ),
                    ),
                    MenuAnchor(
                      controller: menuController,
                      alignmentOffset: const Offset(-80, 0),
                      builder: (BuildContext context, MenuController controller, Widget? child) {
                        return IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            controller.isOpen ? controller.close() : controller.open();
                          },
                        );
                      },
                      menuChildren: [
                        MenuItemButton(
                          leadingIcon: const Icon(Icons.edit, color: Colors.amber),
                          onPressed: () async {

                            final bool? shouldRefresh = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(builder: (context) => AddSlot(slot: slot))
                            );

                            if (shouldRefresh == true) {
                              _fetchSlots();
                            }
                          },
                          child: const Text('Edit Slot'),
                        ),
                        MenuItemButton(
                          leadingIcon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            menuController.close();
                            Future.microtask(() => _confirmAndDeleteSlot(slot));
                          },
                          child: const Text('Delete Slot'),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  List<dynamic> _slots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSlots();
  }

  Future<void> _fetchSlots() async {
    setState(() => _isLoading = true);

    final slotsData = await InstructorService.getSlots();

    // print('DEBUG SLOTS RESPONSE: $slotsData');

    if (mounted) {
      setState(() {
        _slots = slotsData ?? [];
        _isLoading = false;
      });
    }
  }

  int get totalSlotsCount => _slots.length;

  int get totalBookedSeats {
    return _slots.fold<int>(0, (sum, slot){
      return sum + ((slot['booked_count'] as int?) ?? 0);
    });
  }

  int get totalAvailableSeats{
    return _slots.fold<int>(0, (sum, slot) {
      int maxCapacity = (slot['max_capacity'] as int) ?? 0;
      int booked = (slot['booked_count'] as int) ?? 0;
      int remaining = maxCapacity - booked;
      return sum + (remaining > 0 ? remaining : 0);
    });
  }

  Future<void> _navigateToCreateSlot() async {
    final bool? isCreated = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const AddSlot()),
    );

    if (isCreated == true && mounted) {
      _fetchSlots();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Consultation slot created successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 35.0,
            left: 16.0,
            right: 16.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Availability Slot'),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        ) :SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My Slots',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),
                          ),
                          Text('Manage your consultation availability')
                        ],
                      )
                  ),
                  IconButton(
                    onPressed: _navigateToCreateSlot,
                    icon: Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Slot overview'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 6.0,
                          color: Colors.blue,
                          shadowColor: Colors.black,
                          surfaceTintColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text('Total', style: TextStyle(color: Colors.white, fontSize: 14),),
                                const SizedBox(height: 8),
                                Text(
                                  '$totalSlotsCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 6.0,
                          color: Colors.teal,
                          shadowColor: Colors.black,
                          surfaceTintColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text('Booked', style: TextStyle(color: Colors.white, fontSize: 14),),
                                const SizedBox(height: 8),
                                Text(
                                  '$totalBookedSeats',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 6.0,
                          color: Colors.blueGrey,
                          shadowColor: Colors.black,
                          surfaceTintColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text('Available', style: TextStyle(color: Colors.white, fontSize: 14),),
                                const SizedBox(height: 8),
                                Text(
                                  '$totalAvailableSeats',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              //display for the list
              const Text(
                'Active Consultation Slots',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12.0),
              _buildSlotList(),
            ],
          ),
        ),
      ),
    );
  }
}
