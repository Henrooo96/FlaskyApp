*** Settings ***
Documentation    Verify that UI user can register on the portal, login and review user details
Library    SeleniumLibrary
Resource   ../Resources/DemoKeywords.robot
Resource    ../Variables/variables.robot
Suite Setup    Launch browser and open web portal
Suite Teardown    Close All Browsers


*** Test Cases ***
Register as a new user through web portal
    Register new user with personal details
    Assert that new user is successfully registered
    [Tags]    New User Registration Test

Login with personal details
    Launch browser and open web portal
    Login with user details
    [Tags]    User Login Test

Review my own user information from the main view
    Launch browser and open web portal
    Login with user details
    Assert that user information is displayed on main view
    [Tags]    Review User Info Test






