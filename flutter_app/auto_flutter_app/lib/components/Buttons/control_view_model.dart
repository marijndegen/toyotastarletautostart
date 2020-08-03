class ControlViewModel {
  final void Function() executeButtonFuction;

  ControlViewModel(this.executeButtonFuction);

  static ControlViewModel withExecuteFunction(executeButtonFuction) {
      return ControlViewModel(
        executeButtonFuction
      );
  }
}