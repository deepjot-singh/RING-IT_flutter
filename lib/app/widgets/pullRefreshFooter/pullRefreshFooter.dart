import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullRefreshFooter {
  static getPullRefreshFooter() {
    return CustomFooter(
      builder: (BuildContext? context, LoadStatus? mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          //body = Text("pull up load");
          body = Container();
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator(
            color: Colors.white,
          );
        } else if (mode == LoadStatus.failed) {
          //body = Text("Load Failed! Click retry!");
          body = Container();
        } else if (mode == LoadStatus.canLoading) {
          // body = Text("Release to load more");
          body = Container();
        } else {
          //No More Data
          body = Container();
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}