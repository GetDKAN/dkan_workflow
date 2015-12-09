core = 7.x
api = 2

projects[entityreference_unpublished_node][download][type] = git
projects[entityreference_unpublished_node][download][url] = "http://git.drupal.org/sandbox/Ayrmax/1977458.git"
projects[entityreference_unpublished_node][subdir] = contrib
projects[entityreference_unpublished_node][type] = module

; @TODO remove this dependency if required by dkan core.
projects[features_roles_permissions][version] = 1.2
projects[features_roles_permissions][subdir] = contrib

projects[menu_admin_per_menu][version] = 1.0
projects[menu_admin_per_menu][subdir] = contrib

projects[view_unpublished][version] = 1.x-dev
projects[view_unpublished][subdir] = contrib

projects[workbench][version] = 1.2
projects[workbench][subdir] = contrib

projects[workbench_moderation][version] = 1.4
projects[workbench_moderation][subdir] = contrib
projects[workbench_moderation][patch][2393771] = https://www.drupal.org/files/issues/specify_change_state_user-2393771-5.patch
projects[workbench_moderation][patch][1838640] = https://www.drupal.org/files/issues/workbench_moderation-fix_callback_argument-1838640-23.patch

projects[workbench_email][version] = 3.4
projects[workbench_email][subdir] = contrib
projects[workbench_email][patch][2391233] = https://www.drupal.org/files/issues/workbench_email-2391233-3.patch

projects[menu_badges][version] = 1.2
projects[menu_badges][subdir] = contrib

projects[link_badges][version] = 1.1
projects[link_badges][subdir] = contrib
