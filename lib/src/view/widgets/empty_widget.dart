import 'package:flutter/material.dart';

import 'package:newsapi_flutter/src/core/util/asset_path.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      AssetPath.imgEmpty,
      fit: BoxFit.cover,
      width: 120,
      height: 120,
    ));
  }
}
