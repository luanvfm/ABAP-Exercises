CLASS zcl_itab_basics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1. "Group character with length 1, i think its the agrupador.
    TYPES: BEGIN OF initial_type,
             group       TYPE group,
             number      TYPE i,
             description TYPE string,
           END OF initial_type,
           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY. "idk what EMPTY KEY Means, but its a table with the structure of initial_type.

    METHODS fill_itab
           RETURNING
             VALUE(initial_data) TYPE itab_data_type. "I dont understand that much what is VALUE() and what it does. is it a work area?.

    METHODS add_to_itab
           IMPORTING initial_data TYPE itab_data_type "Work Area inital_data do tipo de itab_data_type.
           
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.

    METHODS sort_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
            VALUE(updated_data) TYPE itab_data_type. "Cria a variavel updated_data e passa o tipo itab_data_type

    METHODS search_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
             VALUE(result_index) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_itab_basics IMPLEMENTATION.
  METHOD fill_itab.
    initial_data = VALUE #(
      (group = 'A' number = 10 description = 'Group A-2')
      (group = 'B' number = 5 description = 'Group B')
      (group = 'A' number = 6 description = 'Group A-1')
      (group = 'C' number = 22 description = 'Group C-1')
      (group = 'A' number = 13 description = 'Group A-3')
      (group = 'C' number = 500 description = 'Group C-2')
    ).
  ENDMETHOD.

  METHOD add_to_itab.
    updated_data = initial_data.
    APPEND VALUE #( group = 'A' number = 19 description = 'Group A-4' ) TO updated_data.
  ENDMETHOD.

  METHOD sort_itab.
    updated_data = initial_data.
    SORT updated_data BY group ASCENDING number DESCENDING.
  ENDMETHOD.

  METHOD search_itab.
    DATA(temp_data) = initial_data.
    SORT temp_data ASCENDING.
    LOOP AT temp_data INTO DATA(wa_line) WHERE number = 6.
        result_index = sy-tabix.
        EXIT.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
