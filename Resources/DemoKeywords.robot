*** Settings ***
Documentation    Vairables and Keywords for Demo project
Library    SeleniumLibrary
Library    FakerLibrary
Resource    ../Variables/variables.robot


*** Keywords ***
Launch browser and open web portal
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Page Should Contain    index page
    Wait Until Element Is Visible    ${REGISTER}    10s

Register new user with personal details
    Click element   ${REGISTRATION}
    ${USERNAME}=    FakerLibrary.USERNAME
    Input text      ${USERNAME_FIELD}       ${USERNAME}
    Input text      ${PASSWORD_FIELD}       ${PASSWORD}
    ${FIRSTNAME}=    FakerLibrary.FIRSTNAME
    Input text      ${FIRSTNAME_FIELD}      ${FIRSTNAME}
    ${FAMILYNAME}=    FakerLibrary.LASTNAME
    Input text      ${FAMILYNAME_FIELD}     ${FAMILYNAME}
    ${PHONE_NUMBER}=    FakerLibrary.PHONE_NUMBER
    Input text      ${PHONE_FIELD}          ${PHONE_NUMBER}
    Wait Until Element Is Visible    ${REGISTER}
    Click element   ${REGISTER}

Assert that new user is successfully registered
    Page should contain     Log In
    Capture Page Screenshot

Login with user details
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Page Should Contain    index page
    Wait Until Element Is Visible    ${LOGIN}    10s
    Click element   ${LOGIN}
    Input text      ${USERNAME_FIELD}       ${USERNAME}
    Input text      ${PASSWORD_FIELD}       ${PASSWORD}
    Wait Until Element Is Visible    ${SignIn}    10s
    Click element   ${SignIn}
    Page Should Contain    User Information
    Capture Page Screenshot

Assert that user information is displayed on main view
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Page Should Contain    index page
    Wait Until Element Is Visible    ${LOGIN}    10s
    Click Element    ${LOGIN}
    Input text      ${USERNAME_FIELD}       ${USERNAME}
    Input text      ${PASSWORD_FIELD}       ${PASSWORD}
    Wait Until Element Is Visible    ${SignIn}    10s
    Click Element    ${SignIn}
    Page should contain     ${USERNAME}
    Page should contain     ${FIRSTNAME}
    Page should contain     ${FAMILYNAME}
    Page should contain     ${PHONE_NUMBER}
    Capture Page Screenshot