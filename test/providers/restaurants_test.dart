import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/models/restaurant_list.dart';
import 'package:restawurant/providers/restaurants.dart';
import 'package:restawurant/providers/state.dart';

class MockRestaurantsApi extends Mock implements RestaurantsApi {}

void main() {
  late RestaurantsProvider restaurantsProvider;
  late MockRestaurantsApi mockRestaurantsApi;

  setUp(() {
    mockRestaurantsApi = MockRestaurantsApi();
    restaurantsProvider = RestaurantsProvider(mockRestaurantsApi);
  });

  group('restaurant provider', () {
    test('should have initial state', () {
      expect(restaurantsProvider.state, isA<NoneState>());
    });

    test(
      'should return restaurant list when API succeeds',
      () async {
        when(() => mockRestaurantsApi.list()).thenAnswer(
          (_) async => RestaurantList(
            error: false,
            message: 'Success',
            count: 2,
            restaurants: <Restaurant>[
              Restaurant(
                  id: '1',
                  name: 'Restaurant',
                  description: 'A nice restaurant',
                  pictureId: '01',
                  city: 'Malang',
                  rating: 4.5,
              ),
              Restaurant(
                  id: '2',
                  name: 'Cafe',
                  description: 'A nice cafe',
                  pictureId: '02',
                  city: 'Jakarta',
                  rating: 4.0,
              ),
            ]
          ),
        );

        await restaurantsProvider.list();

        expect(restaurantsProvider.state, isA<LoadedState>());
        final state = restaurantsProvider.state as LoadedState;
        expect(state.data, isA<List<Restaurant>>());
      },
    );

    test('should return error when API fails', () async {
      when(() => mockRestaurantsApi.list()).thenAnswer(
        (_) async => RestaurantList(
          error: true,
          message: 'Failed to fetch data',
          count: 0,
          restaurants: [],
        ),
      );

      await restaurantsProvider.list();

      expect(restaurantsProvider.state, isA<ErrorState>());
      final state = restaurantsProvider.state as ErrorState;
      expect(state.error, 'Failed to fetch data');
    });
  });
}
