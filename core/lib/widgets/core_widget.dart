part of '../core.dart';

abstract class CoreWidget<C extends CoreCubit<S>, S extends CoreState,
    A extends Cubit<AppCoreState>> extends StatefulWidget {
  final AppTheme? theme;
  final Widget? loadingWidget;
  final C? bloc;

  const CoreWidget({
    Key? key,
    this.bloc,
    this.theme,
    this.loadingWidget,
  }) : super(key: key);

  @protected
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr);

  @protected
  void onError(String errorMessage) {}

  @protected
  @mustCallSuper
  void onInit(BuildContext context) {}

  @protected
  @mustCallSuper
  void onDispose(BuildContext context) {}

  @protected
  @mustCallSuper
  void onDidChangeDependencies(BuildContext context) {}

  @protected
  @mustCallSuper
  void onDidUpdateWidget(BuildContext context) {}

  @override
  State<CoreWidget<C, S, A>> createState() => _CoreWidgetState<C, S, A>();
}

class _CoreWidgetState<C extends CoreCubit<S>, S extends CoreState, A extends Cubit<AppCoreState>>
    extends State<CoreWidget<C, S, A>> {
  C? bloc;

  @override
  void initState() {
    widget.onInit(context);
    if (C != CoreCubit<CoreState>) {
      bloc = widget.bloc ?? context.read<C>();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? context.watch<A>().state.theme;
    final t = Utils.languageOf(context);
    return Stack(
      children: [
        widget.build(context, theme, t),
        if (C != CoreCubit<CoreState>)
          BlocConsumer<C, S>(
            bloc: bloc,
            listener: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                widget.onError(state.errorMessage);
              }
            },
            listenWhen: (previous, current) => previous.errorMessage != current.errorMessage,
            buildWhen: (previous, current) => previous.isLoading != current.isLoading,
            builder: (context, state) {
              if (state.isLoading) {
                return _showLoading(theme);
              }
              return const SizedBox();
            },
          ),
      ],
    );
  }

  Widget _showLoading(AppTheme? theme) {
    return Stack(
      children: [
        ModalBarrier(
          color: Colors.black.withOpacity(0.08),
          dismissible: false,
        ),
        Center(
          child: widget.loadingWidget ??
              LoadingWidget(
                color: theme?.colors.primary ?? Colors.black,
              ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.onDispose(context);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    widget.onDidChangeDependencies(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CoreWidget<C, S, A> oldWidget) {
    widget.onDidUpdateWidget(context);
    super.didUpdateWidget(oldWidget);
  }
}
