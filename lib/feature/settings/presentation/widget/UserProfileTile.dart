import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:swine_care/colors/ArgieColors.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset('assets/images/rose.jpg',
          width: 50,
          height: 50,
        ),
      ),
      title: Text('Argie uwu', style: TextStyle(color: ArgieColors.textthirdary),),
      subtitle: Text('argieuwu@gmail.com', style: TextStyle(color: ArgieColors.textthirdary),),
      trailing: IconButton(onPressed: (){}, icon: Icon(Iconsax.edit, color: ArgieColors.textthirdary,)),

    );
  }
}