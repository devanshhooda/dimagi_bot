class Constants {
  Constants._();

  static const String chatMessagesList = 'chat_messages_list';
  static const String employeesData = 'employees_data';
  static const String messages = 'messages';
  static const receiver = 'receiver';
  static const sender = 'sender';
  static const location = 'location';

  static const String pingMessage =
      "Hey! How's is it going, ask anything I am here to help you.";

  static const String helpMessage = '''	
    ping - test if the bot is active
    help - display help; args: [command]
    hereiam - update your whereis location; args: [first name] [current location]
    say - say text aloud; args: text
    whereis - locate an employee; args: [first name] 
    ''';

  static const String errorMessage =
      "Sorry but that command wasn't recogonized, please try again. Kindly refer 'help' for more.";

  static const String argumentsError = "Please provide arguments properly :)";

  static const String dataNotFound = "Data not found, please try again";
}
