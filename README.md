[![Circle CI](https://circleci.com/gh/NuCivic/dkan_workflow.svg?style=svg)](https://circleci.com/gh/NuCivic/dkan_workflow)

**DEPRECATED:** This module has been moved into [DKAN core](https://github.com/NuCivic/dkan) for release 7.x-1.13. To maintain backward compatibility with DKAN 7.x-1.12 and subsequent patch releases this project will remain on Github but new features will be applied directly to the DKAN core folder `modules/dkan/dkan_workflow`.

## DKAN Workflow?
![DKAN Workflow](./dkan_workflow_screenshot.png)

Workflow implementation for [DKAN](https://github.com/NuCivic/dkan) based on
[Workbench](https://www.drupal.org/project/workbench) and related modules.

## Requirements

* Dkan install. We do use undeclared dependencies used in core Dkan, for example
  the dataset and resource content types, features_role_export...
* All external dependencies are incapsulated in the
`drupal-org.make` file. This includes
[Workbench](https://www.drupal.org/project/workbench) and related modules
([Workbench Moderation](https://www.drupal.org/project/workbench_moderation) for
the content moderation features, [Workbench
Email](https://www.drupal.org/project/workbench_email) for email notifications.)
* Better UX is made possible by using the [Link
  Badges](https://www.drupal.org/project/link_badges) and [Menu
  Badges](https://www.drupal.org/project/menu_badges)

## Installation

After either enabling or disabling DKAN Workflow and its dependencies, you will need to [rebuild content permissions](https://docs.acquia.com/articles/rebuilding-node-access-permissions). If logged in as an admin you should see a message telling you this with a link to the form to do so.

## Known issues:

* Transitions config and Emails templates for "Original Author" could not be
 exported due to a bug in workbench_email.
* Behat tests uses [hhs_implementation](https://github.com/NuCivic/dkanextension/tree/hhs_implementation)
 dkanextension instead of the master branch.
* Support for OG while sending emails is supported but not clearly documented.

## Documentation

We are working on improving this documentation. Please let us know if you have
any questions in the mean time.
