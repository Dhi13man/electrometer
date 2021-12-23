const firestore = require("./database");

const db = firestore();
const sensor_data_collection = db.collection("sensor_data");

module.exports = async(query) => {
    console.log(query);
    const deviceID = query.deviceID;
    const current = parseFloat(query.current);
    const voltage = parseFloat(query.voltage);
    try {
        await firebaseDataSend(deviceID, current, voltage);
        return { statusCode: 200, body: "Data sent to Firestore!" }
    } catch (error) {
        return { statusCode: 500, body: error.message };
    }
};


/**
 * Send data to Firestore when data is received from the device on the endpoint.
 * @param {string} deviceID Device ID of the device that sent the data.
 * @param {number} current Average Current over 5 second window in Amps.
 * @param {number} voltage Average Voltage over 5 second window in Volts.
 * @returns {Promise<firestore.WriteResult>} Promise that resolves when data is 
 * either sent to Firestore or fails to send.
 */
const firebaseDataSend = async(
    deviceID,
    current,
    voltage,
) => {
    const entry = sensor_data_collection.doc(deviceID);
    const power = calculatePower(current, voltage);
    // Get ISO8601 timestamp
    const currentTimestamp = new Date().toISOString();
    // Get the document, or create it if it doesn't exist
    const doc = await entry.get();
    // If the document doesn't exist, create it
    if (!doc.exists) {
        return entry.set({
            deviceID: entry.id,
            latestCurrent: current,
            latestVoltage: voltage,
            aggregatePower: power,
            history: [{ current, voltage, timestamp: currentTimestamp, power: power }],
        });
    } else {
        // Add the new data to the history array
        const history = doc.data().history;
        history.push({ current, voltage, timestamp: currentTimestamp, power: power });
        // Update the document with the new data
        return entry.update({
            latestCurrent: current,
            latestVoltage: voltage,
            aggregatePower: power + doc.data().aggregatePower,
            history,
        });
    }
};

/**
 * Calculate power in KWh assuming average current and voltage in window of 5 seconds is known.
 * @param {number} current Average Current in Amps
 * @param {number} voltage Average Voltage in Volts
 * @returns {number} Power in KWh for this 5 second window.
 */
const calculatePower = (current, voltage) =>
    (current * voltage) * (5 / 3600) / 1000;