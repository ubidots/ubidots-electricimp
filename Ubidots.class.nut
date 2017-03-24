// Copyright (c) 2017 Electric Imp
// This file is licensed under the MIT License
// http://opensource.org/licenses/MIT


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
     * @arg 
     * @return 
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
     * @arg labels the labels where you will get the data (Data Source and Variable)
     * @return num the data that you get from the Ubidots API
     *********************************************************************/
    function getLastValue(dsLabel, varLabel) {

        local table = http.jsondecode(get(dsLabel, varLabel));
        local value = table.results[0].value;
        return value;
    }
    /*********************************************************************
     * Send the data of all variables that you added
     * @reutrn 
     ********************************************************************/
    function sendValues(dsLabel, varLabel, data) {
        
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
        return request.sendsync();
    }
}
