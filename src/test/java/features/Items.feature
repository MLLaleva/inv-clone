@test
Feature: Items tests http://inv.bg/objects/manage

  Background:
    Given user is logged in the system
    Then user panel should contain text "karamfilovs@gmail.com"

  Scenario: Can navigate to items page
    When I navigate to Items page
    Then Add New Item button should contain text "Нов артикул"
    When I clean all items on API level


  Scenario Outline: Can create new item with valid information
    When I navigate to Items page
    And I wait 1 second for the students to see what is going on
    Then Add New Item button should contain text "Нов артикул"
    When I create new item with name "<name_bgn>" and nameENG "<name_eng>" and price "<price>" and priceQuantity "<price_quantity>"
    And I wait 1 second for the students to see what is going on
    Then item message with text should be displayed "Артикулът е добавен успешно."
    And I wait 1 second for the students to see what is going on
    When I delete all items
    Then item message with text should be displayed "Избраните артикули бяха изтрити успешно."
    Examples:
      | name_bgn         | name_eng       | price | price_quantity |
      | Кафе             | Coffee         | 10    | 1              |
      | Джони Уокър      | Johny Walker   | 25.56 | 1.1            |
      | Курс: Тестване 1 | Testing Course | 650   | 20             |


  Scenario Outline: Try to create new item with invalid information - "<reason>"
    When I navigate to Items page
    Then Add New Item button should contain text "Нов артикул"
    When I create new item with all fields like name "<name_bgn>" and nameENG "<name_eng>" and price "<price>" and priceQuantity "<price_quantity>" and account "<account>" and accountBatch "<accountBatch>"
    Then error message for invalid Item adding with text "Моля, въведете име/номенклатура на артикула." is displayed
    Examples:
      | reason      | name_bgn | name_eng | price | price_quantity | account  | accountBatch |
      | emptyBgName |          | Peach    | 100   | 100            | 15131231 | Partida123   |
