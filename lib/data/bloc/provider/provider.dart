import 'package:flutter/material.dart';
import 'package:todo/util/abstracts/disposable.dart';

class Provider<T extends Disposable> extends InheritedWidget {
  final T bloc;

  Provider({Key key, Widget child, this.bloc}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static T of<T extends Disposable>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider<T>>()?.bloc;
  }
}

class BlocProvider<T extends Disposable> extends StatefulWidget {
  final T Function() blocSource;
  final void Function(T) onInit;
  final void Function(T) onDispose;
  final Widget Function(BuildContext context, T bloc) builder;

  BlocProvider({
    Key key,
    @required this.blocSource,
    @required this.builder,
    this.onInit,
    this.onDispose,
  }):super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends Disposable> extends State<BlocProvider<T>> {
  T bloc;

  @override
  void initState() {
    bloc = widget.blocSource();
    widget.onInit?.call(bloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
        bloc: bloc,
        child: Builder(builder: (BuildContext context) {
          return widget.builder(context, bloc);
        }));
  }

  @override
  void dispose() {
    //bloc.dispose();
    widget.onDispose?.call(bloc);
    super.dispose();
  }
}
