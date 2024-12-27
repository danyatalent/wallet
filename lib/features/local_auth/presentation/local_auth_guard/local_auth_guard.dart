import 'package:auto_route/auto_route.dart';
import 'package:wallet/features/local_auth/domain/entities/auth_status.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';
import 'package:wallet/features/router/app_router.dart';

class LocalAuthGuard extends AutoRouteGuard {
  final LocalAuthRepository localAuthRepository;

  LocalAuthStatus? _status;

  LocalAuthGuard(this.localAuthRepository){
    onUpdate();
  }

  onUpdate() async {
    await localAuthRepository.getStatus().forEach((s) => _status = s);
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_status is LocalAuthStatusAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(LocalAuthRoute(onResult: () {
        router.markUrlStateForReplace();
        router.removeLast();
        resolver.next();
      }));
    }
  }
}