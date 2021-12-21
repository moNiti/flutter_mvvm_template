import 'package:flutter/cupertino.dart';
import 'package:fresh_graphql/fresh_graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GqlLink {
  static final GqlLink _gqlLink = GqlLink._internal();
  factory GqlLink() {
    return _gqlLink;
  }
  GqlLink._internal();

  ErrorLink get errorLink {
    return ErrorLink(
      // onException: (request, forward, exception) {
      //   if (exception is RevokeTokenException) {
      //     throw UnauthorizedException();
      //   }
      //   if (exception is NetworkException) {
      //     throw NoInternetConnectionException();
      //   }
      // },
      onGraphQLError: (request, forward, response) {
        final int code = response.errors!.first.extensions!['code'];
        debugPrint("=========== >>>  ERORR ${code}   <<< ===========");
        switch (code) {
          case 400:
            throw BadRequestException();
          case 401:
            throw UnauthorizedException();
          case 403:
            throw UnauthorizedException();
          case 404:
            throw NotFoundException();
          case 409:
            throw ConflictException();
          case 500:
            throw InternalServerErrorException();
          case 502:
            throw InternalServerErrorException();
        }
        forward(request);
      },
    );
  }

  FreshLink get freshLink {
    return FreshLink(
      tokenHeader: (token) => {"Authorization": "Bearer $token"},
      tokenStorage: InMemoryTokenStorage(),
      refreshToken: (token, client) {
        try {
          return Future.delayed(const Duration(seconds: 10)); // DO REFRESH WORK
        } catch (ex) {
          // freshLink.clearToken();
          throw RevokeTokenException(); // refresh fails and should result in a force-logout.
        }
      },
      shouldRefresh: (response) {
        if (response.errors != null && response.errors!.isNotEmpty) {
          final int code = response.errors!.first.extensions!['code'];
          if (code == 401) return true;
        }
        return false;
      },
    )..authenticationStatus.listen((value) => debugPrint);
  }
}

class BadRequestException extends ErrorLink {
  BadRequestException();

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends ErrorLink {
  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends ErrorLink {
  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends ErrorLink {
  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends ErrorLink {
  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends ErrorLink {
  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends ErrorLink {
  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
