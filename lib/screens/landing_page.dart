import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savemymoney/state/auth_state.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      context.read<AuthState>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Landing'),
    );
  }
}
