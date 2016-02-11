(function ($) {
    Drupal.behaviors.checkbox = {
        // Enforce role pairings defined in dkan_workflow_permissions_form_user_profile_form_alter()
        attach: function(context, settings) {
            $('#edit-roles').find('.form-checkbox').on('click', function(event) {
                rolePairings = settings.dkan_workflow_permissions.rolePairings;
                var clickedRole = $(this).val();
                var isChecked = $(this)[0].checked;
                if (clickedRole in rolePairings) {
                    // The paired role should have the same checked property as the clicked role
                    $("#edit-roles-" + rolePairings[clickedRole]).prop('checked', isChecked)
                        // Coincidentally, the "disabled" attribute should be identical
                        .attr("disabled", isChecked);
                }
            });
        }
    }
})(jQuery);
