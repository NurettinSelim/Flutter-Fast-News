import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          bar,
          SizedBox(height: 10),
          appNameVersion,
          SizedBox(height: 20),
          FlatButton(
            onPressed: () async {
              const url = 'https://github.com/NurettinSelim';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Text(
              "Bu app Nurettin Selim tarafından kodlanmıştır.",
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: () => showLicensePage(context: context),
            child: Text("Lisanslar", style: Theme.of(context).textTheme.headline6),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  FutureBuilder<PackageInfo> get appNameVersion {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container();
        }
        return Text("${snapshot.data.appName} ${snapshot.data.version}", style: Theme.of(context).textTheme.headline6);
      },
      future: PackageInfo.fromPlatform(),
    );
  }

  get bar => Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Container(
            width: 58,
            height: 4,
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(14))),
          ),
        ),
      );
}
