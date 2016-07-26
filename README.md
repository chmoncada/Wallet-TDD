# Practica TDD
# KeepCoding - Wallet-TDD

Se termino de diseñar el modelo de la App Wallet con TDD del curso online.

## Estructura

Se crearon los siguientes modelos:

* AGTMoney
* AGTBroker
* AGTWallet

Para la práctica, aparte de los métodos del curso se implementaron los métodos

* addMoney:
* takeMoney:

Y se implementaron los siguientes Tests:

* testAddMoney
* testTakeMoney

Se modificaron los siguientes Test comparados con los del curso Online:

* testSimpleAddition (AGTMonetTests) - Se añadio el escenario de evitar la suma simple de dos monedas de diferente currency

Se modifico el modelo AGTMoney y AGTWallet para que pueda aceptar monedas de tipo float.


## Controladores

Se creo una tabla con las características solicitadas en el enunciado de la práctica.

Se crearon los tests del data source de la tabla:

* testThatTableHasOneSectionPerCurrency
* testThatNumberofCellsIsNumberOfMoneyPlusOne

## App

Se creo una tabla de ejemplo para mostrar la funcionalidad de secciones por divisa y celdas de subtotales y Gran Total.  Se seteo la vista para mostrar dos decimales.

Para esto se implementaron los metodos del Data Source:

* tableView:cellForRowAtIndexPath
* tableView:titleForHeaderInSection
