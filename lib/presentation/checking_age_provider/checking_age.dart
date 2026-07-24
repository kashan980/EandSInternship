import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checking_age_provider.dart';

class CheckingAge extends StatelessWidget{
  CheckingAge({super.key});
  final TextEditingController controller= TextEditingController();

  @override
  Widget build(BuildContext context){
    final provider = Provider.of<CheckingAgeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Age Checker"),
      ),
      body:Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter Age",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            int age= int.tryParse(controller.text)??0;
            provider.setAge(age);
          }, child: Text("Check"),),
          SizedBox(height: 30),
          Text(
            provider.isEligible?"YOU ARE ELIGIBLE": "YOU ARE NOT ELIGIBLE"
          )
        ],

      )

    );
  }

}

