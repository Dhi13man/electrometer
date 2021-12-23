import sendData from './send_data';

exports.handler = async function(event: any, context: any) {
    return sendData(event.queryStringParameters);
}