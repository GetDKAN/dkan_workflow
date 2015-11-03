core = 7.x
api = 2

; @TODO remove this dependency if required by dkan core.
projects[features_roles_permissions][version] = 1.2
projects[features_roles_permissions][subdir] = contrib

; Workbench and related modules.
projects[workbench][version] = 1.2
projects[workbench][subdir] = contrib

projects[workbench_moderation][version] = 1.4
projects[workbench_moderation][subdir] = contrib
projects[workbench_moderation][patch][2393771] = https://www.drupal.org/files/issues/specify_change_state_user-2393771-5.patch
projects[workbench_moderation][patch][1838640] = https://www.drupal.org/files/issues/workbench_moderation-fix_callback_argument-1838640-23.patch

projects[workbench_email][version] = 3.4
projects[workbench_email][subdir] = contrib
projects[workbench_email][patch][2391233] = https://www.drupal.org/files/issues/workbench_email-2391233-3.patch
projects[workbench_email][patch][2529016] = https://www.drupal.org/files/issues/workbench_email-skip_filter_anonymous-2529016.patch

; Menu Badge features.
projects[menu_badges][version] = 1.2
projects[menu_badges][subdir] = contrib

projects[link_badges][version] = 1.1
projects[link_badges][subdir] = contrib
