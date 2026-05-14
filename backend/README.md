CineHub OTP Backend

This is a minimal Node.js/Express backend that provides two endpoints for sending and verifying OTPs using Twilio SMS.

Setup

1. Copy `.env.example` to `.env` and set your credentials and phone number:

```
TWILIO_ACCOUNT_SID=AC920d3eb6b1465b8d138752e87a5d35a8
TWILIO_AUTH_TOKEN=8c5c10beb0d807b44e258845889a2aa5
TWILIO_PHONE_NUMBER=+1YOURTWILIONUMBER
# PORT is optional. Set if you need to run on a specific port (e.g. PORT=8080)
OTP_TTL_SECONDS=300
```

Note: For security do NOT commit `.env` with real credentials.

2. Install dependencies:

```bash
cd backend
npm install
```

3. Run the server:

```bash
npm run start
# or for development with auto-reload:
# npm run dev
```

Endpoints

- POST /send-otp
  - body: { "phone": "+1555..." }
  - sends an SMS with a 6-digit OTP and returns { ok: true }

- POST /verify-otp
  - body: { "phone": "+1555...", "otp": "123456" }
  - verifies the OTP and returns { ok: true } on success

Security & Production

- This example uses an in-memory Map to store OTPs — use Redis or a database for production.
- Rate-limit requests to avoid abuse.
- Use Twilio Verify service for a production-ready solution.

Integration

Call these endpoints from the Flutter signup flow (e.g., when user taps "Send OTP" and when verifying). After successful `/verify-otp` return, proceed with signup and navigation.
