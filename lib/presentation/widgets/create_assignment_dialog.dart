import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/theme/retain_learn_theme.dart';
import '../../data/providers/repository_providers.dart';
import '../../domain/models/assignment.dart';

/// Dialog for teachers to create a new assignment
class CreateAssignmentDialog extends ConsumerStatefulWidget {
  const CreateAssignmentDialog({super.key});

  @override
  ConsumerState<CreateAssignmentDialog> createState() => _CreateAssignmentDialogState();
}

class _CreateAssignmentDialogState extends ConsumerState<CreateAssignmentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _pointsController = TextEditingController(text: '100');
  
  DateTime? _dueDate;
  String? _selectedSubject;
  bool _isLoading = false;

  final List<String> _subjects = [
    'Math',
    'Science',
    'History',
    'English',
    'Computer Science',
    'Art',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _instructionsController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: RetainLearnTheme.paperWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                   Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: RetainLearnTheme.tealPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.assignment_add,
                      color: RetainLearnTheme.tealPrimary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'New Assignment',
                    style: GoogleFonts.merriweather(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: RetainLearnTheme.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Scrollable Content
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      _buildTextField(
                        controller: _titleController,
                        label: 'Title',
                        icon: Icons.title,
                        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      
                      // Description
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Description',
                        icon: Icons.description_outlined,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 16),
                      
                      // Subject & Points Row
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: _selectedSubject,
                              decoration: _inputDecoration('Subject', Icons.category_outlined),
                              items: _subjects.map((s) => DropdownMenuItem(
                                value: s.toLowerCase(),
                                child: Text(s),
                              )).toList(),
                              onChanged: (val) => setState(() => _selectedSubject = val),
                              validator: (value) => value == null ? 'Required' : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              controller: _pointsController,
                              label: 'Points',
                              icon: Icons.score_outlined,
                              keyboardType: TextInputType.number,
                              validator: (val) => int.tryParse(val ?? '') == null ? 'Invalid' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Due Date Picker
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(const Duration(days: 7)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: RetainLearnTheme.tealPrimary,
                                    onPrimary: Colors.white,
                                    surface: RetainLearnTheme.paperWhite,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() => _dueDate = picked);
                          }
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: RetainLearnTheme.grayBorder),
                            borderRadius: BorderRadius.circular(14),
                            color: RetainLearnTheme.paperOffWhite,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, color: RetainLearnTheme.textLight),
                              const SizedBox(width: 12),
                              Text(
                                _dueDate == null 
                                  ? 'Select Due Date (Optional)' 
                                  : DateFormat('MMM d, yyyy').format(_dueDate!),
                                style: TextStyle(
                                  color: _dueDate == null ? RetainLearnTheme.textMedium : RetainLearnTheme.textDark,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: RetainLearnTheme.textMedium),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _isLoading ? null : _handleCreate,
                    style: FilledButton.styleFrom(
                      backgroundColor: RetainLearnTheme.tealPrimary,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: _isLoading
                      ? const SizedBox(
                          width: 20, 
                          height: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : const Text('Create Assignment'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: RetainLearnTheme.textMedium),
      prefixIcon: Icon(icon, color: RetainLearnTheme.textLight),
      filled: true,
      fillColor: RetainLearnTheme.paperOffWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: RetainLearnTheme.grayBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: RetainLearnTheme.grayBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: RetainLearnTheme.tealPrimary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: RetainLearnTheme.textDark, fontSize: 15),
      decoration: _inputDecoration(label, icon),
      validator: validator,
    );
  }

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final repo = ref.read(assignmentsNotifierProvider.notifier);
      
      final newAssignment = Assignment(
        id: '', // Generated by backend
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        status: AssignmentStatus.published,
        createdAt: DateTime.now(),
        dueDate: _dueDate,
        subjectArea: _selectedSubject,
        totalPoints: int.parse(_pointsController.text),
        isActive: true,
      );
      
      await repo.createAssignment(newAssignment);
      
      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Assignment created successfully!'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating assignment: $e'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
