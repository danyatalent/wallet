import 'package:auto_route/auto_route.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';
import 'package:wallet/features/router/app_router.dart';

class WelcomeGuard extends AutoRouteGuard {
  final PhraseRepository phraseRepository;

  Phrase? _phrase;

  WelcomeGuard(this.phraseRepository) {
    onUpdate();
  }

  onUpdate() async {
    await phraseRepository.getPhrase().forEach((phrase) => _phrase = phrase);
  }

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {

    if (_phrase is PhraseSetted) {
      resolver.next(true);
    } else {
      router.push(const WelcomeRoute());
    }
  }
}