import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

List<String> todo = [];
TextEditingController line = TextEditingController();

class _TodoState extends State<Todo> {
  void getData() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {});
    todo = pref.getStringList('TODO') ?? ['hello'];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: Text('TODO'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .895,
                child: ListView.builder(
                    itemCount: todo.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            todo[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              final pref =
                                  await SharedPreferences.getInstance();
                              List<String> temp =
                                  pref.getStringList('TODO') ?? ['hello'];
                              temp.removeAt(index);
                              await pref.setStringList('TODO', temp);
                              setState(() {
                                todo = pref.getStringList('TODO')!;
                              });
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red.shade900,
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Add a Todo'),
                  content: Form(
                      child: TextFormField(
                    controller: line,
                    decoration: InputDecoration(
                      hintText: 'Will go to gym',
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.all(5),
                    ),
                  )),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel')),
                    TextButton(
                        onPressed: () async {
                          todo.add(line.text.toString());
                          final pref = await SharedPreferences.getInstance();
                          await pref.setStringList('TODO', todo);
                          Navigator.pop(context);
                        },
                        child: Text('Save'))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
