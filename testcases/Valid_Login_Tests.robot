*** Settings ***
Documentation    This suite performs checks for valid login
Name    Valid_Login_Suite
Library    AllureLibrary
Library    BuiltIn
Resource    ../pages/Login_Page.resource
Resource    ../pages/Home_Page.resource
Resource    ../utils/helpers.resource
Resource    ../utils/common.resource
Resource    ../utils/logging.resource
Test Setup  Run Keywords  Before Test  AND  Launch Browser With Clean State  https://www.saucedemo.com/  chrome
Test Teardown  Run Keywords  After Test  AND  Close Browser


*** Test Cases ***
Verify Login Successful For Valid Credentials
    Perform Login With Valid Credentials  standard_user  secret_sauce
    ${status} =  Verify Cart Link Displayed On Homepage
    Should Be Equal    ${status}  ${TRUE}
    Log Text In Report    Cart Link Displayed In Homepage post login: ${status}
    Log Info To File    Cart Link Displayed In Homepage post login: ${status}
    Capture And Attach Screenshot In Report
    Attach    Testing allure attach    Allure_Attachement    TEXT
    
