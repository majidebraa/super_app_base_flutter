
abstract class NavigationCommand {
  const NavigationCommand();
}

class To extends NavigationCommand {
  final String route;
  final dynamic arguments;
  const To(this.route, {this.arguments});
}

class Back extends NavigationCommand {
  const Back();
}

class ClearAndNavigate extends NavigationCommand {
  final String route;
  final dynamic arguments;
  const ClearAndNavigate(this.route, {this.arguments});
}
