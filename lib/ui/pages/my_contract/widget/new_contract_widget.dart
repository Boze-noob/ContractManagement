import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewContractWidget extends StatefulWidget {
  const NewContractWidget({Key? key}) : super(key: key);

  @override
  _NewContractWidgetState createState() => _NewContractWidgetState();
}

class _NewContractWidgetState extends State<NewContractWidget> {
  @override
  Widget build(BuildContext context) {
    var signatureImage;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Material(
            clipBehavior: Clip.antiAlias,
            shape: BeveledRectangleBorder(
              side: BorderSide(
                color: active.withOpacity(0.7),
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Contract name'.toUpperCase(),
                    style: GoogleFonts.oleoScript(
                      height: 1.8,
                      fontWeight: FontWeight.normal,
                      fontSize: context.textSizeL,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.,',
                      style: GoogleFonts.oleoScript(
                        height: 1.8,
                        fontWeight: FontWeight.normal,
                        fontSize: context.textSizeL,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    padding: EdgeInsets.only(left: 30),
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(
                          ' - This is item that we sent you , thank you',
                          style: GoogleFonts.oleoScript(
                            height: 0.7,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 35,
                          ),
                          child: SignaturePad(
                            width: 200,
                            height: 50,
                            penStrokeWidth: 2,
                            onChange: (image) {
                              print('we are sending pic via callback function');
                              signatureImage = image;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Button(
          text: 'Accept',
          shrinkWrap: true,
          color: active,
          textColor: Colors.white,
          borderRadius: 20,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
