// Enter your Ubidots token
const TOKEN = "Assign_Your_Ubidots_Token";

// Constans for the test function
const TEST_DSLABEL = "electric-imp";
const TEST_VARLABEL = "sensor";

class UbidotsAgentTestCase extends ImpTestCase {

  ubiAgent = null;

  function setUp() {
    ubiAgent = Ubidots.Client(TOKEN);
  }

  function testSetDeviceLabel() {
    ubiAgent.setDeviceLabel("device-test");
    this.assertEqual(ubiAgent._dsLabel, "device-test");
  }

  function testGet() {

    return Promise(function(success, failure) {
      ubiAgent.get(TEST_DSLABEL, TEST_VARLABEL, function(v) {
        server.log("the last value is" + v);
      });

      if (callback != null) {
        server.log("good");
      } else {
        server.log("The callback is null");
      }
    }.bindenv(this));
  }

  function testGetLastValue() {

  }

  function testSendToVariable() {

  }

  function testSendToDevice() {

  }

  function tearDown() {
    return "Test finished";
  }
}
