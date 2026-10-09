/// Platform-specific configuration options for Nectar.
class Options {
  final String? clientServerId;
  const Options({this.clientServerId});
}

/// Default configuration options across supported platforms.
class DefaultNectarOptions {
  static const Options android =
      Options(clientServerId: 'copy-from-google-services.json');
}
