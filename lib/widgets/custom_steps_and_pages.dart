import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MultiStepWidget extends StatefulWidget {
  const MultiStepWidget({super.key});

  @override
  _MultiStepWidgetState createState() => _MultiStepWidgetState();
}

class _MultiStepWidgetState extends State<MultiStepWidget> {
  int _currentStep = 0;
  List<StepState> states = List.generate(
      5, (index) => index == 0 ? StepState.indexed : StepState.editing);

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final List<Step> _steps = [
      Step(
          title: Text('Personal Info $_currentStep'),
          content: Container(
            child: const Column(
              children: [
                CustomInput(
                  hint: "First Name",
                  inputBorder: OutlineInputBorder(),
                ),
                CustomInput(
                  hint: "Last Name",
                  inputBorder: OutlineInputBorder(),
                ),
                CustomInput(
                  hint: "Address",
                  inputBorder: OutlineInputBorder(),
                ),
                CustomInput(
                  hint: "City and State",
                  inputBorder: OutlineInputBorder(),
                ),
                CustomInput(
                  hint: "Bio",
                  inputBorder: OutlineInputBorder(),
                ),
                CustomInput(
                  hint: "Bio",
                  inputBorder: OutlineInputBorder(),
                ),
              ],
            ),
          ),
          isActive: true,
          state: states[0]),
      Step(
          title: const Text('Address'),
          content: const Text('Address Form Goes Here'),
          isActive: true,
          state: states[1] // Show a skip button for this step
          ),
      Step(
        title: const Text('Bank Details'),
        content: const Text('Bank Details Form Goes Here'),
        isActive: true,
        state: states[2], // Show a skip button for this step
      ),
      Step(
        title: const Text('Notification Details'),
        content: const Text('Notification Details Form Goes Here'),
        isActive: true,
        state: states[3], // Show a skip button for this step
      ),
      Step(
        title: const Text('Permissions'),
        content: const Text('Permissions Form Goes Here'),
        isActive: true,
        state: states[4], // Show a skip button for this step
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Registration Form ')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0),
            child: StepProgressView(
                width: double.maxFinite,
                curStep: _currentStep,
                color: const Color(0xff50AC02),
                titles: const [
                  'Personal Info',
                  'Address',
                  'Bank Details',
                  'Notification Details',
                  'Permissions'
                ]),
          ),
          Expanded(
            child: Stepper(
              physics: const ClampingScrollPhysics(),
              type: StepperType.vertical,
              currentStep: _currentStep,
              onStepTapped: onStepTap,
              onStepContinue: next,
              onStepCancel: previous,
              steps: _steps,
              elevation: 0,
              controlsBuilder: controlsBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget controlsBuilder(BuildContext context, ControlsDetails details) {
    return Row(
      children: [
        FilledButton(
            onPressed: next,
            child: Text(_currentStep < states.length - 1 ? 'Next' : 'Submit')),
        const SizedBox(width: 10),
        if (_currentStep > 0 && _currentStep < states.length - 1)
          FilledButton(
            onPressed: previous,
            child: const Text('Previous'),
          ),
      ],
    );
  }

  next() {
    if (_currentStep < states.length - 1) {
      setState(() {
        states[_currentStep] = StepState.complete;
        _currentStep++;
      });
    } else {
      // Handle final registration logic here
      // E.g., submit the data to a server, etc.
    }
  }

  previous() {
    if (_currentStep > 0) {
      setState(() {
        states[_currentStep] = StepState.editing;
        _currentStep--;
      });
    }
  }

  onStepTap(index) {
    setState(() {
      _currentStep = index;
      states[_currentStep] = StepState.editing;
    });
  }
}

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  final InputBorder? inputBorder;
  const CustomInput({Key? key, this.onChanged, this.hint, this.inputBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 10),
      child: TextField(
        onChanged: (v) => onChanged!(v),
        decoration: InputDecoration(hintText: hint!, border: inputBorder),
      ),
    );
  }
}

class StepProgressView extends StatelessWidget {
  final double _width;

  final List<String> _titles;
  final int _curStep;
  final Color _activeColor;
  final Color _inactiveColor = HexColor("#E6EEF3");
  final Color _editingColor = Color(0xFFEFB72C);
  final double lineWidth = 3.0;

  StepProgressView(
      {Key? key,
      required int curStep,
      required List<String> titles,
      required double width,
      required Color color})
      : _titles = titles,
        _curStep = curStep,
        _width = width,
        _activeColor = color,
        assert(width > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, layout) {
      return SizedBox(
          width: layout.maxWidth,
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _titleViews(layout.maxWidth)),
              const SizedBox(height: 8),
              Row(children: _iconViews()),
            ],
          ));
    });
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    _titles.asMap().forEach((i, icon) {
      var circleColor = (i == _curStep)
          ? _editingColor
          : (_curStep > i ? _activeColor : _inactiveColor);
      var lineColor = _curStep > i ? _activeColor : _inactiveColor;
      var iconColor = (i == _curStep)
          ? _editingColor
          : (_curStep > i ? _activeColor : _inactiveColor);

      list.add(
        Container(
          width: 20.0,
          height: 20.0,
          padding: const EdgeInsetsDirectional.all(0),
          decoration: BoxDecoration(
            /* color: circleColor,*/
            borderRadius: const BorderRadius.all(Radius.circular(22.0)),
            border: Border.all(color: circleColor, width: 2.0),
          ),
          child: Icon(Icons.circle, color: iconColor, size: 12.0),
        ),
      );

      //line between icons
      if (i != _titles.length - 1) {
        list.add(
            Expanded(child: Container(height: lineWidth, color: lineColor)));
      }
    });

    return list;
  }

  List<Widget> _titleViews(double width) {
    var list = <Widget>[];
    _titles.asMap().forEach((i, text) {
      list.add(Container(
        // color: HexColor("#${i}00000"),
        width: width / _titles.length,
        child: Text(text,
            style: TextStyle(color: HexColor("#000000"), fontSize: 8),
            textAlign: TextAlign.start,
            maxLines: 1),
      ));
    });
    return list;
  }
}
