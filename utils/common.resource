*** Settings ***
Documentation    Common Resource File Containing the keyword for handling os and browser related stuff
Library    SeleniumLibrary
Library    OperatingSystem
Resource   logging.resource

*** Variables ***
${CHROME_OPTIONS}    add_experimental_option("prefs", {"credentials_enable_service": False, "profile.password_manager_enabled": False})

*** Keywords ***
Before Test
    Log Info To File  ***** [ START OF TEST - ${TEST_NAME} ] ******
    
After Test
    Log Info To File  ***** Test Status: ${TEST_STATUS} *****
    Log Info To File  ***** [ END OF TEST - ${TEST_NAME} ] *****
    
Launch Browser With Clean State
    [Arguments]    ${url}  ${browser}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${prefs}=      Evaluate    {"credentials_enable_service": False, "profile.password_manager_enabled": False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}

    ${tempdir}=    Evaluate    __import__('tempfile').mkdtemp()
    ${user_data_arg}=    Set Variable    --user-data-dir=${tempdir}

    Call Method    ${options}    add_argument    ${user_data_arg}
    Call Method    ${options}    add_argument    --no-default-browser-check
    Call Method    ${options}    add_argument    --no-first-run

    Open Browser    ${url}    ${browser}    options=${options}
    Log Info To File    Opening browser: ${browser} with url: ${url} and chrome-options: ${options}
    Maximize Browser Window

Clean Old Report Files
    #Remove Files    ${CURDIR}/results/*.*  ${CURDIR}/*.png  ${CURDIR}/*.html  ${CURDIR}/*.xml  ${CURDIR}/*.pabotsuitenames
    #Remove Directory    pabot_results  recursive=True
    #Remove Directory    ${EXECDIR}/allure-results  recursive=True
    #Run    rmdir /s /q ${EXECDIR}/allure-results
    #Remove Directory    results  recursive=True
    Remove Directory    ${EXECDIR}/logs  recursive=True