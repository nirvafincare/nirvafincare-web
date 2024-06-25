import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateProvider<double> xProvider = StateProvider<double>((_) => 0.0);

final StateProvider<double> yProvider = StateProvider<double>((_) => 0.0);

final StateProvider<bool> visibilityProvider = StateProvider<bool>((_) => false);