function mainLoop() {
    agent.send("get", "hola1");
    imp.wakeup(10.0, mainLoop);
} 

mainLoop();

agent.on("get", function(data) {
    server.log(data);
});