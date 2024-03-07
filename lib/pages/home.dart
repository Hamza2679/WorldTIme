import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Use a nullable Map to handle potential null values
  Map<dynamic, dynamic>? data;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve arguments safely within didChangeDependencies
    data = (data?.isNotEmpty ?? false)
        ? data
        : (ModalRoute.of(context)?.settings.arguments
            as Map<dynamic, dynamic>?);
  }

  @override
  Widget build(BuildContext context) {
    didChangeDependencies();
    // Print the data after it's retrieved in didChangeDependencies
    print(data);
    String bgImage = data?['isDaytime'] ? 'dayv.jpg' : 'nig.jpg';
    Color? bgcolor = data?['isDaytime']
        ? const Color.fromARGB(255, 87, 174, 245)
        : const Color.fromARGB(255, 9, 13, 44);

    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag']
                      };
                    });
                  },
                  icon: const Icon(
                    Icons.edit_location,
                    color: Color.fromARGB(255, 222, 221, 221),
                  ),
                  label: const Text(
                    'Edit location',
                    style: TextStyle(
                      color: Color.fromARGB(255, 215, 215, 215),
                    ),
                  ),
                ),
                // Use the data here, if available
                if (data != null) ...[
                  // Display data or perform actions based on its contents
                ],
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data?['location'],
                      style: TextStyle(
                          fontSize: 28, letterSpacing: 2, color: Colors.white),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Text(data?['time'],
                    style: TextStyle(fontSize: 66, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
