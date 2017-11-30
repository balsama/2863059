# Migration path tests for Content Moderation.

## What this tests

#### This repo starts with the following:

* A sub-profile of Lightning 2.2.3
* Installed from config using patch #91 from Issue #2788777.
* English as the default language
* Italian Language defined and content translation enabled for several node
  types and block content types.
* Default node and block content in every moderation state and translation. 

#### Then updates to Lightning's CM Migrate branch and:

* Runs database updates
* Runs Lightning updates
* Asserts the following:
  * All node content is in the expected moderation state
  * Node content in each workflow has the expected transitions available
  * All block content is the expected moderation state 

#### It does not

* Assert that forward revisions can exist for more than one language of single
  entity.
* Assert that Quick Edit works as desired.

## Known Regressions:

#### Problems with the Content view that are MVP:
* FIXED ~~Does not show current moderation state.~~
* FIXED ~~Does not allow filtering by moderation state.~~
* FIXED ~~Shows duplicates of translated content.~~ [Issue #2927268](https://drupal.org/node/2927268)

#### Problems with the Content view that should be fixed, but aren't blockers:
* FIXED ~~Moderation state filter defaults to first Workflow's "Archived" state instead
  of "- Any -".~~ [Issue #2927217](https://drupal.org/node/2927217)

#### Problems with Content view that are currently blocked by core and won't be fixed in initial release:
* Does not show if a node has unpublished edits.

#### Other nice to haves, but not blockers:
* Lightning Scheduled Updates does not allow for scheduling multiple nodes at
  once.
* Content view shows moderation state machine names instead of human-readable.

#### Won't fix:
* No migration path for existing Scheduled Updates.
