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
      | Anonymous           |
      | Authenticated       |
      | Content Creator     |
      | Editor              |
      | Site Manager        |
      | Administrator       |


  Scenario Outline: As a user with any Workflow role, I should be able to access My Workbench.
    Given I am logged in as a user with the "<workbench roles>" role
    Then I should see the link "My Workbench"
    When I follow "My Workbench"
    Then The page status should be "ok"
    And I should be on the "My Workbench" page
    And I should see the link "My Content"
    And I should see the link "My Drafts"
    And I should see the link "My Edits"
    And I should see the link "All Recent Content"
    Examples:
      | workbench roles         |
      | Workflow Contributor    |
      | Workflow Moderator      |
      | Workflow Supervisor     |

  Scenario Outline: As a user with any Workflow role, I should be able to upgrade my own draft content to needs review.
    Given I am logged in as a user with the "<workbench roles>" role
    And datasets:
      | title              | published |
      | My Draft Dataset   | No        |
    And resources:
      | title              | dataset             | format |  published |
      | My Draft Resource  | My Draft Dataset    | csv    |  no        |
    And I visit the "My Drafts" page
    And I should see the button "Submit for review"
    And I should see "My Draft Dataset"
    And I should see "My Draft Resource"
    And I check the box "Select all items on this page"
    When I press "Submit for Review"
    Then I should see the success message "Performed Submit for review on 2 items."
    Examples:
      | workbench roles         |
      | Workflow Contributor    |
      | Workflow Moderator      |
      | Workflow Supervisor     |


  Scenario Outline: As a user with the Workflow Moderator or Supervisor role, I should be able to publish 'Needs Review' content.
    Given I am logged in as a user with the "Workflow Contributor" role
    And datasets:
      | title                       | published |
      | Draft Dataset Needs Review  | No        |
    And resources:
      | title                        | dataset             | format |  published |
      | Draft Resource Needs Review  | My Draft Dataset    | csv    |  no        |
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
    Then I should see the success message "Performed Submit for review on 2 items."
  Examples:
  | workbench reviewer roles |
  | Workflow Moderator       |
  | Workflow Supervisor      |


  Scenario: As a user with the Workflow Supervisor role, I should be able to publish stale 'Needs Review' content.
    Given I am logged in as a user with the "Workflow Contributor" role
    And datasets:
      | title                       | published |
      | Stale Dataset Needs Review  | No        |
      | Fresh Dataset Needs Review  | No        |
    And resources:
      | title                        | dataset                | format |  published |
      | Stale Resource Needs Review  | Stale Draft Dataset    | csv    |  no        |
    And I update the moderation state of "Stale Dataset Needs Review" to "Needs Review" on date "30 days ago"
    And I update the moderation state of "Stale Resource Needs Review" to "Needs Review" on date "30 days ago"
    And I update the moderation state of "Fresh Dataset Needs Review" to "Needs Review" on date "20 days ago"
    Given I am logged in as a user with the "Workbench Supervisor" role
    And I visit the "Stale Reviews" page
    And I should see the button "Reject"
    And I should see the button "Publish"
    And I should see "Stale Dataset Needs Review"
    And I should see "Stale Resource Needs Review"
    And I should not see "Fresh Resource Needs Review"
    And I check the box "Select all items on this page"
    When I press "Publish"
    Then I should see the success message "Performed Submit for review on 2 items."


  Scenario: As a user with the Workflow Contributor role, I should be not be able to see content in My Drafts that I didn't create.
    Given users:
      | name 		    | roles                |
      | some-other-user | Workflow Contributor |
    And datasets:
      | title           | author          | published |
      | Not My Dataset  | some-other-user | No        |
    And resources:
      | title            | dataset           | author          | format |  published |
      | Not My Resource  | Not My Dataset    | some-other-user | csv    |  no        |
    Given I am logged in as a user with the "Workflow Contributor" role
    And I visit the "My Drafts" page
    And I should not see "Not My Resource"
    And I should see "Not My Resource"

    ################ TO BE CONTINUED #############################

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see published datasets I authored in "My Drafts"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Smallville Published Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should be able to see draft resources I authored in "My Drafts"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "My drafts" page
    Then I should see the text "Smallville Draft-Draft Resource"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see draft resources I did not author in "My Drafts"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Bludhaven Needs Review - Draft Resource"


  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see Needs Review resources I authored in "My Drafts"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Smallville Draft-Needs Review Resource"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see Published resources I authored in "My Drafts"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Smallville Draft-Published Resource"


  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should be able to see Needs Review datasets I authored in "Needs Review"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Smallville Needs Review Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see Needs Review datasets I did not author in "Needs Review"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "Needs review" page
    Then I should not see the text "Bludhaven Needs Review Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see Published datasets I authored in "Needs Review"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Smallville Published Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should be able to see Needs Review resources I authored in "Needs Review"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Smallville Draft-Needs Review Resource"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see Needs Review resources I did not author in "Needs Review"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "Needs review" page
    Then I should not see the text "Bludhaven Needs Review-Needs Review Resource"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see Published resources I authored in "Needs Review"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Smallville Draft-Published Resource"


  @api @disablecaptcha
  Scenario: As a Workflow Moderator, I should not be able to see draft datasets I did not author, but which belongs to my Agency, in "My Drafts"
    And I am logged in as "ED-WM-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Smallville Draft Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, I should not be able to see draft resources I did not author, but which belongs to my Agency, in "My Drafts"
    And I am logged in as "ED-WM-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Smallville Draft-Draft Resource"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, I should be able to see Needs Review datasets I did not author, but which belongs to my Agency, in "Needs Review"
    And I am logged in as "ED-WM-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Smallville Needs Review Dataset"


  @api @disablecaptcha
  Scenario: As a Workflow Moderator, I should not be able to see Needs Review datasets I did not author, and which do not belong to my Agency, in "Needs Review"
    And I am logged in as "ED-WM-Smallville"
    And I am on "Needs review" page
    Then I should not see the text "Bludhaven Needs Review Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, I should be able to see Needs Review datasets I authored, and which do not belong to my Agency, in "Needs Review"
    And I am logged in as "ED-WM-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Bludhaven Crossover Dataset"


  Scenario: As a Workflow Moderator, I should not be able to see Needs Review datasets I did not author, and which do not belong to my Agency, in "Needs Review"
    And I am logged in as "ED-WM-Smallville"
    And I am on "Needs review" page
    Then I should not see the text "Bludhaven Needs Review Dataset"


  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should not be able to see draft datasets I did not author in "My Drafts"
    And I am logged in as "SM-WS-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Smallville Draft Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to see Needs Review datasets I did not author, and which belong to my Agency, in "Needs Review"
    And I am logged in as "SM-WS-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Smallville Needs Review Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to see Needs Review datasets I did not author, and which do not belong to my Agency, in "Needs Review"
    And I am logged in as "SM-WS-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Bludhaven Needs Review Dataset"


  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to see Needs Review resources I did not author, and which do not belong to my Agency, in "Needs Review"
    And I am logged in as "SM-WS-Smallville"
    And I am on "Needs review" page
    Then I should see the text "Bludhaven Needs Review-Needs Review Resource"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to see Draft datasets I did not author, and which do not belong to my Agency, but which were submitted greater than 72 hours before now, in "Stale Drafts"
    And I am logged in as "SM-WS-Smallville"
    And I am on "Stale drafts" page
    Then I should see the text "Bludhaven Draft Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to see Draft datasets I did not author, and which do belong to my Agency, but which were submitted greater than 72 hours before now, in "Stale Drafts"
    And I am logged in as "SM-WS-Smallville"
    And I am on "Stale drafts" page
    Then I should see the text "Smallville Draft Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to see Needs Review datasets I did not author, and which do not belong to my Agency, but which were submitted greater than 72 hours before now, in "Stale Drafts"
    And I am logged in as "SM-WS-Smallville"
    And I am on "Stale reviews" page
    Then I should see the text "Bludhaven Needs Review Dataset"


  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to see Needs Review datasets I did not author, and which do belong to my Agency, but which were submitted greater than 72 hours before now, in "Stale Drafts"
    And I am logged in as "SM-WS-Smallville"
    And I am on "Stale reviews" page
    Then I should see the text "Smallville Needs Review Dataset"

#  ----------------------------------------------------------------
    Given users:
      | user			| role						| group		|
      | Rogue			| Authenticated User, Workflow Contributor	| XMen		|
      | Cyclops		| Editor, Workflow Moderator			| XMen		|
      | Xavier		| Site Manager, Workflow Supervisor		| XMen		|
      | Mister Sinister 	| Site Manager, Workflow Supervisor		|		|
  and groups:
  | title		|
  | Xmen		|

  and pages:
  | title         | url                                 |
  | My drafts     | admin/workbench/drafts-active       |
  | Needs review  | admin/workbench/needs-review-active |

    And datasets:
      | title                           | author        | moderation   | moderation_date   | date created  | publisher  |
      | I Miss the Brotherhood       	| Rogue 	| draft        | Jul 21, 2015      | Jul 21, 2015  | XMen	|
      | It's kinda lonely being me 	| Rogue 	| needs_review | Jul 21, 2015      | Jul 21, 2015  | XMen	|


  @api @disablecaptcha
  Scenario: As an Authenticated user, I should be able to upgrade my content to Needs Review
    And I am logged in as "Rogue"
    And I am on the "My drafts" page
    Then I should see the "Submit for Review" link next to "I Miss the Brotherhood"

  @api @disablecaptcha
  Scenario: As an Authenticated user, I should not be able to upgrade my content to Published
    And I am logged in as "Rogue"
    And I am on the "Needs review" page
    Then I should not see the "Publish" link next to "It's kinda lonely being me"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, I should be able to upgrade content belonging to my Agency to Published
    And I am logged in as "Cyclops"
    And I am on the "Needs review" page
    Then I should see the "Publish" link next to "It's kinda lonely being me"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to upgrade content belonging to my Agency to Published
    And I am logged in as "Xavier"
    And I am on the "Needs review" page
    Then I should see the "Publish" link next to "It's kinda lonely being me"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to upgrade content outside my Agency to Published
    And I am logged in as "Mister Sinister"
    And I am on the "Needs review" page
    Then I should see the "Publish" link next to "It's kinda lonely being me"


#  ----------------------------------------------------------------

    Given groups:

      | title		|
      | Smallville 	|
      | Bludhaven 	|

    Given users:

      | name 		| mail 				| status| roles 		|
      | Robin 	| robin@teentitans.org 		| 1 	| Workflow Contributor 	|
      | Spoiler	| stephanie.brown@yahoo.com 	| 0 	| Workflow Contributor 	|
      | Nightwing 	| acrobatman@bludhaven.com 	| 1 	| Workflow Moderator 	|
      | Batgirl 	| silenceisgolden@bludhaven.com | 1 	| Workflow Moderator 	|
      | Oracle 	| iseeall@clocktower.org 	| 1 	| Workflow Supervisor 	|
      | Superboy 	| konel@teentitans.org 		| 1 	| Workflow Contributor 	|
      | Ma Kent 	| supermom@smallville.com 	| 1 	| Workflow Moderator 	|
      | Pa Kent 	| superdad@smallville.com 	| 1 	| Workflow Moderator 	|

    Given group memberships:

      | user 		| role on group 	| group 	| membership status 	|
      | Robin 	| member 		| Bludhaven 	| Active 		|
      | Spoiler 	| member 		| Bludhaven 	| Active 		|
      | Nightwing 	| member 		| Bludhaven 	| Active 		|
      | Batgirl 	| member 		| Bludhaven 	| Active 		|
      | Oracle 	| administrator member 	| Bludhaven 	| Active 		|
      | Superboy 	| member 		| Smallville 	| Active 		|
      | Ma Kent 	| member 		| Smallville 	| Active 		|
      | Pa Kent 	| member 		| Smallville 	| Inactive 		|

    Given content:

      | title 				| content type 	| author 	| moderation 	| publisher 	|
      | Bludhaven Feedback Draft 		| Feedback 	| Robin 	| draft 	| Bludhaven 	|
      | Bludhaven Feedback Needs Review 	| Feedback 	| Robin 	| needs_review 	| Bludhaven 	|
      | Smallville Feedback Draft 		| Feedback 	| Superboy 	| draft 	| Smallville 	|
      | Smallville Feedback Needs Review 	| Feedback 	| Superboy 	| needs_review 	| Smallville 	|
      | Smallville Dataset Draft 		| Dataset 	| Superboy 	| draft 	| Smallville 	|
      | Smallville Dataset Needs Review 	| Dataset 	| Pa Kent 	| needs_review 	| Smallville 	|
      | Groupless Feedback Draft 		| Feedback 	| Robin 	| draft 	| 		|
      | Groupless Feedback Needs Review 1 	| Feedback 	| Spoiler 	| needs_review 	| 		|
      | Groupless Feedback Needs Review 2 	| Feedback 	| Robin 	| needs_review 	| 		|

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
