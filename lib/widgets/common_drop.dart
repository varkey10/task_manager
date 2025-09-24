import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/cubit/authentication/Auth_cubit_cubit.dart';
import 'package:task_manager/cubit/authentication/Auth_cubit_state.dart';

class CommonDropforUsers extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onUserSelected;
  const CommonDropforUsers({super.key, required this.onUserSelected});

  @override
  State<CommonDropforUsers> createState() => _CommonDropforUsersState();
}

class _CommonDropforUsersState extends State<CommonDropforUsers> {
  Map<String, dynamic>? _selectedUser;

  @override
  void initState() {
    super.initState();
    // fetch users when the dropdown is first built
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();

        if (state is AuthLoading && cubit.usersList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AuthError) {
          return Text('Error: ${state.message}',
              style: const TextStyle(color: Colors.red));
        }

        if (cubit.usersList.isEmpty) {
          return const Text('No users found');
        }

        return DropdownButtonFormField<Map<String, dynamic>>(
          value: _selectedUser,
          hint: const Text('Select User'),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          items: cubit.usersList.map((user) {
            final fullName = '${user['first_name']} ${user['last_name']}';
            return DropdownMenuItem<Map<String, dynamic>>(
              value: user,
              child: Row(
                children: [
                  // CircleAvatar(
                  //   radius: 14,
                  //   backgroundImage: NetworkImage(user['avatar']),
                  // ),
                  const SizedBox(width: 8),
                  Text(fullName),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              widget.onUserSelected(value);
            }
          },
        );
      },
    );
  }
}

class CommonDropDown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CommonDropDown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items.map((val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
