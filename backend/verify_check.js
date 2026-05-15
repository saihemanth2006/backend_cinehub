require('dotenv').config();
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;

function usage() {
  console.log('Usage: node verify_check.js <serviceSid> <toPhoneE164> <code>');
  console.log('Example: node verify_check.js VAxxxx +919876543210 123456');
}

async function main() {
  const args = process.argv.slice(2);
  if (args.length < 3) {
    usage();
    process.exit(1);
  }
  const [serviceSid, to, code] = args;

  if (!accountSid || !authToken) {
    console.error('TWILIO_ACCOUNT_SID or TWILIO_AUTH_TOKEN missing in .env');
    process.exit(2);
  }

  const client = require('twilio')(accountSid, authToken);
  try {
    const verificationCheck = await client.verify.services(serviceSid).verificationChecks.create({ to, code });
    console.log('Verification check status:', verificationCheck.status, 'sid:', verificationCheck.sid);
    if (verificationCheck.status === 'approved') {
      console.log('OTP verified successfully');
      process.exit(0);
    } else {
      console.log('OTP verification result:', verificationCheck);
      process.exit(3);
    }
  } catch (err) {
    console.error('Twilio Verify error:', err && err.message ? err.message : err);
    process.exit(3);
  }
}

main();
