import 'dart:convert';
import "dart:io";

import 'Configs.dart';

String executableFile = 'C:/Users/IamProgrammerLK/AppData/Roaming/RClone/rclone.exe';

main(List<String> args) {
  print("\n");
  print("+-------------------------------------------------------------------+");
  print("|                           Auto Clone CLI                          |");
  print("+-------------------------------------------------------------------+");
  print("\n");

  List bucketList = getBucketList();
  bucketList.forEach((element) {
    // List<String> executableArgs = ['sync', element[1], element[2], '--progress', '--create-empty-src-dirs', '--check-first', '--fast-list'];

    runRclone(element[0], element[1], element[2]);
  });
}

void runRclone(String bucketName, String source, String destination) {
  List<String> executableArgs = ['sync', source, destination, '--progress', '--create-empty-src-dirs', '--check-first', '--fast-list'];
  Process.start(executableFile, executableArgs, runInShell: true).then((Process process) {
    process.stdout.transform(Utf8Decoder()).listen((output) {
      print("\n");
      print("+-------------------------------------------------------------------+");
      print(bucketName);
      print(output);
      print("+-------------------------------------------------------------------+");
      print("\n");
      Process.killPid(process.pid);
    });
  });
}
