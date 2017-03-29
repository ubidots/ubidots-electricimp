// Copyright (c) 2017 Ubidots 
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT
//
// Made by Maria Carlina Hernandez for Ubidots



// create a namespace

if (!("Ubidots" in getroottable())) Ubidots <- {};

class Ubidots.Client {

    static version = [1, 0, 0];

    _SERVER = "http://things.ubidots.com"
    _token =  null;


    //  constructor
    constructor(token, SERVER = null) {
        this._token = token;

        if (SERVER != null) this._SERVER = SERVER;
    }
    /*********************************************************************
     * This function is to get variable information from the Ubidots API
     * @arg dsLabel device label where you will get the data 
     * @arg varLabel variable label where you will get the data 
     * @return response.body see https://ubidots.com/docs/api/index.html#get-values
     *********************************************************************/
    function get(dsLabel, varLabel) {
        local headers = {"Content-Type": "application/json", "X-Auth-Token": _token};
        local url = _SERVER + "/api/v1.6/devices/" + dsLabel + "/" + varLabel + "/values?page-size=1";
        local request = http.get(url, headers); 
        local response = request.sendsync();

        if (response.statuscode != 200) {
            server.error("eror sending message: " + response.body);
            return null;
        }
        return response.body;
    }
    /*********************************************************************
     * This function is to get the last value from the Ubidots API
     * @arg dsLabel device label where you will get the data 
     * @arg varLabel variable label where you will get the data 
     * @return float:value the last value of the data from the Ubidots API
     *********************************************************************/
    function getLastValue(dsLabel, varLabel) {
        local table = http.jsondecode(get(dsLabel, varLabel));
        local value = table.results[0].value;
        return value;
    }
    /*********************************************************************
     * Send one value to a variable 
     * see https://ubidots.com/docs/api/index.html#send-values-to-one-variable
     * @arg dsLabel device label to save in a struct
     * @arg varLabel variable label to save in a struct
     * @arg data the value of the variable that you want to send
     * @return response send one value to a variable 
     ********************************************************************/
     function sendToVariable(dsLabel, varLabel, data) {

        local tpData = typeof data;
        local body = "";
        
        if (tpData == "integer" || tpData == "float") {
            body = "{\"value\":" + data + "}";
        } else if (tpData == "string" ) { 
            body = data;
        } else {
            body  = http.jsonencode(data);
        }
        
        local headers = { "Content-Type": "application/json", "X-Auth-Token": _token};
        local url = _SERVER + "/api/v1.6/devices/" + dsLabel + "/" + varLabel + "/values";
        local request = http.post(url, headers, body); 
        local response =  request.sendsync();
        return response;  
    }
    /*********************************************************************
     * Send multiple variables to a device
     * @arg dsLabel device label to save in a struct
     * @arg varLabel variable label to save in a struct
     * @arg data the value of the variable that you want to send
     * @return response send multiple variables to a device
     ********************************************************************/
    function sendToDevice(dsLabel, data) {
        
        local headers = {"Content-Type": "application/json", "X-Auth-Token": _token};
        local url = _SERVER + "/api/v1.6/devices/" + dsLabel;
        local body = http.jsonencode(data);
        local request = http.post(url, headers, body); 
        local response =  request.sendsync();
        return response;
    }
}

