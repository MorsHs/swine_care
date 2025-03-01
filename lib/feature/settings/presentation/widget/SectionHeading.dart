import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading(
      {super.key,
      this.textColor,
      this.showActionButton = true,
      required this.tittle,
      this.buttnTille = 'View all',
      this.onPressed});

  final Color? textColor;
  final bool showActionButton;
  final String tittle, buttnTille;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tittle,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
              onPressed: onPressed,
              child: Text(
                buttnTille,
                style: TextStyle(color: Colors.black87),
              ))
      ],
    );
  }
}
