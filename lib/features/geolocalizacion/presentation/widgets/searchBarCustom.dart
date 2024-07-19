import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        // GoRouter.of(context).go('');
        context.push("/search");
      },
      iconSize: size.height * 0.05,
      color: kSecondaryColor,
    );
  }
}
