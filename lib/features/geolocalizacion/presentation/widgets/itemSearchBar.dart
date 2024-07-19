import 'dart:async';

import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({
    super.key,
  });

  @override
  State<SearchBarComponent> createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  final myController = TextEditingController();
  Timer? _debounce;
  @override
  void dispose() {
    myController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);
    return Positioned(
        top: size.height * 0.12,
        right: size.width * 0.0,
        left: size.width * 0.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          height: size.height * 0.075,
          decoration: const BoxDecoration(
            color: kCColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: size.width * 0.01),
                width: size.width * 0.661,
                child: TextFormField(
                  controller: myController,
                  style: estilosText!.titulo3,
                  decoration: InputDecoration(
                    hintStyle: estilosText!.titulo3,
                    hintText: 'Buscar el punto de corte',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      autheticationBloc.add(OnFiltroViewClienteDPC(value));
                    });
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  myController.clear();
                  autheticationBloc.add(const OnResetViewClienteDPC());
                },
                child: Icon(
                  Icons.clear,
                  size: size.width * 0.07,
                  color: kSecondaryColor,
                ),
              ),
            ],
          ),
        ));
  }
}
