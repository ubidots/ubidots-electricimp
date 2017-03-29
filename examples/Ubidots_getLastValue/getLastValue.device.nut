function mainLoop() {
    agent.send("get", "temp");
    imp.wakeup(10.0, mainLoop);
} 

mainLoop();

agent.on("get", function(data) {
    server.log(data);
});