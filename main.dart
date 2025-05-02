class _MainPageState extends State<MainPage>{
  final user = User(
    name: 'Bianca',
    age: 24,
    urlImage: src(img/bianca.jpg)
  );
 
  @override
  Widget buld(BuildContext context)=>Scaffold(
    body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child:
      ),  // Container
    ),  // SafeArea
  );  // Scaffold
}