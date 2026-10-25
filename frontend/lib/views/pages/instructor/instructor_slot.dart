import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/instructor/slot/add_slot.dart';
import 'package:hourglass/services/instructor_service.dart';



class InstructorSlot extends StatefulWidget {
  const InstructorSlot({super.key});

  @override
  State<InstructorSlot> createState() => _InstructorSlotState();
}

class _InstructorSlotState extends State<InstructorSlot> {

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
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text('${slot['date']} (${slot['start_time']} - ${slot['end_time']})'),
            subtitle: Text('Location: ${slot['location']} • Capacity: ${slot['booked_count'] ?? 0}/${slot['max_capacity']}'),
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

              // Call your helper method here
              _buildSlotList(),
            ],
          ),
        ),
      ),
    );
  }
}
