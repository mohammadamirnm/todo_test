import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/src/exceptions/failure.dart';

class TodoRequestFailed implements Failure {
  @override
  String? get message => 'label_network_failure'.tr();
}
