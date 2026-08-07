import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_profile_photo.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_action_bar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_form_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD EditProfile screen (Profile → Edit).
class CustomerEditProfileScreen extends ConsumerStatefulWidget {
  const CustomerEditProfileScreen({super.key});

  @override
  ConsumerState<CustomerEditProfileScreen> createState() =>
      _CustomerEditProfileScreenState();
}

class _CustomerEditProfileScreenState
    extends ConsumerState<CustomerEditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  var _isSaving = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(userProfileProvider);
    final isAr = ref.read(appLocaleProvider).languageCode == 'ar';
    _nameController = TextEditingController(text: profile.displayName(isAr));
    _emailController = TextEditingController(text: profile.email);
    _phoneController = TextEditingController(text: profile.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final avatarUrl = ref.watch(userProfileProvider).avatarUrl;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsScaffoldPage(
      title: l10n.screenEditProfile,
      bottomSheet: WidgetsActionBar(
        primary: WidgetsAppButton(
          label: l10n.actionSave,
          onPressed: _isSaving ? null : () => _save(context, isAr),
          icon: Icons.save_outlined,
          fullWidth: true,
        ),
      ),
      child: ListView(
        padding: EdgeInsetsDirectional.only(
          top: CoreSpacing.md(context),
          bottom: CoreSpacing.xxl(context) * 3,
        ),
        children: [
          WidgetsPageHeader(
            title: l10n.screenEditProfile,
            subtitle: l10n.profileEditDetails,
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Center(
            child: WidgetsFormCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Semantics(
                      button: true,
                      label: l10n.profileChangePhoto,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          UtilityProfilePhoto.presentPicker(
                            context,
                            hasExistingPhoto:
                                avatarUrl != null && avatarUrl.isNotEmpty,
                            onAvatarChanged:
                                (url) =>
                                    ref
                                        .read(userProfileProvider.notifier)
                                        .setAvatarUrl(url),
                          );
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            WidgetsAvatar(
                              icon: Icons.person_outline,
                              imageUrl: avatarUrl,
                              radius: CoreContentSizes.profileAvatarRadius(
                                context,
                              ),
                            ),
                            Material(
                              color: scheme.primary,
                              shape: const CircleBorder(),
                              elevation: 2,
                              child: SizedBox.square(
                                dimension:
                                    CoreContentSizes.profileAvatarEditBadge(
                                      context,
                                    ),
                                child: Icon(
                                  Icons.photo_camera_outlined,
                                  color: scheme.onPrimary,
                                  size: CoreContentSizes.profileAvatarEditIcon(
                                    context,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: CoreSpacing.lg(context)),
                  WidgetsAppTextField(
                    controller: _nameController,
                    label: l10n.fieldName,
                    prefixIcon: Icons.person_outline,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsAppTextField(
                    controller: _emailController,
                    label: l10n.fieldEmail,
                    prefixIcon: Icons.alternate_email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: CoreSpacing.md(context)),
                  WidgetsAppTextField(
                    controller: _phoneController,
                    label: l10n.fieldPhone,
                    prefixIcon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _save(BuildContext context, bool isAr) async {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      UtilityMockFeedback.showError(context, l10n.mapRequiredFields);
      return;
    }

    if (!email.contains('@')) {
      UtilityMockFeedback.showError(context, l10n.fieldEmail);
      return;
    }

    setState(() => _isSaving = true);
    ref
        .read(userProfileProvider.notifier)
        .updateProfile(
          displayNameAr: name,
          displayNameEn: name,
          email: email,
          phone: phone,
        );
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (!context.mounted) return;
    setState(() => _isSaving = false);
    UtilityMockFeedback.showSuccess(context, l10n.actionSave);
    context.pop();
  }
}
