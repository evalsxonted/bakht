
class Failure {
  final String messageToShow;
  final String? messageToDev;
  Failure(this.messageToShow, this.messageToDev);
  @override
  String toString() => messageToShow;
}

