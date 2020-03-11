import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_monkey/util/log_utils.dart';


class ImageUtils {

  static ImageProvider getAssetIamge(String name,{String format: 'png'}){
    return AssetImage(getImgPath(name,format:format));
  }

  static String getImgPath(String name, {String format: 'png'}){
    return 'assets/images/$name.$format';
  }

  static ImageProvider getIamgeProvider(String imageUrl, {String holderImg: 'none'}){
    if (TextUtil.isEmpty(imageUrl)) {
      return AssetImage(getImgPath(holderImg));
    }
    return CachedNetworkImageProvider(imageUrl,errorListener: ()=>Log.e(""));
  }



}