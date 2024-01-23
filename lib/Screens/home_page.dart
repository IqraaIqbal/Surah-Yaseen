import "dart:ui";
import "package:flutter/material.dart";
import "package:share/share.dart";
import "package:yaseen/Screens/pdf_viewer.dart";
import "package:yaseen/Theme/colors.dart";
import "package:url_launcher/url_launcher.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          null,
          0,
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.outline,
            ),
          );
        }),
        title: Text(
          'Home',
          style: TextStyle(
              fontSize: 18, color: Theme.of(context).colorScheme.outline),
        ),
        toolbarHeight: 50,
        //centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.75),
        //shadowColor : Colors.transparent,
        //surfaceTintColor: Colors.white.withOpacity(0.76),
        elevation: 0,
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(50.0)),
          ),
          null,
          0,
        ),
        width: 270,
       // backgroundColor: Theme.of(context).colorScheme.background,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                //sigmaX is the Horizontal blur
                sigmaX: 4.0,
                //sigmaY is the Vertical blur
                sigmaY: 4.0,
              ),
              //we use this container to scale up the blur effect to fit its
              //  parent, without this container the blur effect doesn't appear.
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.03)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        //begin color
                        Colors.white.withOpacity(0.15),
                        //end color
                        Colors.white.withOpacity(0.05),
                      ]),
                ),
              ),
            ),
            //gradient effect ==> the second layer of stack
             SingleChildScrollView(
               child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 80),
                child: Column(
                  children: [
                    Container(
                      height:100,
                      width: 100,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    SizedBox(height: 30,),
                    Text('Surah Yaseen',style: TextStyle(
                      color: MyColors.mainColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 30,),
                    // Divider(
                    //   thickness: 1,
                    // ),
                    InkWell(
                      onTap: (){
                        Share.share("Hello");
                      },
                      child: ListTile(
                        leading: Icon(Icons.share,color: MyColors.mainColor,),
                        title: Text('Share App',style: TextStyle(
                          color: MyColors.mainColor,
                        ),),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        launchURL("https://play.google.com/store/apps/details?id=your_package_name");
                      },
                      child: ListTile(
                        leading: Icon(Icons.star_border_purple500,color: MyColors.mainColor,),
                        title: Text('Rate App',style: TextStyle(
                          color: MyColors.mainColor,
                        ),),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: ListTile(
                        leading: Icon(Icons.apps,color: MyColors.mainColor,),
                        title: Text('More Apps',style: TextStyle(
                          color: MyColors.mainColor,
                        ),),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        launchURL("https://pub.dev/");
                      },
                      child: ListTile(
                        leading: Icon(Icons.privacy_tip_outlined,color: MyColors.mainColor,),
                        title: Text('Privacy Policy',style: TextStyle(
                          color: MyColors.mainColor,
                        ),),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        launchURL('https://www.google.com');
                      },
                      child: ListTile(
                        leading: Icon(Icons.file_copy,color: MyColors.mainColor,),
                        title: Text('Terms And Conditions',style: TextStyle(
                          color: MyColors.mainColor,
                        ),),
                      ),
                    ),
                    // Divider(
                    //   thickness: 1,
                    // ),
                  ],
                ),
                           ),
             ),
          ],
        ),
      ),
      //backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                //  color: Colors.green,
                child: Image.asset(
                  'assets/images/quran.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => PDFViewerFromAsset(
                            pdfAssetPath: 'assets/surah_yaseen.pdf',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Theme.of(context).colorScheme.primary),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            //  radius: 25,
                            backgroundColor: Colors.white,
                            child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/holyQuran.png',
                                  fit: BoxFit.fitHeight,
                                )),
                          ),
                          Text(
                            "Recite",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
