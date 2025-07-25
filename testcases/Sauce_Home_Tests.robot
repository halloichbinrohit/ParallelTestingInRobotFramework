*** Settings ***
Documentation    This suite performs basic checks for saucedemo website launched page title and homepage header
Name    Sauce_Home_Suite
Resource    ../pages/Login_Page.resource
Resource    ../utils/helpers.resource
Resource    ../utils/common.resource
Resource    ../utils/logging.resource
Test Setup  Run Keywords  Before Test  AND  Launch Browser With Clean State  https://www.saucedemo.com/  chrome
Test Teardown  Run Keywords  After Test  AND  Close Browser

*** Test Cases ***
Verify Login Page Title For SauceDemo Website
    ${title}  Get Login Page Title
    Should Be Equal As Strings    ${title}  Swag Labs
    Log Text In Report    Website title is ${title} and matched
    Log Info To File    Website title is ${title} and matched
    

Verify Login Page Heading Displayed With Required Text
    ${heading}  Get Login Page Heading
    Should Be Equal    ${heading}  Swag Labs
    Log Text In Report    Header Text is ${heading} and matched
    Capture And Attach Screenshot In Report
    Log Info To File    Header Text is ${heading} and matched