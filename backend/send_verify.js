require('dotenv').config();
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;

function usage() {
  console.log('Usage: node send_verify.js <serviceSid> <toPhoneE164>');
}

async function main() {
  const args = process.argv.slice(2);
  if (args.length < 2) {
    usage();
    process.exit(1);
  }
  const [serviceSid, to] = args;

  if (!accountSid || !authToken) {
    console.error('TWILIO_ACCOUNT_SID or TWILIO_AUTH_TOKEN missing in .env');
    process.exit(2);
  }

  const client = require('twilio')(accountSid, authToken);

  try {
    const verification = await client.verify.services(serviceSid).verifications.create({ to, channel: 'sms' });
    console.log('Verification status:', verification.status, 'sid:', verification.sid);
  } catch (err) {
    console.error('Twilio Verify error:', err && err.message ? err.message : err);
    process.exit(3);
  }
}

main();
