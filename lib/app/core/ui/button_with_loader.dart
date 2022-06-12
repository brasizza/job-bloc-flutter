import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamable<S>, S> extends StatelessWidget {
  final B bloc;
  final BlocWidgetSelector<S, bool> selector;
  final VoidCallback onPressed;
  final String label;

  const ButtonWithLoader({
    Key? key,
    required this.selector,
    required this.bloc,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocSelector<B, S, bool>(
      bloc: bloc,
      selector: selector,
      builder: (context, isLoading) {
        return AnimatedContainer(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          width: !isLoading ? width : 70,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: !isLoading ? ElevatedButton.styleFrom() : ElevatedButton.styleFrom(shape: const CircleBorder()),
            child: Visibility(
                visible: !isLoading,
                replacement: const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
                child: FittedBox(child: Text(label))),
          ),
        );
      },
    );
  }
}
