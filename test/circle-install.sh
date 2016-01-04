#!/bin/bash
# Make sure an error during execution gets passed along to circleCI
set -e
# Do full installation.
echo "===> Cached databases not configured. Installing from scratch."
echo "drush si dkan --sites-subdir=default --db-url=$DATABASE_URL --account-name=admin --account-pass=admin  --site-name="DKAN Workflow QA" install_configure_form.update_status_module='array(FALSE,FALSE)' --yes"
drush si dkan --sites-subdir=default --db-url=$DATABASE_URL --account-name=admin --account-pass=admin  --site-name="DKAN Workflow QA" install_configure_form.update_status_module='array(FALSE,FALSE)' --yes
drush cc drush; drush cc all --yes
