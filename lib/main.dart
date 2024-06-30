import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'To Do'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List todo = [];
  late String line;
  var st = TextEditingController();
  String test = '';

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    double widthofScreen = MediaQuery.of(context).size.width;
    double heightofScreen = MediaQuery.of(context).size.height;
    double widthOfScreen2 = MediaQuery.of(context).size.width;
    double heightofScreen2 = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade200,
        title: Center(
            child: Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: heightofScreen * .05),
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // color: Colors.amber,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .89,
              child: ListView.builder(
                  itemCount: todo.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Container(
                          // color: Colors.amber,
                          width: MediaQuery.of(context).size.width * .85,
                          height: MediaQuery.of(context).size.height * .057,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: done_button(
                                    widthofScreen: widthofScreen,
                                    heightofScreen: heightofScreen),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Container(
                                  width: widthofScreen * .73,
                                  height: heightofScreen * .07,
                                  // color: Colors.blueAccent,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Center(
                                      child: Text(
                                        todo[index],
                                        // softWrap: true,
                                        // overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: heightofScreen * .025),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          child: AlertDialog(
                                            title: Center(
                                              child: Text('Edit todo'),
                                            ),
                                            content: TextField(
                                              onChanged: (val) {
                                                test = val;
                                              },
                                              autofocus: true,
                                              controller: TextEditingController(
                                                  text: todo[index]),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      todo[index] = test;
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: Text('OK'))
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Container(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    todo.removeAt(index);
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Container(
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: AlertDialog(
                    title: Center(
                      child: Text('add a todo'),
                    ),
                    content: TextField(
                      controller: st,
                      // focusNode: FocusNode(),
                      autofocus: true,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              line = st.text.toString();
                              todo.add(line);
                              // print(todo);
                              Navigator.pop(context);
                              st.clear();
                            });
                          },
                          child: Text('ok')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            st.clear();
                          },
                          child: Text('Cancel'))
                    ],
                  ),
                );
              });
        },
        // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ignore: camel_case_types
class done_button extends StatefulWidget {
  const done_button({
    super.key,
    required this.widthofScreen,
    required this.heightofScreen,
  });

  final double widthofScreen;
  final double heightofScreen;

  @override
  State<done_button> createState() => _done_buttonState();
}

bool isDone = false;

class _done_buttonState extends State<done_button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDone = !isDone;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2.5, color: Colors.green.shade600),
            borderRadius: BorderRadius.circular(10)),
        // color: Colors.black12,
        width: widget.widthofScreen * .075,
        height: widget.heightofScreen * .035,
        child: Icon(Icons.done_outlined,
            color: isDone ? Colors.black : Colors.transparent),
      ),
    );
  }
}
