enum ChannelType {
  text,
  voice,
}

extension ChannelTypeExtension on ChannelType {
  static const Map<ChannelType, int> _values = {
    ChannelType.text: 1,
    ChannelType.voice: 2,
  };

  static const Map<int, ChannelType> _fromValues = {
    1: ChannelType.text,
    2: ChannelType.voice,
  };

  int get value => _values[this]!;
  static ChannelType fromValue(int value) => _fromValues[value]!;
}
