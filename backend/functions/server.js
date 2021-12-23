const sendData = require('./send_data');

exports.handler = async function(event, context) {
    return sendData(event.queryStringParameters);
}