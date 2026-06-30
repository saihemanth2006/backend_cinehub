require('dotenv').config();
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const fromNumber = process.env.TWILIO_PHONE_NUMBER;

function usage() {
  console.log('Usage: node send_sms.js <toPhoneE164> [message]');
  console.log('Reads TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, TWILIO_PHONE_NUMBER from .env');
}

async function main() {
  const args = process.argv.slice(2);
  if (args.length < 1) {
    usage();
    process.exit(1);
  }
  const to = args[0];
  const message = args.slice(1).join(' ') || `Hello from CineHub - test message`;

  if (!accountSid || !authToken || !fromNumber) {
    console.error('TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN or TWILIO_PHONE_NUMBER missing in .env');
    console.error('Current values:');
    console.error('  TWILIO_ACCOUNT_SID:', !!accountSid);
    console.error('  TWILIO_AUTH_TOKEN:', !!authToken);
    console.error('  TWILIO_PHONE_NUMBER:', !!fromNumber);
    process.exit(2);
  }

  const client = require('twilio')(accountSid, authToken);

  try {
    const resp = await client.messages.create({ body: message, from: fromNumber, to });
    console.log('Message sent, sid=', resp.sid);
  } catch (err) {
    console.error('Twilio error:', err && err.message ? err.message : err);
    process.exit(3);
  }
}

main();
