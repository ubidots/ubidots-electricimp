# Ubidots - electric imp

The Ubidots library allows you to easily integrate your agent code with the Ubidots Platform. This library provides an easy way to to send multiple values to the Ubidots API, you just need the name and the value that you want to send. In addition you are able to get the last value from a variable of your Ubidots account.

To add this library to your project, add **#require "Ubidots.class.nut:1.0.0"** to the top of your device code.

## Requirements
* electric imp device
* An [electric imp account](https://electricimp.com/)
* An [Ubidots account](https://app.ubidots.com/accounts/signup/)

#  Ubidots.client
## Constuctor: Ubidots.Client(token, server)

To create a new Ubidots client, you need to call the constructor with your Ubidots' **token**:
```c
client <- Ubidots.Client("YOUR_TOKEN")
```

## Ubidots.Client.get(dsLabel, varLabel)

This function is to get the information of a variable from the Ubidots API:
```c

```

## Ubidots.Client.getLastValue(dsLabel, varLabel)

This function is to get the last value of a variable from the Ubidots API:
```c

```

## Ubidots.Client.sendtoUbidots(dsLabel, data)

This function is to send all data of all variables that you created:
```c

```
