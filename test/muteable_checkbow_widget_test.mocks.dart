// Mocks generated by Mockito 5.4.5 from annotations
// in chefapp/test/muteable_checkbow_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:chefapp/data/allergenes_repository.dart' as _i7;
import 'package:chefapp/data/categories_repository.dart' as _i5;
import 'package:chefapp/domain/model/allergen_model.dart' as _i4;
import 'package:chefapp/domain/model/category_model.dart' as _i3;
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

class _FakeCategoryModel_1 extends _i1.SmartFake implements _i3.CategoryModel {
  _FakeCategoryModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAllergenModel_2 extends _i1.SmartFake implements _i4.AllergenModel {
  _FakeAllergenModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CategoriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCategoriesRepository extends _i1.Mock
    implements _i5.CategoriesRepository {
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
  _i6.Future<List<_i3.CategoryModel>> fetchCategories() => (super.noSuchMethod(
        Invocation.method(
          #fetchCategories,
          [],
        ),
        returnValue:
            _i6.Future<List<_i3.CategoryModel>>.value(<_i3.CategoryModel>[]),
        returnValueForMissingStub:
            _i6.Future<List<_i3.CategoryModel>>.value(<_i3.CategoryModel>[]),
      ) as _i6.Future<List<_i3.CategoryModel>>);

  @override
  _i6.Future<_i3.CategoryModel> postNewCategory(String? categoryName) =>
      (super.noSuchMethod(
        Invocation.method(
          #postNewCategory,
          [categoryName],
        ),
        returnValue: _i6.Future<_i3.CategoryModel>.value(_FakeCategoryModel_1(
          this,
          Invocation.method(
            #postNewCategory,
            [categoryName],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.CategoryModel>.value(_FakeCategoryModel_1(
          this,
          Invocation.method(
            #postNewCategory,
            [categoryName],
          ),
        )),
      ) as _i6.Future<_i3.CategoryModel>);
}

/// A class which mocks [AllergenesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAllergenesRepository extends _i1.Mock
    implements _i7.AllergenesRepository {
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
  _i6.Future<List<_i4.AllergenModel>> fetchAllergenes() => (super.noSuchMethod(
        Invocation.method(
          #fetchAllergenes,
          [],
        ),
        returnValue:
            _i6.Future<List<_i4.AllergenModel>>.value(<_i4.AllergenModel>[]),
        returnValueForMissingStub:
            _i6.Future<List<_i4.AllergenModel>>.value(<_i4.AllergenModel>[]),
      ) as _i6.Future<List<_i4.AllergenModel>>);

  @override
  _i6.Future<_i4.AllergenModel> postNewAllergen(String? allergenName) =>
      (super.noSuchMethod(
        Invocation.method(
          #postNewAllergen,
          [allergenName],
        ),
        returnValue: _i6.Future<_i4.AllergenModel>.value(_FakeAllergenModel_2(
          this,
          Invocation.method(
            #postNewAllergen,
            [allergenName],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i4.AllergenModel>.value(_FakeAllergenModel_2(
          this,
          Invocation.method(
            #postNewAllergen,
            [allergenName],
          ),
        )),
      ) as _i6.Future<_i4.AllergenModel>);
}
