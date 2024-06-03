import 'package:flutter/material.dart';
import 'package:foodorder/app/widgets/appBar/customAppBar.dart';

class ProductDescriptionView extends StatefulWidget {
  const ProductDescriptionView({Key? key}) : super(key: key);

  @override
  State<ProductDescriptionView> createState() => _ProductDescriptionViewState();
}

class _ProductDescriptionViewState extends State<ProductDescriptionView> {
  List<Map<String, dynamic>> chooseSize = [
    {"title": "Small", "price": "\$5.99"},
    {"title": "Medium", "price": "\$7.99"},
    {"title": "Large", "price": "\$9.99"},
  ];

  List<Map<String, dynamic>> toppings = [
    {"name": "Cheese", "price": "\$1.50"},
    {"name": "Pepperoni", "price": "\$2.00"},
    {"name": "Mushrooms", "price": "\$1.75"},
    {"name": "Olives", "price": "\$1.25"},
  ];

  List<bool> toppingSelections = [];

  @override
  void initState() {
    super.initState();
    toppingSelections = List<bool>.filled(toppings.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeIconAppBar(title: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(243, 243, 243, 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child:
                            Image.asset("assets/images/pizza.png", height: 200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Farmhouse Pizza",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed velit eros, convallis vitae eros nec, commodo volutpat risus. Nam facilisis neque quis urna viverra sagittis. Aliquam est lectus, lobortis id tellus sed, consectetur consequat ipsum. Fusce finibus accumsan faucibus. Phasellus dolor augue, dictum vitae fringilla sit amet, ultricies ut ligula",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(243, 243, 243, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choose Your Size",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 70,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: chooseSize.map((size) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromRGBO(156, 156, 156, 1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(size["title"].toString()),
                                    Text(size["price"].toString()),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Toppings".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: toppings.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${toppings[index]["name"]} ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${toppings[index]["price"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        value: toppingSelections[index],
                        onChanged: (newValue) {
                          setState(() {
                            toppingSelections[index] = newValue!;
                          });
                        },
                      ),
                      Divider()
                    ],
                  );
                },
              ),
              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
