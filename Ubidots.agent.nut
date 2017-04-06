// Copyright (c) 2017 Ubidots 
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT
//
// Made by Maria Carlina Hernandez for Ubidots


// create a namespace

if (!("Ubidots" in getroottable())) Ubidots <- {};

class Ubidots.Client {

    static version = "1.0.0";

    _SERVER = "http://things.ubidots.com"
    _token =  null;
    _dsLabel  = imp.configparams.deviceid;


    //  constructor
    constructor(token, SERVER = null) {
        this._token = token;

        if (SERVER != null) this._SERVER = SERVER;
    }
    /*********************************************************************
     * This function is to set you data source name
     * @arg dsName is the name of your data source name 
     * @return true uppon succes
     *********************************************************************/
    function setDeviceName(dsName){
        _dsLabel = dsName
        return true 
    }
    /*********************************************************************
     * This function is to get variable information from the Ubidots API
     * @arg dsLabel device label where you will get the data 
     * @arg varLabel variable label where you will get the data 
     * @return response.body see https://ubidots.com/docs/api/index.html#get-values
     *********************************************************************/
    function get(dsLabel, varLabel, callback) {
        local headers = {"Content-Type": "application/json", "X-Auth-Token": _token};
        local url = _SERVER + "/api/v1.6/devices/" + dsLabel + "/" + varLabel + "/values?page-size=1";
        local request = http.get(url, headers);
        request.sendasync(function(resp) {
            if(callback != null){
                if (resp.statuscode != 200) {
                    server.error("error sending message: " + response.body);
                    callback(null);
                } else {
                    callback(resp.body);
                }
            }
        }.bindenv(this));
    }
    /*********************************************************************
     * This function is to get the last value from the Ubidots API
     * @arg dsLabel device label where you will get the data 
     * @arg varLabel variable label where you will get the data 
     * @return float:value the last value of the data from the Ubidots API
     *********************************************************************/
    function getLastValue(dsLabel, varLabel, callback) {
        get(dsLabel, varLabel, function(resp){
            local respJson = http.jsondecode(resp);    
            if(callback == null){
                return;
            }
            try {
                callback(respJson.results[0].value);
            } catch (ex) {
                callback(null);
            }
        });
    }
    /*********************************************************************
     * Send one value to a variable 
     * see https://ubidots.com/docs/api/index.html#send-values-to-one-variable
     * @arg varLabel variable label to save in a struct
     * @arg data the value of the variable that you want to send
     * @return response send one value to a variable 
     ********************************************************************/
     function sendToVariable(varLabel, data, callback = null) {
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
        local url = _SERVER + "/api/v1.6/devices/" + _dsLabel + "/" + varLabel + "/values";
        local request = http.post(url, headers, body); 
        request.sendasync(function(resp) {
            if(callback != null){
                callback(resp);
            }
        }.bindenv(this));
    }
    /*********************************************************************
     * Send multiple variables to a device
     * @arg data table with the values that you want to send
     * @return response send multiple variables to a device
     ********************************************************************/
    function sendToDevice(data, callback = null) {
        
        local headers = {"Content-Type": "application/json", "X-Auth-Token": _token};
        local url = _SERVER + "/api/v1.6/devices/" + _dsLabel;
        local body = http.jsonencode(data);
        local request = http.post(url, headers, body); 
        request.sendasync(function(resp) {
            if(callback != null){
                callback(resp);
            }
        }.bindenv(this));
    }
}

