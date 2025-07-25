*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${shopping_cart_lnk} =  css=.shopping_cart_container a

*** Keywords ***
Verify Cart Link Displayed On Homepage
    ${status} =  Run Keyword And Return Status    Wait Until Element Is Visible    ${shopping_cart_lnk}  10s
    RETURN  ${status}