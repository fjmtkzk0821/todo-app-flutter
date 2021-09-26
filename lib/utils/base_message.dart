class BaseMessage {
  MessageType type;
  String title, desc;
  Function action;

  BaseMessage(this.type, {this.title, this.desc, this.action});

}

enum MessageType {
  LOADING,
  SUCCESS,
  ERROR,
  WARNING,
  DIALOG
}