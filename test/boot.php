<?php
/**
 * @file
 * Bootstraps Drupal 7 site.
 */

use Drupal\Driver\DrupalDriver;
use Drupal\Driver\Cores\Drupal7;
require 'vendor/autoload.php';

$dir = explode('/sites/', getcwd());
// Path to Drupal.
$path = $dir[0];

// Could be inside profiles folder.
if (count($dir) == 1) {
  $dir = explode('/profiles/', getcwd());
  $path = $dir[0];
}

// Could be inside projects folder.
if (count($dir) == 1) {
  $dir = explode('/projects/', getcwd());
  $path = $dir[0] . '/docroot';
}

// Host.
$uri = 'http://localhost';

$driver = new DrupalDriver($path, $uri);
$driver->setCoreFromVersion();

// Bootstrap Drupal.
$driver->bootstrap();
