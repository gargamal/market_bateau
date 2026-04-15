const int limitShipsPagination = int.fromEnvironment('LIMIT_PAGINATION', defaultValue: 15);
const String baseUrl = String.fromEnvironment('BASE_URL', defaultValue: 'http://192.168.1.173:8080');
const int lapTimeCallBackend = int.fromEnvironment('LAP_TIME_BACKEND', defaultValue: 500);
const double limitShipsRefresh = 0.9;

const String citiesBoxName = 'cities_box';
const String shipsBoxName = 'ships_box';
const String settingsBoxName = 'settings_box';
