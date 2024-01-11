import 'package:flutter/material.dart';
import 'package:todo_app/db_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var db = MySql(); // Access the DBHelper class
  List<dynamic> patients = []; // Store fetched patients

  @override
  void initState() {
    super.initState();
    fetchPatients(); // Initial fetch
  }

  Future<void> fetchPatients() async {
    final fetchedPatients = await db.fetchPatients();
    setState(() {
      patients = fetchedPatients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: Text('Appbar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display fetched patients
          Expanded(
            child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                final id = patient['id'];
                print(id);
                return Container(
                  height: 70,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: const BoxDecoration(color: Colors.white54),
                  child: ListTile(
                    onTap: ()async{
                      await db.deletePatient(id);

                    },
                    onLongPress: (){
                      db.updatePatient(id, 'Amir Amir', 35, 'doctorName', 'description', 550

                      ).then((value){
                        print('update');
                      });
                    },
                    title: Text(patient['name']),
                    subtitle: Text('Age: ${patient['age']}'),
                    trailing: Text('Charges: ${patient['charges']}'),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: fetchPatients,
            child: Text('Refresh Patients'),
          ),
          ElevatedButton(
            onPressed: (){
              db.insertPatient('murad khan', 22, 'Murad ', 'nothing to write', 200).then((value) {
                print('inserted');
              });
            },
            child: Text('insert'),
          ),
          ElevatedButton(
            onPressed: fetchPatients,
            child: Text('update'),
          ),

        ],
      ),
    );
  }
}
