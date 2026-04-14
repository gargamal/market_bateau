// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:select_bateau/features/ship/presentation/widgets/list_ship_usecase.dart'
    as _select_bateau_features_ship_presentation_widgets_list_ship_usecase;
import 'package:select_bateau/features/ship/presentation/widgets/ship_usecase.dart'
    as _select_bateau_features_ship_presentation_widgets_ship_usecase;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'features',
    children: [
      _widgetbook.WidgetbookFolder(
        name: 'ship',
        children: [
          _widgetbook.WidgetbookFolder(
            name: 'presentation',
            children: [
              _widgetbook.WidgetbookFolder(
                name: 'widgets',
                children: [
                  _widgetbook.WidgetbookComponent(
                    name: 'ListShipWidget',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Data Loaded (10 ships)',
                        builder:
                            _select_bateau_features_ship_presentation_widgets_list_ship_usecase
                                .buildListShipData,
                      ),
                      _widgetbook.WidgetbookUseCase(
                        name: 'Loading State',
                        builder:
                            _select_bateau_features_ship_presentation_widgets_list_ship_usecase
                                .buildListShipLoading,
                      ),
                    ],
                  ),
                  _widgetbook.WidgetbookComponent(
                    name: 'ShipWidget',
                    useCases: [
                      _widgetbook.WidgetbookUseCase(
                        name: 'Default State',
                        builder:
                            _select_bateau_features_ship_presentation_widgets_ship_usecase
                                .buildShipWidgetUseCase,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
