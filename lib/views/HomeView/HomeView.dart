import 'package:google_fonts/google_fonts.dart';
import 'package:stroke_text/stroke_text.dart';
import 'package:todoapp/controllers/AlertDialogController.dart';
import 'package:todoapp/controllers/ToDoController.dart';
import 'package:todoapp/models/enums/CRUD.dart';
import 'package:todoapp/views/ManageToDoView/ManageToDoView.dart';
import 'package:todoapp/views/ToDoListView/ToDoListView.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  //custom controller
  final TodoController todoController = TodoController();
  final AlertDialogController alertDialogController = AlertDialogController();
  //flutter built in controller
  final TextEditingController tTextController = TextEditingController();
  final TextEditingController dTextController = TextEditingController();
  final PageController pageController = PageController();
  int currentPageIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: StrokeText(text: "Paikia's Todo App",
          //text stroke
          textStyle: TextStyle(
            color: Colors.white
          ),
          strokeColor: Colors.black,
          strokeWidth: 3,
        ),
        titleTextStyle: GoogleFonts.preahvihear(
          fontSize: 20.0
        ), //custom fonts
        backgroundColor: Colors.deepPurpleAccent.withOpacity(0.5),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index){
          setState(() {
            FocusScope.of(context).unfocus();
            currentPageIndex = index;
          });
        },
        children: [
          //page 1- todoList
          ToDoListView(
            todoController: todoController,
            alertDialogController: alertDialogController,
            tTextController: tTextController,
            dTextController: dTextController,
            pageController: pageController,
          ),

          //page 2- addtodo
          ManageToDoView(
            tTextController: tTextController,
            dTextController: dTextController,
            todoController: todoController,
            alertDialogController: alertDialogController,
            pageController: pageController,
            crud: CRUD.C,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (index){
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
            label: 'Todo List',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
            label: 'Add Todo',
          ),
        ],
      ),
    );
  }
}