import 'package:flutter/material.dart';
import 'package:hourglass/views/pages/student/book_slot/widgets/section_header.dart';

class ConsultationDetailsSection extends StatefulWidget {
  final Function(String reason)? onSubmit;
  const ConsultationDetailsSection({super.key, required this.onSubmit});

  @override
  State<ConsultationDetailsSection> createState() => _ConsultationDetailsSectionState();
}

class _ConsultationDetailsSectionState extends State<ConsultationDetailsSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SectionHeader(title: "Consultation Details", step: 3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reason for visit', style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),),
              //sizebox
              TextFormField(
                controller: _reasonController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'eg. Need help with midterm project.',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF2563EB),
                      width: 1.5,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a reason for your visit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit?.call(_reasonController.text.trim());
                    }
                  },
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
