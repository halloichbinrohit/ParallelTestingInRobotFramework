*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Capture And Attach Screenshot In Report
    Capture Page Screenshot    EMBED

Log Text In Report
    [Arguments]    ${information_txt}
    Log    ${information_txt}
