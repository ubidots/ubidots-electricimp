const TOKEN = "@{UBIDOTS_TOKEN}";
const device_label = "electricimp";
const variable_label = "sensor";

device_id <- ""; //

class UbidotsAgentTestCase extends ImpTestCase {

    ubiAgent = null;

    function setUp() {
        ubiAgent = Ubidots.Client(TOKEN);
    }

    function testSetDeviceLabel() {
        local expression = regexp(@"\w+");
        ubiAgent.setDeviceLabel(device_label);
        return Promise(function (success, failure) {
            if (expression.match(device_label)) {
                this.assertEqual(ubiAgent._dsLabel, device_label);
                success("Device label well defined");
            } else {
                failure("Device label wrong defined, contain non-alphanumeric character");
            }
        }.bindenv(this));
    }

    function testGetBodyParameters() {
        local data = 123.45;
        ubiAgent.setDeviceLabel(device_label);
        ubiAgent.sendToVariable(variable_label, data);
        return Promise(function(success, failure) {
            ubiAgent.get(device_label,variable_label, function(err, response) {
                response = http.jsondecode(response);
                this.info(response);
                device_id = response["datasource"]["id"];
                this.assertEqual(response["datasource"]["name"], device_label);
                this.assertEqual(response["datasource"]["label"], device_label);
                this.assertEqual(response["name"], variable_label);
                this.assertEqual(response["label"], variable_label);
                this.assertEqual(response["last_value"]["value"], data);
                success("Parameters verified: name of the variable, label of the variable, and last value obtained");
            }.bindenv(this));
        }.bindenv(this));
    }

    function testGetNotFound() {
        return Promise(function(success, failure) {
            ubiAgent.get(device_label, variable_label, function(err, response) {
                this.assertEqual(typeof(err), "table");
                this.assertEqual(err.status, 404);
                success("Device or Variable labels not found");
            }.bindenv(this));
        }.bindenv(this));
    }

    function testGetAuthentication() {
        ubiAgent._token = "xxxxxxxxxx";
        return Promise(function(success, failure) {
            ubiAgent.get(device_label, variable_label, function(err, response) {
                this.assertEqual(typeof(err), "table");
                this.assertEqual(err.status, 403);
                success("Authentication credentials were not provided");
            }.bindenv(this));
        }.bindenv(this));
    }

    function testGetLastValue() {
        local data = 123.45;
        ubiAgent.setDeviceLabel(device_label);
        ubiAgent.sendToVariable(variable_label, data);
        ubiAgent.get(device_label,variable_label, function(err, response) {
            response = http.jsondecode(response);
            device_id = response["datasource"]["id"];
        }.bindenv(this));

        return Promise(function(success, failure) {
            ubiAgent.getLastValue(device_label, variable_label, function(err, response) {
                this.assertEqual(response, data);
                success("Parameters verified: Last value of a variable");
            }.bindenv(this));
        }.bindenv(this));
    }

    function testGetLastValueNotFound() {
        return Promise(function(success, failure) {
            ubiAgent.getLastValue(device_label, variable_label, function(err, response) {
                this.assertEqual(typeof(err), "table");
                this.assertEqual(err.status, 404);
                success("Device or Variable labels not found");
            }.bindenv(this));
        }.bindenv(this));
    }

    function testGetLastValueAuthentication() {
        ubiAgent._token = "xxxxxxxxxx";
        return Promise(function(success, failure) {
            ubiAgent.getLastValue(device_label, variable_label, function(err, response) {
                this.assertEqual(typeof(err), "table");
                this.assertEqual(err.status, 403);
                success("Authentication credentials were not provided");
            }.bindenv(this));
        }.bindenv(this));
    }

    function testSendToVariable() {
        local data = 123.45;
        local expression = regexp(@"\w+");
        return Promise (function(success, failure) {
            if (expression.match(variable_label)) {
                ubiAgent.setDeviceLabel(device_label);
                ubiAgent.sendToVariable(variable_label, data, function(err, response) {
                    response = http.jsondecode(response);
                    this.assertEqual(response["value"], data);
                    ubiAgent.get(device_label, variable_label, function(err, response) {
                      response = http.jsondecode(response);
                      device_id = response["datasource"]["id"];
                      success("Parameters verified: Data to be sent");
                    }.bindenv(this));
                }.bindenv(this));
            } else {
                failure("Variable label wrong defined, contain non-alphanumeric character");
            }
        }.bindenv(this));
    }

    function testSendtoVariableAuthentication() {
        ubiAgent._token  = "xxxxxxxxxx";
        return Promise(function(success, failure) {
            ubiAgent.setDeviceLabel(device_label);
            ubiAgent.sendToVariable(device_label, variable_label, function(err, response) {
                this.assertEqual(typeof(err), "table");
                this.assertEqual(err.status, 403);
                success("Authentication credentials were not provided");
            }.bindenv(this));
        }.bindenv(this));
    }

    function testSendToDevice() {
        local data = {"sensor": 25.67, "battery": 5.00, "status": 1.00};
        return Promise (function(success, failure) {
            ubiAgent.setDeviceLabel(device_label);
            ubiAgent.sendToDevice(data, function(err, response) {
                response = http.jsondecode(response);
                this.assertEqual(typeof(data), "table");
                this.assertEqual(response["sensor"][0]["status_code"], 201);
                this.assertEqual(response["battery"][0]["status_code"], 201);
                this.assertEqual(response["status"][0]["status_code"], 201);
                ubiAgent.get(device_label, variable_label, function(err, response) {
                    response = http.jsondecode(response);
                    device_id = response["datasource"]["id"];
                    success("Parameters verified: Data to be sent");
                }.bindenv(this));
            }.bindenv(this));
        }.bindenv(this));
    }

    function testSendToDeviceAuthentication() {
        ubiAgent._token = "xxxxxxxxxx";
        local data = {"temperature": 25.67, "humidity": 50.00, "pressure": 34.53};
        return Promise(function(success, failure) {
            ubiAgent.setDeviceLabel(device_label);
            ubiAgent.sendToDevice(data, function(err, response) {
                this.assertEqual(typeof(err), "table");
                this.assertEqual(err.status, 403);
                success("Authentication credentials were not provided");
            }.bindenv(this));
        }.bindenv(this));
    }

    function tearDown() {
        local headers = {"x-auth-token": TOKEN};
        local url = "https://things.ubidots.com/api/v1.6/datasources/"+ device_id;
        local request = http.httpdelete(url, headers);
        local response = request.sendsync();
        if (response.statuscode == 204) {
            this.info("Device successful deleted");
        }
        return "Test finished";
    }
}
