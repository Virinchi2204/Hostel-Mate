/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum GenderTypeEnum {Male, Female}

class MyDetails extends StatefulWidget {
  const MyDetails({Key? key}) : super(key: key) ;

  @override
  // ignore: library_private_types_in_public_api
  _MyDetailsState createState() => _MyDetailsState();
}

class _MyDetailsState extends State<MyDetails> {
  get child => null;
  GenderTypeEnum? _genderTypeEnum;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
    ),
    child: Scaffold(
    backgroundColor: Colors.transparent,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: Stack(
    children: [
    SingleChildScrollView(
    child: Container(
    padding: const EdgeInsets.only(
      top: 200,
    //top: MediaQuery.of(context).size.height * 0.28
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
      ),
    Container(
    margin: const EdgeInsets.only(left: 35, right: 35),
    child: Column(
    children: [
    const Text(
    'Personal Details\n',
    style: TextStyle(color: Colors.white, fontSize: 33),
    ),
    TextField(
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
    fillColor: Colors.white,
    filled: true,

    hintText: "Name of the Institute",
    hintStyle: const TextStyle(color: Colors.black38),
    prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.home_work_outlined), color: Colors.black38),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    )),
    ),
    const SizedBox(
    height: 30,
    ),
      TextField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Reg. No.",
            hintStyle: const TextStyle(color: Colors.black38),
            prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.filter_frames_rounded),),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            )),
      ),
    const SizedBox(
    height: 20,
    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Gender',
            style: TextStyle(
                color: Colors.white60,
                fontSize: 15,
                fontWeight: FontWeight.w700),
          ),
        ]
      ),
      const SizedBox(
        height: 10,
      ),
    Row(
      children: [
        Expanded(child: RadioListTile<GenderTypeEnum>(
            contentPadding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            value: GenderTypeEnum.Male,
            groupValue: _genderTypeEnum,
            title: Text(GenderTypeEnum.Male.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
            onChanged: (val){
              setState(() {
                _genderTypeEnum = val;
              });
            },
            tileColor: Colors.white
        ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(child: RadioListTile<GenderTypeEnum>(
            contentPadding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            value: GenderTypeEnum.Female,
            groupValue: _genderTypeEnum,
            title: Text(GenderTypeEnum.Female.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
            onChanged: (val){
              setState(() {
                _genderTypeEnum = val;
              });
            },
            tileColor: Colors.white
        ),
        ),
      ],

    ),

      const SizedBox(
    height: 30,
    ),
      Column(
        children: [
          TextField(
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Contact No.",
              hintStyle: const TextStyle(color: Colors.black38),
              prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.phone_outlined),),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              )),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: TextField(
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: "Hostel Room No.",
                hintStyle: const TextStyle(color: Colors.black38),
                prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.door_front_door_outlined),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                )),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          ),
          const SizedBox(
            width: 15,
          ),
            Expanded(child: TextField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Age",
                  hintStyle: const TextStyle(color: Colors.black38),
                  prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month),),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Done',
            style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.w700),
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xff4c505b),
            child: IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'home');
                },
                icon: const Icon(
                  Icons.arrow_forward,
                )),
          )
        ],
      ),
      const SizedBox(
        height: 30,
      ),
    ],
    ),
    )
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    );
  }
}
*/