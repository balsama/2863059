@lightning @workflow @workflow_post_migrate @api
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
      | Article Draft                                  | draft              |
      | Article - Needs Review                         | needs_review       |
      | Article - Published                            | published          |
      | Article - Archived                             | archived           |
      | Announcement - NLR                             | needs_legal_review |
      | Announcement - with translation - en           | published          |
      | Announcement - with translation - it           | published          |
      | Announcement - with translation - en published | published          |
      | Announcement - with translation - it draft     | draft              |

  @d619fa06
  Scenario Outline: Draft and Needs Review articles can be transitioned to Draft, Needs Review,
  and Published states.
    Given I am logged in as a user with the administrator role
    When I visit "/node/<nid>"
    And I visit the edit form
    Then the "Change to" field should have options:
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
    Then the "Change to" field should have options:
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
    Then the "Change to" field should have options:
      """
      Published
      """

    Examples:
      | nid |
      | 4   |
      | 5   |

  @feecf207
  Scenario Outline: Block entities' moderation state is preserved.
    Given I am logged in as a user with the administrator role
    When I visit "/block/<bid>"
    Then I should see "Current state <moderation_state>"

    Examples:
      | bid | moderation_state |
      | 1   | Needs Review     |
      | 2   | Published        |
      | 3   | Published        |

  Scenario: Translated block moderation state is preserved.
    Given I am logged in as a user with the administrator role
    When I visit "/it/block/3"
    Then I should see "Current state Draft"