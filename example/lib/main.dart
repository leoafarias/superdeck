import 'package:flutter/material.dart';
import 'package:superdeck/models/options_model.dart';
import 'package:superdeck/superdeck.dart';
import 'package:superdeck_demo/src/style.dart';
import 'package:superdeck_demo/src/widget/mix_demo.dart';

void main() async {
  runApp(
    Builder(builder: (context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SuperDeckApp(
          style: style,
          // ignore: prefer_const_literals_to_create_immutables
          examples: [
            Example(
              name: 'demo',
              schema: ExampleOptions.schema,
              builder: (args) {
                return Center(
                  child: Container(
                    height: args.height,
                    width: args.width,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text(args.text),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }),
  );
}
