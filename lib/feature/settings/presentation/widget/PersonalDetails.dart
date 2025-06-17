// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:swine_care/colors/ArgieColors.dart';
// import 'package:swine_care/colors/ArgieSizes.dart';
// import 'package:swine_care/global_widget/TextFieldContainer.dart';
//
// class PersonalDetails extends StatefulWidget {
//   final String name;
//   final String email;
//
//   const PersonalDetails({
//     super.key,
//     required this.name,
//     required this.email,
//   });
//
//   @override
//   State<PersonalDetails> createState() => _PersonalDetailsState();
// }
//
// class _PersonalDetailsState extends State<PersonalDetails> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   final _phoneController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.name);
//     _emailController = TextEditingController(text: widget.email);
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     super.dispose();
//   }
//
//   void _saveDetails() {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Personal details updated successfully!")),
//       );
//       // Return the updated details to the Settings page
//       Navigator.pop(context, {
//         'name': _nameController.text,
//         'email': _emailController.text,
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       floatingActionButton: null,
//       backgroundColor: isDarkMode ? ArgieColors.dark : Colors.grey.shade50,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(ArgieSizes.paddingDefault),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         Icons.arrow_back,
//                         color: isDarkMode ? Colors.white70 : Colors.black87,
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const SizedBox(width: 26),
//                     Expanded(
//                       child: Text(
//                         "Personal Details",
//                         style: GoogleFonts.poppins(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: isDarkMode ? Colors.white70 : Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: ArgieSizes.spaceBtwSections),
//
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Card(
//                       color: isDarkMode ? Colors.grey.shade800 : Colors.white,
//                       elevation: 2,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Update Your Details",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: isDarkMode ? Colors.white70 : Colors.black87,
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//
//                             Textfieldcontainer(
//                               isHidden: false,
//                               label: "Full Name",
//                               controller: _nameController,
//                               showVisibilityToggle: false,
//                               prefixIcon: Iconsax.user,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "Please enter your full name";
//                                 }
//                                 return null;
//                               },
//                             ),
//
//                             Textfieldcontainer(
//                               isHidden: false,
//                               label: "Email Address",
//                               controller: _emailController,
//                               showVisibilityToggle: false,
//                               prefixIcon: Iconsax.sms,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return "Please enter your email address";
//                                 }
//                                 if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                                   return "Please enter a valid email address";
//                                 }
//                                 return null;
//                               },
//                             ),
//
//                             Textfieldcontainer(
//                               isHidden: false,
//                               label: "Phone Number (Optional)",
//                               controller: _phoneController,
//                               showVisibilityToggle: false,
//                               prefixIcon: Iconsax.call,
//                               validator: (value) {
//                                 if (value != null && value.isNotEmpty) {
//                                   if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
//                                     return "Please enter a valid phone number";
//                                   }
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _saveDetails,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ArgieColors.primary,
//                       foregroundColor: ArgieColors.textthird,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       "Save Changes",
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }