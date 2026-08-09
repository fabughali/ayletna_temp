/// Payload for creating a saved address — mirrors future POST /addresses body.
class ModelCreateAddressRequest {
  const ModelCreateAddressRequest({
    required this.label,
    required this.addressLine,
    this.iconKey = 'home',
    this.setAsDefault = false,
    this.contactName,
    this.phone,
    this.building,
    this.floor,
    this.accessCode,
    this.customerAccountId,
  });

  final String label;
  final String addressLine;
  final String iconKey;
  final bool setAsDefault;
  final String? contactName;
  final String? phone;
  final String? building;
  final String? floor;
  final String? accessCode;
  final String? customerAccountId;
}
