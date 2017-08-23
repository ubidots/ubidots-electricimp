const TOKEN = "Assign_Your_Ubidots_Token";

class UbidotsAgentTestCase extends ImpTestCase {

  ubiAgent = null;

  function setUp() {
    ubiAgent = Ubidots.Client(TOKEN);
  }

  function testSetDeviceLabel() {
    ubiAgent.setDeviceLabel("device-test");
    this.assertEqual(ubiAgent._dsLabel, "device-test");
  }

  function tearDown() {
    return "Test finished";
  }
}
