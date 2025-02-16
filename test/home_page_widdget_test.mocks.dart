// Mocks generated by Mockito 5.4.5 from annotations
// in chefapp/test/home_page_widdget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:chefapp/data/dish_repository.dart' as _i4;
import 'package:chefapp/data/interface_allergens_repository.dart' as _i3;
import 'package:chefapp/domain/model/allergen_model.dart' as _i8;
import 'package:chefapp/domain/model/dish_model.dart' as _i6;
import 'package:chefapp/domain/model/dish_type_model.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:supabase_auth_ui/supabase_auth_ui.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSupabaseClient_0 extends _i1.SmartFake
    implements _i2.SupabaseClient {
  _FakeSupabaseClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIAllergensRepository_1 extends _i1.SmartFake
    implements _i3.IAllergensRepository {
  _FakeIAllergensRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DishRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDishRepository extends _i1.Mock implements _i4.DishRepository {
  @override
  _i2.SupabaseClient get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _FakeSupabaseClient_0(
          this,
          Invocation.getter(#database),
        ),
        returnValueForMissingStub: _FakeSupabaseClient_0(
          this,
          Invocation.getter(#database),
        ),
      ) as _i2.SupabaseClient);

  @override
  set database(_i2.SupabaseClient? _database) => super.noSuchMethod(
        Invocation.setter(
          #database,
          _database,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.IAllergensRepository get allergenRepo => (super.noSuchMethod(
        Invocation.getter(#allergenRepo),
        returnValue: _FakeIAllergensRepository_1(
          this,
          Invocation.getter(#allergenRepo),
        ),
        returnValueForMissingStub: _FakeIAllergensRepository_1(
          this,
          Invocation.getter(#allergenRepo),
        ),
      ) as _i3.IAllergensRepository);

  @override
  set allergenRepo(_i3.IAllergensRepository? _allergenRepo) =>
      super.noSuchMethod(
        Invocation.setter(
          #allergenRepo,
          _allergenRepo,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<List<_i6.DishModel>> fetchDishOfTheDay([DateTime? date]) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchDishOfTheDay,
          [date],
        ),
        returnValue: _i5.Future<List<_i6.DishModel>>.value(<_i6.DishModel>[]),
        returnValueForMissingStub:
            _i5.Future<List<_i6.DishModel>>.value(<_i6.DishModel>[]),
      ) as _i5.Future<List<_i6.DishModel>>);

  @override
  _i5.Future<int> postDishOfTheDay(
    String? title,
    String? description,
    int? calories,
    String? imageUrl,
    _i7.DishTypeModel? dishType, [
    DateTime? date,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #postDishOfTheDay,
          [
            title,
            description,
            calories,
            imageUrl,
            dishType,
            date,
          ],
        ),
        returnValue: _i5.Future<int>.value(0),
        returnValueForMissingStub: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);

  @override
  _i5.Future<int> addToTodaysMenu(int? id) => (super.noSuchMethod(
        Invocation.method(
          #addToTodaysMenu,
          [id],
        ),
        returnValue: _i5.Future<int>.value(0),
        returnValueForMissingStub: _i5.Future<int>.value(0),
      ) as _i5.Future<int>);

  @override
  _i5.Future<bool> removeFromMenu(
    int? id, [
    DateTime? date,
  ]) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromMenu,
          [
            id,
            date,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
        returnValueForMissingStub: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);

  @override
  void addAllergeneToDish(
    _i8.AllergenModel? allergene,
    int? dishId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #addAllergeneToDish,
          [
            allergene,
            dishId,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
