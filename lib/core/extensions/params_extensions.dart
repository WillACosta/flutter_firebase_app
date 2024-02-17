import '../../features/chat/chat.dart';
import '../../presentation/params/params.dart';

extension ParamsExtensions on ChannelModel {
  ChannelUiParams toUiParams() {
    return ChannelUiParams(
      members: members,
      description: description,
      image: image,
      name: name,
      type: type,
    );
  }
}
