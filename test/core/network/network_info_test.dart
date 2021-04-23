import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tddtry4/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  MockDataConnectionChecker mockConnection;
  NetworkInfoImpl network;
  setUp(() {
    mockConnection = MockDataConnectionChecker();
    network = NetworkInfoImpl(mockConnection);
  });

  test('Check if the network isConnected', () async {
    when(mockConnection.hasConnection)
        .thenAnswer((realInvocation) async => true);
    final actual = await network.isConnected;

    expect(actual, true);
    verify(mockConnection.hasConnection);
  });
}
