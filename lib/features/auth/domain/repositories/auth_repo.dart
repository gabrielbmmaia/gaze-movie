
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/models/user.dart';

/*
* ResultFuture é um typedef de Future<Either<Failure, T>>
* */
abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<User> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });


  ResultFuture<void> forgotPassword(String email);

  /*
  * Funcionalidade para alterar alguma informação do usuário. É necessário
  * informar o Enum desejado e o dado a ser alterado.
  * */
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

}
