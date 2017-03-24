function mainLoop() {
    agent.send("get", "test");
    imp.wakeup(10.0, mainLoop);
} 

mainLoop();

agent.on("get", function(data) {
    server.log(data);
});