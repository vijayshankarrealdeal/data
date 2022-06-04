import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:frontend/back_logic.dart/back.dart';
import 'package:provider/provider.dart';

class ImageAnaly extends StatelessWidget {
  const ImageAnaly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.55,
        backgroundColor: Colors.black.withOpacity(0.75),
        child: Consumer<BackLogic>(builder: (context, data, _) {
          return ListView(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.dashtext,
                        style: Theme.of(context).textTheme.displayMedium),
                    Image.network(
                      data.dashImg,
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.overlay,
                    ),
                  ],
                ),
              ),
              Text("Details", style: Theme.of(context).textTheme.displayMedium),
              Text(data.ss[data.dashtext.toLowerCase()].toString(),
                  style: Theme.of(context).textTheme.bodyLarge)
            ],
          );
        }),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Satellite Images',
          style: Theme.of(context).textTheme.headline5,
        ),
        leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Consumer<BackLogic>(builder: (context, data, _) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 4),
            itemCount: data.dataAnl.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  data.getImage(
                      'http://127.0.0.1:8000/files/${data.dataAnl[index].img}',
                      data.dataAnl[index].predict
                              .substring(0, 1)
                              .toUpperCase() +
                          data.dataAnl[index].predict.substring(1));
                  scaffoldKey.currentState!.openDrawer();
                },
                child: GridTile(
                  footer: Text(
                    data.dataAnl[index].predict.substring(0, 1).toUpperCase() +
                        data.dataAnl[index].predict.substring(1),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  child: Image.network(
                    'http://127.0.0.1:8000/files/${data.dataAnl[index].img}',
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
