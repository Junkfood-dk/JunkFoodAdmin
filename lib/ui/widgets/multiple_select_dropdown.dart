import 'package:flutter/material.dart';

class MultiSelectDropdown<T> extends StatefulWidget {
  final List<T> items;
  final Function(List<T>) onSelectionChanged;
  final String hint;
  final String Function(T) displayStringForOption;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.onSelectionChanged,
    required this.displayStringForOption,
    this.hint = 'Select items',
  });

  @override
  MultiSelectDropdownState<T> createState() => MultiSelectDropdownState<T>();
}

class MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  List<T> selectedItems = [];
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool isOpen = false;

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void _showOverlay(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4.0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                // color: Colors.white,
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
                    value: selectedItems.contains(item),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          selectedItems.add(item);
                        } else {
                          selectedItems.remove(item);
                        }
                        widget.onSelectionChanged(selectedItems);
                      });
                      _overlayEntry?.markNeedsBuild();
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
    if (isOpen) {
      _overlayEntry?.remove();
    } else {
      _showOverlay(context);
    }
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: _toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedItems.isEmpty
                      ? widget.hint
                      : selectedItems
                          .map(widget.displayStringForOption)
                          .join(', '),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
