# task_manager










Transform.translate(
                        offset: const Offset(-8, 0), // adjust value if needed
                        child: SizedBox(
                          height: 22,
                          width: 35,
                          child: Checkbox(
                            activeColor: const Color(0xff005CC8),
                            value: signupCubit.remeberMe,
                            onChanged: (val) {
                              signupCubit.changeremeberMe(val!);
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ),
