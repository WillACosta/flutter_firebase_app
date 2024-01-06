sealed class AppFailure {}

class UserNotFound extends AppFailure {}

class WrongPasswordOrEmail extends AppFailure {}

class GenericFailure extends AppFailure {}
