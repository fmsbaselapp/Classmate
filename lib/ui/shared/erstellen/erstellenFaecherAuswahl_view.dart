import 'package:Classmate/models/models.dart';
import 'package:Classmate/services/services.dart';
import 'package:Classmate/ui/shared/export.dart';

import 'package:Classmate/ui/views/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErstellenFaecherAuswahlView extends StatelessWidget {
  const ErstellenFaecherAuswahlView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build: FaecherAuswahl');

    return ViewModelBuilder<ErstellenViewModel>.reactive(
        disposeViewModel: false,
        builder: (context, model, child) => Container(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: ExpandableListTile(
                onExpandPressed: () {
                  model.faecherAuswahlController();
                },
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: model.isFachSelected
                          ? IconFach(
                              size: 30,
                              farbe: model.selectedFach.farbe,
                              icon: model.selectedFach.icon)
                          : Wrap(),
                    ),
                    model.isFachSelected
                        ? Text(model.selectedFach.name,
                            style: Theme.of(context).textTheme.headline2)
                        : Text(
                            'Fach wählen',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(color: Theme.of(context).hintColor),
                          )
                  ],
                ),
                expanded: model.isExpanded,
                child: null,
              ),
            ),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}

class ExpandableListTile extends StatelessWidget {
  const ExpandableListTile(
      {Key key, this.title, this.expanded, this.onExpandPressed, this.child})
      : super(key: key);

  final Widget title;
  final bool expanded;
  final Widget child;
  final Function onExpandPressed;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        contentPadding: EdgeInsets.only(left: 10),
        title: title,
        onTap: onExpandPressed,
        trailing: IconButton(
          onPressed: onExpandPressed,
          // icon: Icon(Icons.expand_more),
          icon: RotatableSection(
              rotated: expanded,
              child: SizedBox(
                height: 30,
                width: 30,
                child: Icon(
                  Icons.expand_more_rounded,
                  size: 30,
                  color: Theme.of(context).hintColor,
                ),
              )),
        ),
      ),
      ExpandableSection(
        child: child,
        expand: expanded,
      )
    ]);
  }
}

class ExpandableSection extends StatefulWidget {
  final Widget child;
  final bool expand;

  ExpandableSection({
    this.expand = false,
    this.child,
  });

  @override
  _ExpandableSectionState createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> sizeAnimation;
  Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    sizeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutBack,
    );
    opacityAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.slowMiddle,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandableSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErstellenViewModel>.nonReactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => FadeTransition(
            opacity: opacityAnimation,
            child: SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: sizeAnimation,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  model.hasData
                      ? ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: model.faecher.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 15,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            Fach fach = model.faecher[index];
                            return InkWell(
                              onTap: () {
                                model.fachSelect(fach);
                              },
                              child: FachUIerstellen(
                                fach: fach.name,
                                icon: fach.icon,
                                farbe: fach.farbe,
                              ),
                            );
                          },
                        )
                      : Wrap(),
                  SizedBox(
                    height: 15,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text('Fach erstellen'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )),
        viewModelBuilder: () => locator<ErstellenViewModel>());
  }
}

class RotatableSection extends StatefulWidget {
  final Widget child;
  final bool rotated;
  final double initialSpin;
  final double endingSpin;
  RotatableSection(
      {this.rotated = false,
      this.child,
      this.initialSpin = 0.75,
      this.endingSpin = 1});

  @override
  _RotatableSectionState createState() => _RotatableSectionState();
}

class _RotatableSectionState extends State<RotatableSection>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runCheck();
  }

  final double _oneSpin = 6.283184;

  ///Setting up the animation
  void prepareAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: _oneSpin * widget.initialSpin,
      upperBound: _oneSpin * widget.endingSpin,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
  }

  void _runCheck() {
    if (widget.rotated) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(RotatableSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runCheck();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (BuildContext context, Widget _widget) {
        return new Transform.rotate(
          angle: animationController.value,
          child: _widget,
        );
      },
    );
  }
}
