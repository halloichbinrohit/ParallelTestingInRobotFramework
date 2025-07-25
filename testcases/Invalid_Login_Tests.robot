*** Settings ***
Documentation       This suite performs checks for invalid logins
Variables           ../testdata/invalid_login_test_data.py
Resource            ../pages/Login_Page.resource
Resource            ../pages/Home_Page.resource
Resource            ../utils/helpers.resource
Resource            ../utils/common.resource
Resource            ../utils/logging.resource
Test Setup  Run Keywords  Before Test  AND  Launch Browser With Clean State  https://www.saucedemo.com/  chrome
Test Teardown  Run Keywords  After Test  AND  Close Browser
Test Template       Validate Login Functionality For Invalid Credentials

*** Test Cases ***                        USERNAME              PASSWORD                ERROR_MSG
Login with user but empty password        ${valid_username}     ${EMPTY}                ${password_required_msg}
Login with empty user but password        ${EMPTY}              ${valid_password}       ${username_required_msg}
Valid user but invalid password           ${valid_username}     ${invalid_password}     ${usrname_passwd_not_match_msg}
Invalid user but valid password           ${invalid_username}   ${valid_password}       ${usrname_passwd_not_match_msg}
Login with locked out user                ${locked_username}    ${valid_password}       ${lockd_user_msg}

