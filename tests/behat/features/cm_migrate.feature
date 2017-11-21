@lightning @workflow @api
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
