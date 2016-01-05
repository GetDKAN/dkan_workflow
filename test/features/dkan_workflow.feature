Feature:
  Workflow (Workbench) tests for DKAN Workflow Module

  Given Users:
  | name       | mail                     | status | roles                             |
  | AUTH       | AUTH@fakeemail.com       | 1      | Authenticated User                |
  | AUTH-WC    | AUTH-WC@fakeemail.com    | 1      | Workflow Contributor              |
  | ED         | ED@fakeemail.com         | 1      | Editor                            |
  | ED-WM      | ED-WM@fakeemail.com      | 1      | Editor, Workflow Moderator        |
  | SM         | SM@fakeemail.com         | 1      | Site Manager                      |
  | SM-WS      | SM-WS@fakeemail.com      | 1      | Site Manager, Workflow Supervisor

  @api @disablecaptcha
  Scenario: As an Authenticated User without a Workbench role, I should not be able to access My Workbench
    And I am logged in as "AUTH"
    Then I should not see the link "My Workbench"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should be able to access My Workbench
    And I am logged in as "AUTH-WC"
    Then I should see the link "My Workbench"

  @api @disablecaptcha
  Scenario: As an Editor without a Workbench role, I should not be able to access My Workbench
    And I am logged in as "ED"
    Then I should not see the link "My Workbench"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, I should be able to access My Workbench
    And I am logged in as "ED-WM"
    Then I should see the link "My Workbench"


  @api @disablecaptcha
  Scenario: As a Site Manager without a Workbench role, I should not be able to access My Workbench
    And I am logged in as "SM"
    Then I should not see the link "My Workbench"


  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, I should be able to access My Workbench
    And I am logged in as "SM-WS"
    Then I should see the link "My Workbench"

#  --------------------------------------------------------

    Given pages:
      | title     | url             |
      | Workbench | admin/workbench |

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, in My Workbench, I should be able to see the My Drafts tab
    And I am logged in as a "Workflow Contributor"
    And I am on "Workbench" page
    Then I should see the link "My Drafts"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, in My Workbench, I should be able to see the Needs Review tab
    And I am logged in as a "Workflow Contributor"
    And I am on "Workbench" page
    Then I should see the link "Needs Review"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, in My Workbench, I should not be able to see the Stale Drafts tab
    And I am logged in as a "Workflow Contributor"
    And I am on "Workbench" page
    Then I should not see the link "Stale Drafts"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, in My Workbench, I should not be able to see the Stale Reviews tab
    And I am logged in as a "Workflow Contributor"
    And I am on "Workbench" page
    Then I should not see the link "Stale Reviews"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, in My Workbench, I should be able to see the My Drafts tab
    And I am logged in as a "Workflow Moderator"
    And I am on "Workbench" page
    Then I should see the link "My Drafts"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, in My Workbench, I should be able to see the Needs Review tab
    And I am logged in as a "Workflow Moderator"
    And I am on "Workbench" page
    Then I should see the link "Needs Review"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, in My Workbench, I should not be able to see the Stale Drafts tab
    And I am logged in as a "Workflow Moderator"
    And I am on "Workbench" page
    Then I should not see the link "Stale Drafts"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator, in My Workbench, I should not be able to see the Stale Reviews tab
    And I am logged in as a "Workflow Moderator"
    And I am on "Workbench" page
    Then I should not see the link "Stale Reviews"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, in My Workbench, I should be able to see the My Drafts tab
    And I am logged in as a "Workflow Supervisor"
    And I am on "Workbench" page
    Then I should see the link "My Drafts"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, in My Workbench, I should be able to see the Needs Review tab
    And I am logged in as a "Workflow Supervisor"
    And I am on "Workbench" page
    Then I should see the link "Needs Review"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, in My Workbench, I should be able to see the Stale Drafts tab
    And I am logged in as a "Workflow Supervisor"
    And I am on "Workbench" page
    Then I should see the link "Stale Drafts"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor, in My Workbench, I should be able to see the Stale Reviews tab
    And I am logged in as a "Workflow Supervisor"
    And I am on "Workbench" page
    Then I should see the link "Stale Reviews"


#  --------------------------------------------

    Given Users:
      | name    | mail                  | status | roles                |
      | AUTH-WC | AUTH-WC@fakeemail.com | 1      | Workflow Contributor |
      | AUTH-WM | AUTH-WM@fakeemail.com | 1      | Workflow Moderator   |
      | AUTH-WS | AUTH-WS@fakeemail.com | 1      | Workflow Supervisor  |
      | AUTH    | AUTH@fakeemail.com    | 1      | Authenticated User   |
      | ED      | ED@fakeemail.com      | 1      | Editor               |
      | SM      | SM@fakeemail.com      | 1      | Site Manager         |

    And pages:
      | title     | url                           |
      | My drafts | admin/workbench/drafts-active |

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should be able to upgrade my draft content to needs review
    And I am logged in as "AUTH-WC"
    And I am on "My drafts" page
    Then I should see the button "Submit for review"

  @api @disablecaptcha
  Scenario: As a Workflow Moderator I should be able to upgrade my draft content to needs review
    And I am logged in as "AUTH-WM"
    And I am on "My drafts" page
    Then I should see the button "Submit for review"

  @api @disablecaptcha
  Scenario: As a Workflow Supervisor I should be able to upgrade my draft content to needs review
    And I am logged in as "AUTH-WS"
    And I am on "My drafts" page
    Then I should see the button "Submit for review"

  @api @disablecaptcha
  Scenario: As an Authenticated User without a workflow role I should not be able to access "My drafts"
    And I am logged in as "AUTH"
  I should not be able to access "My drafts"

  @api @disablecaptcha
  Scenario: As an Editor without a workflow role I should not be able to access "My drafts"
    And I am logged in as "ED"
  I should not be able to access "My drafts"

  @api @disablecaptcha
  Scenario: As a Site Manager without a workflow role I should not be able to access "My drafts"
    And I am logged in as "SM"
  I should not be able to access "My drafts"

#  -------------------------------------------
    Given groups:
      | title      |
      | Smallville |
      | Star City  |
      | Bludhaven  |
      | Coast City |
    And Users:
      | name               | mail                             | status | roles                             |
      | AUTH-WC-Smallville | AUTH-WC-Smallville@fakeemail.com | 1      | Workflow Contributor              |
      | AUTH-WC-Bludhaven  | AUTH-WC-Bludhaven@fakeemail.com  | 1      | Workflow Contributor              |
      | ED-WM-Smallville   | ED-WM-Smallville@fakeemail.com   | 1      | Editor, Workflow Moderator        |
      | ED-WM-Bludhaven    | ED-WM-Bludhaven@fakeemail.com    | 1      | Editor, Workflow Moderator        |
      | SM-WS-Smallville   | SM-WS-Smallville@fakeemail.com   | 1      | Site Manager, Workflow Supervisor |
      | SM-WS-Bludhaven    | SM-WS-Bludhaven@fakeemail.com    | 1      | Site Manager, Workflow Supervisor |
      | SM                 | SM-NoGroup@fakeemail.com         | 1      | Site Manager, Workflow Supervisor |
    And group memberships:
      | user               | role on group        | group      | membership status |
      | AUTH-WC-Smallville | member               | Smallville | Active            |
      | AUTH-WC-Bludhaven  | member               | Bludhaven  | Active            |
      | ED-WM-Smallville   | administrator member | Smallville | Active            |
      | ED-WM-Bludhaven    | administrator member | Bludhaven  | Active            |
      | SM-WS-Smallville   | administrator member | Smallville | Active            |
      | SM-WS-Bludhaven    | administrator member | Bludhaven  | Active            |
    And datasets:
      | title                           | author             | moderation   | moderation_date   | date created  | publisher  |
      | Smallville Draft Dataset        | AUTH-WC-Smallville | draft        | Jul 21, 2015      | Jul 21, 2015  | Smallville |
      | Smallville Needs Review Dataset | AUTH-WC-Smallville | needs_review | Jul 21, 2015      | Jul 21, 2015  | Smallville |
      | Bludhaven Crossover Dataset     | ED-WM-Smallville   | needs_review | Jul 21, 2015      | Jul 21, 2015  | Smallville |
      | Smallville Published Dataset    | AUTH-WC-Smallville | published    | Jul 21, 2014      | Jul 21, 2015  | Smallville |
      | Bludhaven Draft Dataset         | AUTH-WC-Bludhaven  | draft        | Jul 21, 2015      | Jul 21, 2015  | Bludhaven  |
      | Bludhaven Needs Review Dataset  | AUTH-WC-Bludhaven  | needs_review | Jul 21, 2015      | Jul 21, 2015  | Bludhaven  |
      | Bludhaven Published Dataset     | AUTH-WC-Bludhaven  | published    | Jul 21, 2014      | Jul 21, 2015  | Bludhaven  |
    And resources:
      | title                                        | dataset                        | author             | moderation   | format | groups audience  | moderation_date   |
      | Smallville Draft-Draft Resource              | Smallville Draft Dataset       | AUTH-WC-Smallville | draft        | csv    | Smallville       | Jul 21, 2015      |
      | Smallville Draft-Needs Review Resource       | Smallville Draft Dataset       | AUTH-WC-Smallville | needs_review | csv    | Smallville       | Jul 21, 2015      |
      | Smallville Draft-Published Resource          | Smallville Draft Dataset       | AUTH-WC-Smallville | published    | csv    | Smallville       | Jul 21, 2015      |
      | Bludhaven Needs Review-Draft Resource        | Bludhaven Needs Review Dataset | AUTH-WC-Bludhaven  | draft        | csv    | Bludhaven        | Jul 21, 2015      |
      | Bludhaven Needs Review-Needs Review Resource | Bludhaven Needs Review Dataset | AUTH-WC-Bludhaven  | needs_review | csv    | Bludhaven        | Jul 21, 2015      |
      | Bludhaven Needs Review-Published Resource    | Bludhaven Needs Review Dataset | AUTH-WC-Bludhaven  | published    | csv    | Bludhaven        | Jul 21, 2015      |
      | Bludhaven Published-Needs Review Resource    | Bludhaven Published Dataset    | AUTH-WC-Bludhaven  | needs_review | csv    | Bludhaven        | Jul 21, 2015      |
    And pages:
      | title         | url                                 |
      | My drafts     | admin/workbench/drafts-active       |
      | Needs review  | admin/workbench/needs-review-active |
      | Stale drafts  | admin/workbench/drafts-stale        |
      | Stale reviews | admin/workbench/needs-review-stale  |


  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should be able to see draft datasets I authored in "My Drafts"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "My drafts" page
    Then I should see the text "Smallville Draft Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see draft datasets I did not author in "My Drafts"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Bludhaven Draft Dataset"

  @api @disablecaptcha
  Scenario: As a Workflow Contributor, I should not be able to see Needs Review datasets I authored in "My Drafts"
    And I am logged in as "Auth-WC-Smallville"
    And I am on "My drafts" page
    Then I should not see the text "Smallville Needs Review Dataset"

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

  @api @disablecaptcha
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
