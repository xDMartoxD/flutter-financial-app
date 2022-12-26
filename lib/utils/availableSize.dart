import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableSize {
  static double height(BuildContext bctx, PreferredSizeWidget appBar) {
    return MediaQuery.of(bctx).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(bctx).padding.top -
        MediaQuery.of(bctx).padding.bottom;
  }

  static double width(BuildContext bctx, PreferredSizeWidget appBar) {
    return MediaQuery.of(bctx).size.width -
        MediaQuery.of(bctx).padding.left -
        MediaQuery.of(bctx).padding.right;
  }
}
