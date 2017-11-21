<?php
/**
 * @file
 * Contains \CmMigrateSubContext.
 */

use Behat\Gherkin\Node\TableNode;
use Behat\Mink\Exception\ExpectationException;
use Drupal\Core\Entity\EntityInterface;
use Drupal\DrupalExtension\Context\DrupalContext;
use Behat\Mink\Element\NodeElement;
use Drupal\DrupalExtension\Context\DrupalSubContextBase;
use Drupal\DrupalExtension\Hook\Scope\EntityScope;
use Drupal\node\Entity\Node;
use Drupal\taxonomy\Entity\Term;
use Drupal\user\Entity\User;
use Drupal\workbench_moderation\Entity\ModerationState;

/**
 * Subcontext for helping with CM Migration tests.
 */
class CmMigrateSubContext extends DrupalSubContextBase {

  /**
   * Navigates to the edit page for a given node and language.
   *
   * @Given I edit node :nid language :lang
   */
  public function editNodeLanguage($nid, $lang) {
    if ($lang == 'en') {
      $url = '/node/' . $nid . '/edit';
    }
    else {
      $url = '/' . $lang . '/node' . $nid . '/edit';
    }

    $this->visitPath($url);
  }

  /**
   * @Then the moderation state for content :title should be :moderation_state
   */
  public function assertModerationState($title, $moderation_state) {
    $page = $this->getSession()->getPage();

    $elements = $page->findAll('css', '.views-field.views-field-title a');
    foreach ($elements as $element) {
      $value = $element->getHtml();
      if ($value == $title) {
        break;
      }
    }
    /* @var $row \Behat\Mink\Element\NodeElement */
    $row = $element->getParent()->getParent();
    $current_moderation_state = trim($row->find('css', '.views-field.views-field-moderation-state')->getHtml());
    if ($current_moderation_state !== $moderation_state) {
      throw new \Exception("Current moderation state is $current_moderation_state but $moderation_state expected.");
    }
  }

  /**
   * @Then /^the option "([^"]*)" from select "([^"]*)" is selected$/
   */
  public function theOptionFromSelectIsSelected($optionValue, $select) {
    $selectField = $this->getSession()->getPage()->find('css',$select);
    if (null === $selectField) {
      throw new \Exception(sprintf('The select "%s" was not found in the page %s', $select, $this->getSession()->getCurrentUrl()));
    }

    $optionField = $selectField->find('xpath', "//option[@selected='selected']");
    if (null === $optionField) {
      throw new \Exception(sprintf('No option is selected in the %s select in the page %s', $select, $this->getSession()->getCurrentUrl()));
    }

    if ($optionField->getValue() != $optionValue) {
      throw new \Exception(sprintf('The option "%s" was not selected in the page %s, %s was selected', $optionValue, $this->getSession()->getCurrentUrl(), $optionField->getValue()));
    }
  }

}