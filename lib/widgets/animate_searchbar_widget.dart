import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/utils/default_logger.dart';

class AnimSearchBar extends StatefulWidget {
  final double width;
  final double height;
  final TextEditingController textController;
  final Icon? suffixIcon;
  final Icon? prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final Null Function(int? val) onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle? style;
  final bool closeSearchOnSuffixTap;
  final Color? color;
  final Color? textFieldColor;
  final Color? searchIconColor;
  final Color? textFieldIconColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool boxShadow;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final Function(int) searchBarOpen;
  final Function(int) onBack;
  const AnimSearchBar({
    Key? key,

    /// The width cannot be null
    required this.width,
    required this.searchBarOpen,

    /// The textController cannot be null
    required this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.helpText = "Search...",

    /// Height of wrapper container
    this.height = 100,

    /// choose your custom color
    this.color = Colors.white,

    /// choose your custom color for the search when it is expanded
    this.textFieldColor = Colors.white,

    /// choose your custom color for the search when it is expanded
    this.searchIconColor = Colors.black,

    /// choose your custom color for the search when it is expanded
    this.textFieldIconColor = Colors.black,
    this.textInputAction = TextInputAction.done,

    /// The onSuffixTap cannot be null
    required this.onSuffixTap,
    this.animationDurationInMilli = 375,

    /// The onSubmitted cannot be null
    required this.onSubmitted,

    /// make the search bar to open from right to left
    this.rtl = false,

    /// make the keyboard to show automatically when the searchbar is expanded
    this.autoFocus = false,

    /// TextStyle of the contents inside the searchbar
    this.style,

    /// close the search on suffix tap
    this.closeSearchOnSuffixTap = false,

    /// enable/disable the box shadow decoration
    this.boxShadow = true,

    /// can add list of input formatters to control the input
    this.inputFormatters,
    required this.onBack,
  }) : super(key: key);

  @override
  _AnimSearchBarState createState() => _AnimSearchBarState();
}

class _AnimSearchBarState extends State<AnimSearchBar>
    with SingleTickerProviderStateMixin {
  ///toggle - 0 => false or closed
  ///toggle 1 => true or open
  int toggle = 0;

  /// * use this variable to check current text from OnChange
  String textFieldValue = '';

  ///initializing the AnimationController
  late AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _con = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
    if (widget.textController.text.isNotEmpty) {
      setState(() {
        toggle = 1;
      });
    }
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void dispose() {
    _con.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        infoLog(toggle.toString(), 'WillPopScope');
        if (toggle == 1) {
          unfocusKeyboard();
          setState(() {
            toggle = 0;
          });
          // widget.textController.clear();
          textFieldValue = '';
          _con.reverse();
          widget.onBack(toggle);
          return false;
        } else {
          _con.reverse();
          widget.onBack(toggle);
          return true;
        }
      },
      child: Container(
        height: widget.height,

        ///if the rtl is true, search bar will be from right to left
        alignment:
            widget.rtl ? Alignment.centerRight : const Alignment(-1.0, 0.0),

        ///Using Animated container to expand and shrink the widget
        child: AnimatedContainer(
          duration: Duration(milliseconds: widget.animationDurationInMilli),
          height: widget.height,
          width: (toggle == 0) ? 48.0 : widget.width,
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            /// can add custom  color or the color will be white
            // color: toggle == 1 ? widget.textFieldColor : widget.color,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30.0),

            /// show boxShadow unless false was passed
            boxShadow: !widget.boxShadow
                ? null
                : [
                    const BoxShadow(
                      color: Colors.black26,
                      spreadRadius: -10.0,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
          ),
          child: Stack(
            children: [
              ///Using Animated Positioned widget to expand and shrink the widget
              AnimatedPositioned(
                duration:
                    Duration(milliseconds: widget.animationDurationInMilli),
                top: 0,
                bottom: 0,
                right: 7.0,
                curve: Curves.easeOut,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      opacity: (toggle == 0) ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          /// can add custom color or the color will be white
                          color: widget.color,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: AnimatedBuilder(
                          builder: (context, widget) {
                            ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                            return Transform.rotate(
                              angle: _con.value * 2.0 * pi,
                              child: widget,
                            );
                          },
                          animation: _con,
                          child: GestureDetector(
                            onTap: () {
                              try {
                                ///trying to execute the onSuffixTap function
                                widget.onSuffixTap(null);

                                // * if field empty then the user trying to close bar
                                if (textFieldValue == '') {
                                  unfocusKeyboard();
                                  setState(() {
                                    toggle = 0;
                                  });

                                  ///reverse == close
                                  _con.reverse();
                                  widget.onSuffixTap(toggle);
                                }

                                // * why not clear text-field here?
                                widget.textController.clear();
                                textFieldValue = '';

                                ///closeSearchOnSuffixTap will execute if it's true
                                if (widget.closeSearchOnSuffixTap) {
                                  unfocusKeyboard();
                                  setState(() {
                                    toggle = 0;
                                  });
                                }
                              } catch (e) {
                                ///logD(data) the error if the try block fails
                                logD(e.toString());
                              }
                            },

                            ///suffixIcon is of type Icon
                            child: widget.suffixIcon ??
                                Icon(
                                  Icons.close,
                                  size: 20.0,
                                  color: widget.textFieldIconColor,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration:
                    Duration(milliseconds: widget.animationDurationInMilli),
                left: (toggle == 0) ? 20.0 : 40.0,
                curve: Curves.easeOut,
                top: 11.0,

                ///Using Animated opacity to change the opacity of th textField while expanding
                child: AnimatedOpacity(
                  opacity: (toggle == 0) ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: widget.width * 0.7,
                    child: TextField(
                      ///Text Controller. you can manipulate the text inside this textField by calling this controller.
                      controller: widget.textController,
                      inputFormatters: widget.inputFormatters,
                      focusNode: focusNode,
                      textInputAction: widget.textInputAction,
                      cursorWidth: 2.0,

                      onChanged: (value) {
                        textFieldValue = value;
                      },
                      onSubmitted: (value) => {
                        widget.onSubmitted(value),
                        unfocusKeyboard(),
                        setState(() {
                          toggle = 0;
                        }),
                        // widget.textController.clear(),
                      },
                      onEditingComplete: () {
                        /// on editing complete the keyboard will be closed and the search bar will be closed
                        unfocusKeyboard();
                        setState(() {
                          toggle = 0;
                          widget.onBack(toggle);
                        });
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: widget.helpText,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///Using material widget here to get the ripple effect on the prefix icon
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    /// can add custom color or the color will be white
                    /// toggle button color based on toggle state
                    // color: toggle == 0 ? widget.color : widget.textFieldColor,
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: IconButton(
                      splashRadius: 19.0,

                      ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                      ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                      ///prefixIcon is of type Icon
                      icon: widget.prefixIcon != null
                          ? toggle == 1
                              ? const Icon(Icons.arrow_back_ios)
                              : widget.prefixIcon!
                          : Icon(
                              toggle == 1 ? Icons.arrow_back_ios : Icons.search,
                              size: 20.0,
                            ),
                      onPressed: () {
                        setState(
                          () {
                            ///if the search bar is closed
                            if (toggle == 0) {
                              toggle = 1;
                              setState(() {
                                ///if the autoFocus is true, the keyboard will pop open, automatically
                                if (widget.autoFocus) {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode);
                                }
                              });

                              ///forward == expand
                              _con.forward();
                            } else {
                              ///if the search bar is expanded
                              toggle = 0;

                              ///if the autoFocus is true, the keyboard will close, automatically
                              setState(() {
                                if (widget.autoFocus) unfocusKeyboard();
                              });

                              ///reverse == close
                              _con.reverse();
                            }
                          },
                        );
                        widget.searchBarOpen(toggle);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
