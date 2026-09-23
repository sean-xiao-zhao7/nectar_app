class Options {
  final String? clientServerId;
  const Options({this.clientServerId});
}

class DefaultNectarOptions {
  static const Options android =
      Options(clientServerId: 'copy-from-google-services.json');
}
