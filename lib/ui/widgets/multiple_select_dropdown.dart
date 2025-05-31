import 'dart:math'; // Added for min function

import 'package:flutter/material.dart';

class MultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final Function(List<T>) onSelectionChanged;
  final String hint;
  final String Function(T) displayStringForOption;
  final List<T> initialSelectedItems; // Added for initial selection

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.onSelectionChanged,
    required this.displayStringForOption,
    this.hint = 'Select items',
    this.initialSelectedItems = const [], // Default to empty list
  });

  @override
  MultiSelectDropdownState<T> createState() => MultiSelectDropdownState<T>();
}

class MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  List<T> _selectedItems = [];
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  // Constants for layout calculation
  static const double _kDefaultItemHeight =
      56.0; // Approximate height of a CheckboxListTile
  static const double _kDropdownMaxHeight =
      200.0; // Max height of the dropdown overlay
  static const double _kDropdownVerticalPadding =
      5.0; // Padding between widget and overlay
  static const int _kMinItemsToDisplayBelow = 3;

  @override
  void initState() {
    super.initState();
    _selectedItems = List<T>.from(widget.initialSelectedItems);
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay(BuildContext context) {
    _removeOverlay(); // Remove any existing overlay

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    final spaceBelow = screenSize.height - position.dy - size.height;
    final spaceAbove = position.dy;

    final double estimatedListHeight =
        widget.items.length * _kDefaultItemHeight;
    final double dropdownActualHeight =
        min(estimatedListHeight, _kDropdownMaxHeight);

    final double requiredSpaceForMinItems =
        _kMinItemsToDisplayBelow * _kDefaultItemHeight;

    bool openUpwards = false;
    // Decide to open upwards if:
    // 1. Space below is less than what's needed for _kMinItemsToDisplayBelow items, AND
    // 2. Space below is less than the actual dropdown height (it would be clipped anyway), AND
    // 3. There's more (or equal) space above than the dropdownActualHeight OR
    //    (Space above is greater than space below AND space above can show at least 1 item)
    if (spaceBelow < requiredSpaceForMinItems &&
        spaceBelow < dropdownActualHeight) {
      if (spaceAbove >= dropdownActualHeight ||
          (spaceAbove > spaceBelow && spaceAbove >= _kDefaultItemHeight)) {
        openUpwards = true;
      }
    }

    Offset overlayOffset;
    if (openUpwards) {
      overlayOffset =
          Offset(0.0, -dropdownActualHeight - _kDropdownVerticalPadding);
    } else {
      overlayOffset = Offset(0.0, size.height + _kDropdownVerticalPadding);
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: overlayOffset,
          child: Material(
            elevation: 4.0,
            child: Container(
              height: dropdownActualHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey),
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final item = widget.items[index];
                  return CheckboxListTile(
                    title: Text(widget.displayStringForOption(item)),
                    value: _selectedItems.contains(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          if (!_selectedItems.contains(item)) {
                            _selectedItems.add(item);
                          }
                        } else {
                          _selectedItems.remove(item);
                        }
                        widget.onSelectionChanged(List<T>.from(_selectedItems));
                      });
                      _overlayEntry
                          ?.markNeedsBuild(); // Rebuild overlay for checkbox changes
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay(context);
    }
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 10), // Adjusted padding
          decoration: BoxDecoration(
            border: Border.all(
              color: _isOpen ? Theme.of(context).primaryColor : Colors.grey,
            ), // Highlight when open
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _selectedItems.isEmpty
                      ? widget.hint
                      : _selectedItems
                          .map(widget.displayStringForOption)
                          .join(', '),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _selectedItems.isEmpty ? Colors.grey.shade700 : null,
                  ),
                ),
              ),
              Icon(_isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
