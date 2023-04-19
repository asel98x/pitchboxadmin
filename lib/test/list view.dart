import 'package:flutter/material.dart';

class UserDesignPage extends StatefulWidget {
  @override
  _UserDesignPageState createState() => _UserDesignPageState();
}

class _UserDesignPageState extends State<UserDesignPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Design Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Text(
                  'Left Text',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text(
                  'Right Text',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Some justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Stack(
              children: [
                Image.network(
                  'https://picsum.photos/400',
                  height: 175,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://picsum.photos/100',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.facebook),
                        Icon(Icons.facebook),
                        Icon(Icons.facebook),
                        Icon(Icons.language),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        'text',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Some two line paragraph text that should be justified. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget purus magna. Aliquam erat volutpat. Mauris imperdiet risus eget risus aliquet, non sagittis enim rhoncus. Sed porttitor orci vel tellus bibendum, eu mollis orci sollicitudin. Fusce et blandit lorem.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Company Description',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Business Model',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Value Proposition',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Product or Service',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Funding Needs',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Timeline',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Funding Sources',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Investment Benefits',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Investment Terms',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Risk Factors',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 2),
            SizedBox(height: 16),
            Text(
              'More justified text',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.white,
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.blue),
                                value: 0.5, // set the progress bar value here
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              color: Colors.white,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Submit',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
      ),
    );
  }
}
