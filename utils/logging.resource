*** Settings ***
Library    ../libraries/logger.py

*** Keywords ***
#Starting Logger
#    Log To File  ************ Logger Initialized **************  ${PREV_TEST_NAME}

Log Info To File
    [Arguments]    ${message}
    Log To File    ${message}  ${TEST_NAME}