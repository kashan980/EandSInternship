import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checking_age_provider_viewModel.dart';

class CheckingAge extends StatelessWidget{
  CheckingAge({super.key});
  final TextEditingController controller= TextEditingController();

  @override
  Widget build(BuildContext context){
    return Consumer<CheckingAgeProvider>(
      builder: (context, viewModel, _){
        return Scaffold(
            appBar: AppBar(
              title: const Text("Age Checker"),
            ),
            body:Padding(
              padding: EdgeInsets.all(10),
              child: Column(
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
                    viewModel.setAge(age);
                  }, child: Text("Check"),),
                  SizedBox(height: 30),
                  Text(
                      viewModel.isEligible?"YOU ARE ELIGIBLE": "YOU ARE NOT ELIGIBLE"
                  )
                ],
              ),
            )

        );
      }
    );
  }
}

