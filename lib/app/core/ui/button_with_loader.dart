import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final VoidCallback onPressed;

  final String label;

  final BlocWidgetSelector<S, bool> selector;
  final B bloc;

  const ButtonWithLoader({
    super.key,
    required this.onPressed,
    required this.label,
    required this.selector,
    required this.bloc,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      child: BlocSelector<B, S, bool>(
        bloc: bloc,
        selector: selector,
        builder: (context, showLoading) {
          if (!showLoading) {
            return Text(label);
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label),
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
