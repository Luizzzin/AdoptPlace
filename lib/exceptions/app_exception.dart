import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;

/// Erro da camada de dados com uma mensagem adequada para exibir no aplicativo.
class AppException implements Exception {
  const AppException({required this.code, required this.message, this.cause});

  final String code;
  final String message;
  final Object? cause;

  factory AppException.fromError(Object error) {
    if (error is AppException) {
      return error;
    }

    if (error is FirebaseAuthException) {
      return _fromAuth(error);
    }
    if (error is FirebaseException) {
      return _fromFirebase(error);
    }

    return AppException(
      code: 'unknown',
      message: 'Ocorreu um erro inesperado. Tente novamente.',
      cause: error,
    );
  }

  static AppException notFound(String resource) =>
      AppException(code: 'not-found', message: '$resource não encontrado.');

  static AppException _fromAuth(FirebaseAuthException error) {
    const messages = <String, String>{
      'email-already-in-use': 'Este e-mail já está cadastrado.',
      'invalid-email': 'Informe um e-mail válido.',
      'weak-password': 'A senha deve ser mais segura.',
      'invalid-credential': 'E-mail ou senha inválidos.',
      'wrong-password': 'E-mail ou senha inválidos.',
      'user-not-found': 'Não encontramos uma conta com este e-mail.',
      'user-disabled': 'Esta conta está desativada.',
      'requires-recent-login': 'Entre novamente para concluir esta ação.',
      'network-request-failed': 'Sem conexão. Verifique sua internet.',
      'too-many-requests': 'Muitas tentativas. Aguarde e tente novamente.',
    };

    return AppException(
      code: error.code,
      message:
          messages[error.code] ?? 'Não foi possível concluir a autenticação.',
      cause: error,
    );
  }

  static AppException _fromFirebase(FirebaseException error) {
    const messages = <String, String>{
      'permission-denied': 'Você não tem permissão para realizar esta ação.',
      'not-found': 'O dado solicitado não foi encontrado.',
      'unavailable': 'O serviço está indisponível. Tente novamente.',
      'deadline-exceeded': 'A operação demorou demais. Tente novamente.',
      'network-request-failed': 'Sem conexão. Verifique sua internet.',
      'invalid-argument': 'Há dados inválidos na solicitação.',
      'object-not-found': 'O arquivo solicitado não foi encontrado.',
      'unauthorized': 'Você não tem permissão para acessar este arquivo.',
      'canceled': 'O envio do arquivo foi cancelado.',
      'unknown': 'Não foi possível concluir a operação. Tente novamente.',
    };

    return AppException(
      code: error.code,
      message: messages[error.code] ?? 'Não foi possível concluir a operação.',
      cause: error,
    );
  }

  @override
  String toString() => 'AppException($code): $message';
}
