/// Payload for creating a saved address — mirrors future POST /addresses body.
class ModelCreateAddressRequest {
  const ModelCreateAddressRequest({
    required this.label,
    required this.addressLine,
    this.iconKey = 'home',
    this.setAsDefault = false,
  });

  final String label;
  final String addressLine;
  final String iconKey;
  final bool setAsDefault;
}
