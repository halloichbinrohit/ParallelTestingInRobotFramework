*** Settings ***
Library    SeleniumLibrary
Resource    ../utils/helpers.resource
Resource    ../utils/logging.resource

*** Variables ***
${login_logo}  css=div.login_logo
${username_input}  css=#user-name
${password_input}  css=#password
${login_button}    xpath=//input[@value='Login']

*** Keywords ***
Get Login Page Title
    ${title} =  Get Title
    RETURN  ${title}

Get Login Page Heading
    Wait Until Element Is Visible    ${login_logo}  10s  "Logo not loaded within 10 sec"
    ${heading_txt} =  Get Text    ${login_logo}
    RETURN  ${heading_txt}

Enter Username On Login Page
    [Arguments]    ${Username}
    Wait Until Element Is Enabled    ${username_input}  10s
    Clear Element Text    ${username_input}
    Input Text    ${username_input}  ${Username}

Enter Password On Login Page
    [Arguments]    ${Password}
    Wait Until Element Is Enabled    ${password_input}  10s
    Clear Element Text    ${password_input}
    Input Text    ${password_input}  ${Password}

Click On Login Button
    Wait Until Element Is Enabled    ${login_button}  10s
    Click Element    ${login_button}

Perform Login With Valid Credentials
      [Arguments]    ${Username}  ${Password}
      Log Info To File  Passing username=${Username} and password=${Password}
      Enter Username On Login Page  ${Username}
      Enter Password On Login Page  ${Password}
      Click On Login Button

Verify Error Message Displayed
    [Arguments]    ${error_msg}
    Wait Until Element Is Visible    //h3[.="${error_msg}"]  30s

Validate Login Functionality For Invalid Credentials
    [Arguments]    ${username}    ${password}    ${error_msg}
    Log Info To File    Test Data >>> Username: ${username}, Password: ${password}, Error: ${error_msg}
    Log    Username: ${username}, Password: ${password}, Error: ${error_msg}
    Enter Username On Login Page    ${username}
    Enter Password On Login Page    ${password}
    Click On Login Button
    Verify Error Message Displayed    ${error_msg}
    Log Text In Report    Error Message: ${error_msg} displayed on page
    Log Info To File    Error Message: ${error_msg} displayed on page
    Capture And Attach Screenshot In Report
    