*** Settings ***
Library    SeleniumLibrary

Test Teardown    Close Browser     # no final, fecha o navegador

*** Variables ***
${url}    https://www.saucedemo.com/
${browser}    Chrome

*** Test Cases ***
# Frases --> Keywords

Selecionar Sauce Labs Backpack
    Dado que acesso o site SauceDemo
    Quando preencho o campo usuario    standard_user
    E preencho o campo senha    secret_sauce
    E clico no botao Login
    Então sou direcionado para pagina de produtos
    Quando clico no produto    Sauce Labs Backpack    $29.99
    Então sou direcionado para a pagina do produto
    Quando clico em adicionar no carrinho
    Entao visualizo o numero de itens no carrinho    1
    Quando clico no icone carrinho
    Entao sou direcionado para pagina carrinho

Selecionar Sauce Labs Backpack Login com Enter
    Dado que acesso o site SauceDemo
    Quando preencho o campo usuario    standard_user
    E preencho o campo senha    laranja
    E pressiono a tecla enter

*** Keywords ***
Dado que acesso o site SauceDemo
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    10000ms
    Wait Until Element Is Visible    css=.login_logo    50000ms
Quando preencho o campo usuario
    [Arguments]    ${username}
    Input Text    css=[data-test="username"]    ${username}
E preencho o campo senha
    [Arguments]    ${password}
    Input Password    css=[data-test="password"]    ${password}
E clico no botao Login   
    Click Button    id=login-button
E pressiono a tecla enter
    Press Key    css=[data-test="password"]    ENTER
Então sou direcionado para pagina de produtos
    Element Text Should Be    css[data-test="title"]    Products
Quando clico no produto
    [Arguments]    ${product_name}    ${product_price}
    Set Test Variable    ${test_product_name}    ${product_name}
    Set Test Variable    ${test_product_price}    ${product_price}
    Click Element    css=img[alt="${test_product_name}"]
Então sou direcionado para a pagina do produto
    Element Text Should Be    name=back-to-products    Back to products
    Element Text Should Be    css=div.inventory_details_name.large_size    ${test_product_name}
    Element Text Should Be    css=div.inventory_details_price    ${test_product_price}

Quando clico em adicionar no carrinho
    Click Element    css=button.btn.btn_primary.btn_small.btn_inventory
Entao visualizo o numero de itens no carrinho    
    [Arguments]    ${cart_itens}
    Set Test Variable    ${test_cart_itens}    ${cart_itens}
    Alert Should Be Present    css=span.shopping_cart_badge    ${test_cart_itens}
Quando clico no icone carrinho
    Click Link    ${test_cart_itens}
Entao sou direcionado para pagina carrinho
    Wait Until Element Contains    css=.title    Your Cart
    Element Text Should Be    css=div.iventory_item_name    ${test_product_name}
    Element Text Should Be    css=div.iventory_item_price    ${test_product_price}   
    Element Text Should Be    css=div.cart_quantity            ${test_cart_itens} 
               



