// class _MySymptomInputState extends State<MySymptomInput> {
//   final List<TextEditingController> symptomControllers = [];
//   final List<String> symptoms = []; // Store entered symptoms

//   @override
//   void initState() {
//     super.initState();
//     symptomControllers.add(TextEditingController()); // Initial field
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }

//   @override
//   void dispose() {
//     // Important: Dispose controllers to avoid memory leaks
//     for (final controller in symptomControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void saveSymptoms() {
//     for (final controller in symptomControllers) {
//       symptoms.add(controller.text);
//     }
//     // Do something with the 'symptoms' list (save, etc.)
//   }
// }
