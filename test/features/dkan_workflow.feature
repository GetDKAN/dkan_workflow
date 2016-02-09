@api @disablecaptcha @javascript
Feature:
  Workflow (Workbench) tests for DKAN Workflow Module

  Background:
    Given pages:
      | name               | url                                  |
      | My Workbench       | /admin/workbench                     |
      | My Content         | /admin/workbench                     |
      | My Drafts          | /admin/workbench/drafts-active       |
      | Needs Review       | /admin/workbench/needs-review-active |
      | Stale Drafts       | /admin/workbench/drafts-stale        |
      | Stale Reviews      | /admin/workbench/needs-review-stale  |
      | My Edits           | /admin/workbench/content/edited      |
      | All Recent Content | /admin/workbench/content/all         |

  @fixme
  # Non workbench roles can see the menu item My Workflow. However
  # they can't access to the page.
  Scenario Outline: As a user without a Workbench role, I should not be able to access My Workbench or the My Workbench tabs
    Given I am logged in as a user with the "<non-workbench roles>" role
    Then I should not see the link "My Workbench"
    And I should be denied access to the "My Workbench" page
    And I should be denied access to the "My Drafts" page
    And I should be denied access to the "Needs Review" page
    And I should be denied access to the "Stale Drafts" page
    And I should be denied access to the "Stale Reviews" page
    And I should be denied access to the "My Edits" page
    And I should be denied access to the "All Recent Content" page
    Examples:
      | non-workbench roles |
      | anonymous user      |
      | authenticated user  |
      | content creator     |
      | editor              |
      | site manager        |

  @ok
  Scenario Outline: As a user with any Workflow role, I should be able to access My Workbench.
    Given I am logged in as a user with the "<workbench roles>" role
    Then I should see the link "My Workbench"
    When I follow "My Workbench"
    Then The page status should be "ok"
    And I should be on the "My Workbench" page
    And I should see the link "My content"
    #And I should see the link " My drafts"
    And I should see the link "My Edits"
    And I should see the link "All Recent Content"
    Examples:
      | workbench roles                       |
      | Workflow Contributor, content creator |
      | Workflow Moderator, editor            |
      | Workflow Supervisor, site manager     |

  @ok
  Scenario Outline: As a user with any Workflow role, I should be able to upgrade my own draft content to needs review.
    Given I am logged in as a user with the "<workbench roles>" role
    And datasets:
      | title              | published |
      | My Draft Dataset   | no        |
    And resources:
      | title              | dataset             | format |  published |
      | My Draft Resource  | My Draft Dataset    | csv    |  no        |
    And I am on the "My Drafts" page
    Then I should see the button "Submit for review"
    And I should see "My Draft Dataset"
    And I should see "My Draft Resource"
    And I check the box "Select all items on this page"
    And I press "Submit for review"
    Then I wait for "Performed Submit for review on 2 items."
    Examples:
      | workbench roles         |
      | Workflow Contributor, content creator |
      | Workflow Moderator, editor            |
      | Workflow Supervisor, site manager     |

  @ok
  Scenario Outline: As a user with the Workflow Moderator or Supervisor role, I should be able to publish 'Needs Review' content.
    Given I am logged in as a user with the "Workflow Contributor" role
    And datasets:
      | title                       | published |
      | Draft Dataset Needs Review  | No        |
    And resources:
      | title                        | dataset             | format |  published |
      | Draft Resource Needs Review  | Draft Dataset Needs Review    | csv    |  no        |
    And I update the moderation state of "Draft Dataset Needs Review" to "Needs Review"
    And I update the moderation state of "Draft Resource Needs Review" to "Needs Review"
    Given I am logged in as a user with the "<workbench reviewer roles>" role
    And I visit the "Needs Review" page
    And I should see the button "Reject"
    And I should see the button "Publish"
    And I should see "Draft Dataset Needs Review"
    And I should see "Draft Resource Needs Review"
    And I check the box "Select all items on this page"
    When I press "Publish"
    Then I wait for "Performed Publish on 2 items."
    Examples:
      | workbench reviewer roles              |
      | Workflow Moderator, editor            |
      | Workflow Supervisor, site manager     |

  @ok
  Scenario: As a user with the Workflow Supervisor role, I should be able to publish stale 'Needs Review' content.
    Given I am logged in as a user with the "Workflow Contributor" role
    And datasets:
      | title                       | published |
      | Stale Dataset Needs Review  | No        |
      | Fresh Dataset Needs Review  | No        |
    And resources:
      | title                        | dataset                    | format |  published |
      | Stale Resource Needs Review  | Stale Dataset Needs Review | csv    |  no        |
    And I update the moderation state of "Stale Dataset Needs Review" to "Needs Review" on date "30 days ago"
    And I update the moderation state of "Stale Resource Needs Review" to "Needs Review" on date "30 days ago"
    And I update the moderation state of "Fresh Dataset Needs Review" to "Needs Review" on date "20 days ago"
    Given I am logged in as a user with the "Workflow Supervisor" role
    And I visit the "Stale Reviews" page
    And I should see the button "Reject"
    And I should see the button "Publish"
    And I should see "Stale Dataset Needs Review"
    And I should see "Stale Resource Needs Review"
    And I should not see "Fresh Resource Needs Review"
    And I check the box "Select all items on this page"
    When I press "Publish"
    Then I wait for "Performed Publish on 3 items"

  @ok
  Scenario Outline: As a user with Workflow Roles, I should not be able to see draft contents I did not author in 'My Drafts'
    Given I am logged in as a user with the "<workbench roles>" role
    Given users:
      | name            | roles                |
      | some-other-user | Workflow Contributor |
    And datasets:
      | title           | author          | published |
      | Not My Dataset  | some-other-user | No        |
    And resources:
      | title            | dataset           | author          | format |  published |
      | Not My Resource  | Not My Dataset    | some-other-user | csv    |  no        |

    And I visit the "My Drafts" page
    And I should not see "Not My Resource"
    And I should not see "Not My Dataset"
    Examples:
      | workbench roles                       |
      | Workflow Contributor, content creator |
      | Workflow Moderator, editor            |
      | Workflow Supervisor, site manager     |

  @ok
  Scenario Outline: As a user with Workflow Roles, I should be able to see draft content I authored in 'My Drafts'
    Given I am logged in as a user with the "<workbench roles>" role
    And datasets:
      | title       | published |
      | My Dataset  | No        |
    And resources:
      | title        | dataset    | format |  published |
      | My Resource  | My Dataset | csv    |  no        |
    And I visit the "My Drafts" page
    And I should see "My Resource"
    And I should see "My Dataset"
    Examples:
      | workbench roles                       |
      | Workflow Contributor, content creator |
      | Workflow Moderator, editor            |
      | Workflow Supervisor, site manager     |

  @ok
  Scenario Outline: As a user with Workflow Roles, I should not be able to see Published content I authored in workbench pages
    Given users:
      | name            | roles                                 | mail                  |
      | contributor     | Workflow Contributor, content creator | contributor@email.com |
      | moderator       | Workflow Moderator, editor            | moderator@email.com   |
    Given I am logged in as "contributor"
    And datasets:
      | title                         | published |
      | My Dataset                    | No        |
    And resources:
      | title        | dataset       | format |  published |
      | My Resource  | My Dataset    | csv    |  Yes       |
    And I update the moderation state of "My Dataset" to "Needs Review"
    And I update the moderation state of "My Resource" to "Needs Review"
    And "moderator" updates the moderation state of "My Dataset" to "Published"
    And "moderator" updates the moderation state of "My Resource" to "Published"
    And I am on "<page>" page
    Then I should not see "My Dataset"
    Then I should not see "My Resource"
    Examples:
      | page          | workflow role                         |
      | My Drafts     | Workflow Contributor, content creator |
      | Needs Review  | Workflow Contributor, content creator |
      | My Drafts     | Workflow Moderator, editor            |
      | Needs Review  | Workflow Moderator, editor            |
      | My Drafts     | Workflow Supervisor, site manager     |
      | Needs Review  | Workflow Supervisor, site manager     |

  @ok
  Scenario Outline: As a user with Workflow Roles, I should not be able to see Needs Review resources I authored in 'My Drafts'
    Given I am logged in as a user with the "<workbench roles>" role
    And datasets:
      | title       | published |
      | My Dataset  | No        |
    And resources:
      | title        | dataset       | format |  published |
      | My Resource  | My Dataset    | csv    |  no        |
    And I update the moderation state of "My Dataset" to "Needs Review"
    And I update the moderation state of "My Resource" to "Needs Review"
    And I visit the "My Drafts" page
    And I should not see "My Resource"
    And I should not see "My Dataset"
    Examples:
      | workbench roles                       |
      | Workflow Contributor, content creator |
      | Workflow Moderator, editor            |
      | Workflow Supervisor, site manager     |

  @ok
  Scenario: As a user with the Workflow Contributor, I should be able to see Needs Review contents I authored in 'Needs Review'
    Given I am logged in as a user with the "Workflow Contributor" role
    And datasets:
      | title       | published |
      | My Dataset  | Yes       |
    And resources:
      | title        | dataset       | format |  published |
      | My Resource  | My Dataset    | csv    |  Yes       |
    And I update the moderation state of "My Dataset" to "Needs Review"
    And I update the moderation state of "My Resource" to "Needs Review"
    And I visit the "Needs Review" page
    And I should see "My Resource"
    And I should see "My Dataset"

  @ok
  Scenario: As a user with the Workflow Contributor, I should not be able to see Needs Review contents I did not author in 'Needs Review'
    Given I am logged in as a user with the "Workflow Contributor" role
    Given users:
      | name            | roles                                 |
      | some-other-user | Workflow Contributor, content creator |
      | contributor     | Workflow Contributor, content creator |
    And datasets:
      | title           | author          | published |
      | Not My Dataset  | some-other-user | No        |
    And resources:
      | title            | dataset           | author          | format |  published  |
      | Not My Resource  | Not My Dataset    | some-other-user | csv    |  no         |

    And "some-other-user" updates the moderation state of "Not My Dataset" to "Needs Review"
    And "some-other-user" updates the moderation state of "Not My Resource" to "Needs Review"
    And I visit the "Needs Review" page
    Then I should not see "Not My Resource"
    Then I should not see "Not My Dataset"

  @ok
  Scenario: As a Workflow Moderator, I should be able to see Needs Review datasets I did not author, but which belongs to my Group, in 'Needs Review'
    Given groups:
      | title    | published |
      | Group 01 | Yes       |
    Given users:
      | name            | roles                                 |
      | some-other-user | Workflow Contributor, content creator |
      | moderator       | Workflow Moderator, editor            |
    And group memberships:
      | user            | group    | role on group        | membership status |
      | some-other-user | Group 01 | administrator member | Active            |
      | moderator       | Group 01 | administrator member | Active            |
    And datasets:
      | title           | author          | published | publisher |
      | Not My Dataset  | some-other-user | No        | Group 01  |
    And "some-other-user" updates the moderation state of "Not My Dataset" to "Needs Review"
    Given I am logged in as "moderator"
    And I am on "Needs Review" page
    Then I should see the text "Not My Dataset"

  @ok
  Scenario: As a Workflow Moderator, I should not be able to see Needs Review datasets I did not author, and which do not belong to my Group, in 'Needs Review'
    Given groups:
      | title    | published |
      | Group 01 | Yes       |
      | Group 02 | Yes       |
    Given users:
      | name            | roles                                 |
      | some-other-user | Workflow Contributor, content creator |
      | moderator       | Workflow Moderator, editor            |
    And group memberships:
      | user            | group    | role on group        | membership status |
      | some-other-user | Group 01 | administrator member | Active            |
      | moderator       | Group 02 | administrator member | Active            |
    And datasets:
      | title           | author          | published | publisher |
      | Not My Dataset  | some-other-user | No        | Group 01  |
    And "some-other-user" updates the moderation state of "Not My Dataset" to "Needs Review"
    Given I am logged in as "moderator"
    And I am on "Needs Review" page
    Then I should not see the text "Not My Dataset"

  @ok
  Scenario: As a Workflow Supervisor, I should be able to see Needs Review content I did not author, regardless whether it belongs to my group or not, in 'Needs Review'
    Given groups:
      | title    | published |
      | Group 01 | Yes       |
      | Group 02 | Yes       |
    Given users:
      | name            | roles                                 |
      | other-user      | Workflow Contributor, content creator |
      | some-other-user | Workflow Contributor, content creator |
      | supervisor      | Workflow Supervisor, site manager     |
    And group memberships:
      | user            | group    | role on group        | membership status |
      | other-user      | Group 02 | administrator member | Active            |
      | some-other-user | Group 01 | administrator member | Active            |
      | supervisor      | Group 01 | administrator member | Active            |
    And datasets:
      | title                 | author          | published | publisher |
      | Still Not My Dataset  | other-user      | No        | Group 01  |
      | Not My Dataset        | some-other-user | No        | Group 02  |
    And "other-user" updates the moderation state of "Still Not My Dataset" to "Needs Review"
    And "some-other-user" updates the moderation state of "Not My Dataset" to "Needs Review"
    Given I am logged in as "supervisor"
    And I am on "Needs Review" page
    Then I should see the text "Still Not My Dataset"
    Then I should see the text "Not My Dataset"

  @ok
  Scenario: As a Workflow Supervisor I should be able to see content in the 'Needs Review' state I did not author, regardless whether it belongs to my group or not, but which were submitted greater than 72 hours before now, in the 'Stale Reviews'
    Given groups:
      | title    | published |
      | Group 01 | Yes       |
      | Group 02 | Yes       |
    Given users:
      | name            | roles                                 |
      | other-user      | Workflow Contributor, content creator |
      | some-other-user | Workflow Contributor, content creator |
      | supervisor      | Workflow Supervisor, site manager     |
    And group memberships:
      | user            | group    | role on group        | membership status |
      | other-user      | Group 02 | administrator member | Active            |
      | some-other-user | Group 01 | administrator member | Active            |
      | supervisor      | Group 01 | administrator member | Active            |
    And datasets:
      | title                 | author          | published | publisher |
      | Still Not My Dataset  | other-user      | No        | Group 01  |
      | Not My Dataset        | some-other-user | No        | Group 02  |
    And "other-user" updates the moderation state of "Still Not My Dataset" to "Needs Review" on date "30 days ago"
    And "some-other-user" updates the moderation state of "Not My Dataset" to "Needs Review" on date "30 days ago"
    Given I am logged in as "supervisor"
    And I am on "Stale Reviews" page
    Then I should see the text "Still Not My Dataset"
    Then I should see the text "Not My Dataset"

  @ok
  Scenario: As a Workflow Supervisor I should be able to see content in the 'Draft' state I did not author, regardless whether it belongs to my group or not, but which were submitted greater than 72 hours before now, in the 'Stale Drafts'
    Given groups:
      | title    | published |
      | Group 01 | Yes       |
      | Group 02 | Yes       |
    Given users:
      | name            | roles                                 |
      | other-user      | Workflow Contributor, content creator |
      | some-other-user | Workflow Contributor, content creator |
      | supervisor      | Workflow Supervisor, site manager     |
    And group memberships:
      | user            | group    | role on group        | membership status |
      | other-user      | Group 02 | administrator member | Active            |
      | some-other-user | Group 01 | administrator member | Active            |
      | supervisor      | Group 01 | administrator member | Active            |
    And datasets:
      | title                 | author          | published | publisher |
      | Still Not My Dataset  | other-user      | No        | Group 01  |
      | Not My Dataset        | some-other-user | No        | Group 02  |
    And "other-user" updates the moderation state of "Still Not My Dataset" to "Draft" on date "30 days ago"
    And "some-other-user" updates the moderation state of "Not My Dataset" to "Draft" on date "30 days ago"
    Given I am logged in as "supervisor"
    And I am on "Stale Drafts" page
    Then I should see the text "Still Not My Dataset"
    Then I should see the text "Not My Dataset"


  ################ TO BE CONTINUED #############################

############### EMAIL

    Given groups:

      | title   |
      | Smallville  |
      | Bludhaven   |

    Given users:

      | name    | mail        | status| roles     |
      | Robin   | robin@teentitans.org    | 1   | Workflow Contributor  |
      | Spoiler | stephanie.brown@yahoo.com   | 0   | Workflow Contributor  |
      | Nightwing   | acrobatman@bludhaven.com  | 1   | Workflow Moderator  |
      | Batgirl   | silenceisgolden@bludhaven.com | 1   | Workflow Moderator  |
      | Oracle  | iseeall@clocktower.org  | 1   | Workflow Supervisor   |
      | Superboy  | konel@teentitans.org    | 1   | Workflow Contributor  |
      | Ma Kent   | supermom@smallville.com   | 1   | Workflow Moderator  |
      | Pa Kent   | superdad@smallville.com   | 1   | Workflow Moderator  |

    Given group memberships:

      | user    | role on group   | group   | membership status   |
      | Robin   | member    | Bludhaven   | Active    |
      | Spoiler   | member    | Bludhaven   | Active    |
      | Nightwing   | member    | Bludhaven   | Active    |
      | Batgirl   | member    | Bludhaven   | Active    |
      | Oracle  | administrator member  | Bludhaven   | Active    |
      | Superboy  | member    | Smallville  | Active    |
      | Ma Kent   | member    | Smallville  | Active    |
      | Pa Kent   | member    | Smallville  | Inactive    |

    Given content:

      | title         | content type  | author  | moderation  | publisher   |
      | Bludhaven Feedback Draft    | Feedback  | Robin   | draft   | Bludhaven   |
      | Bludhaven Feedback Needs Review   | Feedback  | Robin   | needs_review  | Bludhaven   |
      | Smallville Feedback Draft     | Feedback  | Superboy  | draft   | Smallville  |
      | Smallville Feedback Needs Review  | Feedback  | Superboy  | needs_review  | Smallville  |
      | Smallville Dataset Draft    | Dataset   | Superboy  | draft   | Smallville  |
      | Smallville Dataset Needs Review   | Dataset   | Pa Kent   | needs_review  | Smallville  |
      | Groupless Feedback Draft    | Feedback  | Robin   | draft   |     |
      | Groupless Feedback Needs Review 1   | Feedback  | Spoiler   | needs_review  |     |
      | Groupless Feedback Needs Review 2   | Feedback  | Robin   | needs_review  |     |

    And pages:
      | title         | url                                 |
      | My drafts     | admin/workbench/drafts-active       |
      | Needs review  | admin/workbench/needs-review-active |


  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review" all Workflow Moderators in the content's Agency should receive an email
    And I am logged in as "Robin"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Bludhaven Feedback Draft"
    Then the user "Nightwing" should receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review" all Workflow Moderators in the content's Agency should receive an email
    And I am logged in as "Robin"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Bludhaven Feedback Draft"
    Then the user "Batgirl" should receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review" Workflow Supervisors in the content's Agency should not receive an email
    And I am logged in as "Robin"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Bludhaven Feedback Draft"
    Then the user "Oracle" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Moderator and I am on the "Needs Review" page, when I click "Publish" the Content Author should be notified
    And I am logged in as "Nightwing"
    And I am on the "Needs review" page
    And I click the "Publish" link next to "Bludhaven Feedback Needs Review"
    Then the user "Robin" should receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Moderator and I am on the "Needs Review" page, when I click "Publish", all Workflow Moderators in the content's agency should not be notified
    And I am logged in as "Nightwing"
    And I am on the "Needs review" page
    And I click the "Publish" link next to "Bludhaven Feedback Needs Review"
    Then the user "Batgirl" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Moderator and I am on the "Needs Review" page, when I click "Publish", all Workflow Moderators in the content's agency should not be notified
    And I am logged in as "Nightwing"
    And I am on the "Needs review" page
    And I click the "Publish" link next to "Bludhaven Feedback Needs Review"
    Then the user "Nightwing" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Moderator and I am on the "Needs Review" page, when I click "Publish", all Workflow Supervisors in the content's agency should not be notified
    And I am logged in as "Nightwing"
    And I am on the "Needs review" page
    And I click the "Publish" link next to "Bludhaven Feedback Needs Review"
    Then the user "Oracle" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Moderator and I am on the "Needs Review" page, when I click "Publish", Workflow Contributors moutside the content's agency should not be notified
    And I am logged in as "Nightwing"
    And I am on the "Needs review" page
    And I click the "Publish" link next to "Bludhaven Feedback Needs Review"
    Then the user "Superboy" should not receive an email

  @api @disablecaptcha


  Scenario: Given I am logged in as a Workflow Moderator and I am on the "Needs Review" page, when I click "Publish", Workflow Moderators outside the content's agency should not be notified
    And I am logged in as "Nightwing"
    And I am on the "Needs review" page
    And I click the "Publish" link next to "Bludhaven Feedback Needs Review"
    Then the user "Ma Kent" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Supervisor and I am on the "Needs Review" page, when I click "Reject" for content with no Agency, Content Authors should be notified
    And I am logged in as "Oracle"
    And I am on the "Needs review" page
    And I click the "Reject" link next to "Groupless Feedback Needs Review 1"
    Then the user "Robin" should receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Supervisor and I am on the "Needs Review" page, when I click "Reject" for content with no Agency, Workflow Contributors who are not the content author should not be notified
    And I am logged in as "Oracle"
    And I am on the "Needs review" page
    And I click the "Reject" link next to "Groupless Feedback Needs Review 1"
    Then the user "Superboy" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Supervisor and I am on the "Needs Review" page, when I click "Reject" for content with no Agency, Workflow Supervisors who are not the content author should not be notified
    And I am logged in as "Oracle"
    And I am on the "Needs review" page
    And I click the "Reject" link next to "Groupless Feedback Needs Review 1"
    Then the user "Oracle" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Supervisor and I am on the "Needs Review" page, when I click "Reject" for content with no Agency, Workflow Moderators should not be notified
    And I am logged in as "Oracle"
    And I am on the "Needs review" page
    And I click the "Reject" link next to "Groupless Feedback Needs Review 1"
    Then the user "Ma Kent" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Supervisor and I am on the "Needs Review" page, when I click "Reject" for content with no Agency, Workflow Moderators should not be notified
    And I am logged in as "Oracle"
    And I am on the "Needs review" page
    And I click the "Reject" link next to "Groupless Feedback Needs Review 1"
    Then the user "Nightwing" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Supervisor and I am on the "Needs Review" page, when I click "Reject" for content with no Agency, Workflow Moderators should not be notified
    And I am logged in as "Oracle"
    And I am on the "Needs review" page
    And I click the "Reject" link next to "Groupless Feedback Needs Review 1"
    Then the user "Batgirl" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Supervisor and I am on the "Needs Review" page, when I click "Reject" for content with no Agency, inactive Content Authors should not be notified
    And I am logged in as "Oracle"
    And I am on the "Needs review" page
    And I click the "Reject" link next to "Groupless Feedback Needs Review 2"
    Then the user "Spoiler" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Supervisor and I am on the "Needs Review" page, when I click "Reject" for content with no Agency, Workflow Supervisors should not be notified, even if the user is inactive
    And I am logged in as "Oracle"
    And I am on the "Needs review" page
    And I click the "Reject" link next to "Groupless Feedback Needs Review 2"
    Then the user "Oracle" should not receive an email


  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review" for content with no Agency, Workflow Supervisors should be notified
    And I am logged in as "Robin"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Groupless Feedback Draft"
    Then the user "Oracle" should receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review" for content with no Agency, Content Authors should be notified
    And I am logged in as "Robin"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Groupless Feedback Draft"
    Then the user "Robin" should receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review" for content with no Agency, Workflow Moderators should not be notified
    And I am logged in as "Robin"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Groupless Feedback Draft"
    Then the user "Ma Kent" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review" for content with no Agency, Workflow Moderators should not be notified
    And I am logged in as "Robin"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Groupless Feedback Draft"
    Then the user "Nightwing" should not receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review", all Workflow Moderators within that Agency should be notified
    And I am logged in as "Superboy"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Smallville Dataset Draft"
    Then the user "Ma Kent" should receive an email

  @api @disablecaptcha

  Scenario: Given I am logged in as a Workflow Contributor and I am on the "My drafts" page, when I click "Submit for Review," Workflow Moderators with an inactive membership to that Agency should not be notified
    And I am logged in as "Superboy"
    And I am on the "My drafts" page
    And I click the "Submit for Review" link next to "Smallville Dataset Draft"
    Then the user "Pa Kent" should not receive an email