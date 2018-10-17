const app = require("express")();
app.set("view engine", "pug");

//Body parser setup
const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
console.log('hello welcome to server defcon');
// const moment = require('moment');
var date = new Date();
function wait(ms) {
    const start = new Date().getTime();
    let end = start;
    while (end < start + ms) {
        end = new Date().getTime();
    }
}
app.get('/hello', (req, res) => {
    res.status(200).send('Hello, world!').end();
});
app.get('/IT-WAS-ME/WAS-ME-LOGIN-YES', (req, res) => {
    var exec = require('child-process-promise').exec;
    res.status(200).send('Ok DEFCON 5, all is clear').end();
});
app.get('/IT-WAS-ME/WAS-ME-LOGIN-NO', (req, res) => {

    const authCode = generateUUID();
    console.log('authCode', authCode);
    var createtextbox = document.createElement("INPUT");
    createtextbox.setAttribute("type", "text");
    wait(3000);
    if (authCode === createtextbox) {
        wait(1000);
        var exec = require('child-process-promise').exec;

        exec('sudo defcon1')
            .then(function (result) {
                var stdout = result.stdout;
                var stderr = result.stderr;
                console.log('stdout: ', stdout);
                console.log('stderr: ', stderr);
                res.status(200).send('OK, DEFCON 1 rebooting all nodes!: AT: '+ date).end();
                wait(1000);
                res.status(200).send('OK, DEFCON 1 rebooting all nodes!: '+ stderr).end();
                wait(1000);
                res.status(200).send('OK, DEFCON 1 rebooting all nodes!: '+ stdout).end()
                wait(1000);
            })
            .catch(function (err) {
                console.error('ERROR: ', err);
                wait(1000);
                res.status(200).send('Correct code but error: '+ err).end()
                wait(1000);
                res.status(200).send('Correct code but error: AT: '+ date).end();
            });
    } else {
        res.status(500).send('Error wrong auth code').end()
        wait(1000);
    }

});


function generateUUID() { // Public Domain/MIT
    let d = new Date().getTime();
    if (typeof performance !== 'undefined' && typeof performance.now === 'function') {
        d += performance.now(); //use high-precision timer if available
    }
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        let r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
}
function generateUUID() { // Public Domain/MIT
    let d = new Date().getTime();
    if (typeof performance !== 'undefined' && typeof performance.now === 'function') {
        d += performance.now(); //use high-precision timer if available
    }
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        let r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(6);
    });
}

app.listen(process.env.PORT || 3000);


