import 'package:app_sig2024/blocs/permissions/permissions_bloc.dart';
import 'package:app_sig2024/features/home/presentation/widgets/form-custom.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PermissionsBloc? permissionsBloc;

  @override
  void initState() {
    // TODO: implement initState
    permissionsBloc = BlocProvider.of<PermissionsBloc>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const decoration1 = BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                "https://res.cloudinary.com/da9xsfose/image/upload/v1721330232/zqgh4kcxycpzdovnparz.jpg"),
            fit: BoxFit.cover));

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: decoration1,
              child: DecoratedBox(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.4))),
            ),
            const FormCustomAuth(),
          ],
        ),
      ),
    );
  }
}
