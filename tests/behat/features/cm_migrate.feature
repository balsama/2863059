@lightning @workflow @workflow_pre_migrate @api
Feature: Workflow migration
  As a Lightning user, my existing configuration and content should be migrated
  to the core Content Moderation module while prederving existing functionality.

  @dae100b0
  Scenario Outline: Existing content entities' states are preserved.
    Given I am logged in as a user with the administrator role
    When I visit "/admin/content"
    Then the moderation state for content "<title>" should be "<moderation_state>"

    Examples:
    | title                                          | moderation_state   |
    | Article Draft                                  | Draft              |
    | Article - Needs Review                         | Needs Review       |
    | Article - Published                            | Published          |
    | Article - Archived                             | Archived           |
    | Announcement - NLR                             | Needs Legal Review |
    | Announcement - with translation - en           | Published          |
    | Announcement - with translation - it           | Published          |
    | Announcement - with translation - en published | Published          |
    | Announcement - with translation - it draft     | Draft              |

  @d619fa06
  Scenario Outline: Draft and Needs Review articles can be transitioned to Draft, Needs Review,
  and Published states.
    Given I am logged in as a user with the administrator role
    When I visit "/node/<nid>"
    And I visit the edit form
    Then the "Moderation state" field should have options:
      """
      Draft
      Needs Review
      Published
      """

    Examples:
    | nid |
    | 1   |
    | 2   |

  @112a195c
  Scenario Outline: Published articles can be transitioned to Draft, Published,
  and Archived states.
    Given I am logged in as a user with the administrator role
    When I visit "/node/<nid>"
    And I visit the edit form
    Then the "Moderation state" field should have options:
      """
      Draft
      Published
      Archived
      """

    Examples:
      | nid |
      | 3   |

  @a3c2958d
  Scenario Outline: Archived articles and Needs Legal Review Announcements can
  be transitioned only to the Published state.
    Given I am logged in as a user with the administrator role
    When I visit "/node/<nid>"
    And I visit the edit form
    Then the "Moderation state" field should have options:
      """
      Published
      """

    Examples:
      | nid |
      | 4   |
      | 5   |

  @feecf207
  Scenario: Block entities' moderation state is preserved.
    Given I am logged in as a user with the administrator role
    When I visit "block/<1"
    Then "Current state" should be "Needs Review"