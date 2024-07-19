import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/features/home/presentation/widgets/buttonAuth.widget.dart';
import 'package:app_sig2024/features/home/presentation/widgets/textFormFieldCustom.widget.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormCustomAuth extends StatefulWidget {
  const FormCustomAuth({
    super.key,
  });

  @override
  State<FormCustomAuth> createState() => _FormCustomAuthState();
}

class _FormCustomAuthState extends State<FormCustomAuth> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    return Positioned(
      top: size.height * 0.3,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
        height: size.height * 0.55,
        width: size.width,
        child: Column(
          children: [
            Text("Bienvenido, cumpla un buen servicio",
                style: estilosText!.tituloAuth, textAlign: TextAlign.center),
            CustomTextFormField(
                placeholder: "Codigo trabajador",
                icon: Icons.person,
                color: kPrimaryColor,
                keyboardType: TextInputType.text,
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                }),
            SizedBox(
              height: size.height * 0.03,
            ),
            CustomTextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                placeholder: "Clave Secreta",
                icon: Icons.lock,
                color: kPrimaryColor,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                }),
            SizedBox(
              height: size.height * 0.03,
            ),
            ButtonAuthentication(onTap: () {
              autheticationBloc.add(OnEntrarLogin(email, password, context));
              autheticationBloc.add(const OnGetPuntosCorte());
              locationBloc.startFollowingUser();
            }),
          ],
        ),
      ),
    );
  }
}
