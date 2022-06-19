import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 70,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Assessmart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  )),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.app_registration,
                  color: Colors.indigo,
                ),
                title: const Text('Sign Up'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.login,
                  color: Colors.deepPurpleAccent,
                ),
                title: const Text('Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.code,
                  color: Colors.pinkAccent,
                ),
                title: const Text('Coding Lab'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/coding_lab');
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text('SmartAccess'),
        centerTitle: true,
        actions: <Widget>[
          if (MediaQuery.of(context).size.width > 600)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  FloatingActionButton.extended(
                      heroTag: 'aregbtn',
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      backgroundColor: Colors.green,
                      //icon: const Icon(Icons.app_registration),
                      label: const Text('SignUp')),
                  const SizedBox(width: 10),
                  FloatingActionButton.extended(
                      heroTag: 'alogbtn',
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      //icon: const Icon(Icons.login),
                      backgroundColor: Colors.pink,
                      label: const Text('Login')),
                ],
              ),
            ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return wideHomeContainers(context);
          } else {
            return normalHomeContainer(context);
          }
        },
      ),
    );
  }
}

Widget normalHomeContainer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FloatingActionButton.extended(
            heroTag: 'regbtn',
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            backgroundColor: Colors.deepPurple,
            icon: const Icon(Icons.app_registration),
            label: const Text('Sign Up')),
        const SizedBox(
          height: 20,
          width: 0,
        ),
        FloatingActionButton.extended(
            heroTag: 'logbtn',
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.login),
            label: const Text('Login'))
      ],
    ),
  );
}

Widget wideHomeContainers(BuildContext context) {
  return Center(
      child: Container(
          width: 400,
          color: Colors.grey[200],
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FloatingActionButton.extended(
                        heroTag: 'regbtn1',
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        backgroundColor: Colors.deepPurple,
                        icon: const Icon(Icons.app_registration),
                        label: const Text('Sign Up')),
                    const SizedBox(
                      height: 20,
                      width: 0,
                    ),
                    FloatingActionButton.extended(
                        heroTag: 'logbtn1',
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        icon: const Icon(Icons.login),
                        label: const Text('Login'))
                  ],
                ),
              ))));
}
