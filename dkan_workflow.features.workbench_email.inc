<?php
/**
 * @file
 * dkan_workflow.features.workbench_email.inc
 */

/**
 * Implements hook_workbench_email_export().
 */
function dkan_workflow_workbench_email_export() {
  $items = array(
    'draft:needs_review:Workflow Contributor' => array(
      'from_name' => 'draft',
      'to_name' => 'needs_review',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Needs Review”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Contributor',
    ),
    'draft:needs_review:Workflow Moderator' => array(
      'from_name' => 'draft',
      'to_name' => 'needs_review',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Needs Review”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Moderator',
    ),
    'draft:needs_review:Workflow Supervisor' => array(
      'from_name' => 'draft',
      'to_name' => 'needs_review',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Needs Review”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Supervisor',
    ),
    'needs_review:draft:Workflow Contributor' => array(
      'from_name' => 'needs_review',
      'to_name' => 'draft',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Draft”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Contributor',
    ),
    'needs_review:draft:Workflow Moderator' => array(
      'from_name' => 'needs_review',
      'to_name' => 'draft',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Draft”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Moderator',
    ),
    'needs_review:draft:Workflow Supervisor' => array(
      'from_name' => 'needs_review',
      'to_name' => 'draft',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Draft”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Supervisor',
    ),
    'needs_review:published:Workflow Contributor' => array(
      'from_name' => 'needs_review',
      'to_name' => 'published',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Published”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Contributor',
    ),
    'needs_review:published:Workflow Moderator' => array(
      'from_name' => 'needs_review',
      'to_name' => 'published',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Published”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Moderator',
    ),
    'needs_review:published:Workflow Supervisor' => array(
      'from_name' => 'needs_review',
      'to_name' => 'published',
      'subject' => 'Subject: [site:name] Status of [node:content-type] “[node:title]”',
      'message' => '[user:name],

A moderator has pushed your [node:content-type],  [node:title], to the moderation state “Published”.

For more details, view your [node:content-type] at [node:url]. 

To modify the moderation state of a Dataset , click “Edit” and click the ‘Moderate’ button at the top of the screen.
To modify the moderation state of a Resource, Blog, or a page  scroll to the bottom of the page to find the “Publishing Options” menu tab.
You can access your full Workbench dashboard by logging in and clicking “My Workbench” on the left-hand side of the blue site navigation bar. 

Content you have created, whether published or unpublished, is listed under “My Content.”

“My Drafts” displays all pieces of content that you have created and saved as drafts, and “Needs Review” displays all of the content that you’ve created that needs review by an editor, group manager or site administrator.
',
      'author' => 0,
      'automatic' => 1,
      'role' => 'Workflow Supervisor',
    ),
  );
  return $items;
}
