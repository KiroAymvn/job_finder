import 'package:bloc/bloc.dart';
import 'package:job_finder/features/auth/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
}
