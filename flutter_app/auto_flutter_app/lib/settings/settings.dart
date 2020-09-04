class Settings {

  final String api;

  final int maxRetries;

  Settings({this.api, this.maxRetries});

  static Settings _devSettings() =>
    Settings(
      api: "http://192.168.178.122:80/",
      maxRetries: 1,
    );
  
  static Settings _productionSettings() => 
    Settings(
      api: "http://192.168.4.1:80/",
      maxRetries: 1,
    );

  //One of the following should apply
  static Settings getCorrectSettings() => 
    _devSettings();
  // productionSettings();
}