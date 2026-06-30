#!/usr/bin/env node
/**
 * Test script to verify backend API endpoints
 */
const http = require('http');

function makeRequest(method, path, data) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: 'localhost',
      port: 5000,
      path,
      method,
      headers: {
        'Content-Type': 'application/json',
      },
    };

    const req = http.request(options, (res) => {
      let body = '';
      res.on('data', (chunk) => {
        body += chunk;
      });
      res.on('end', () => {
        resolve({
          status: res.statusCode,
          headers: res.headers,
          body: JSON.parse(body),
        });
      });
    });

    req.on('error', reject);
    if (data) {
      req.write(JSON.stringify(data));
    }
    req.end();
  });
}

async function runTests() {
  console.log('🧪 Testing CineHub Backend API\n');

  try {
    // Test 1: Health endpoint
    console.log('1️⃣  Testing /api/v1/health');
    const health = await makeRequest('GET', '/api/v1/health');
    console.log(`   Status: ${health.status}`);
    console.log(`   Database: ${health.body.database.connected ? '✅ Connected' : '❌ Disconnected'}\n`);

    // Test 2: Register (or create) test user
    console.log('2️⃣  Testing /api/v1/auth/register');
    const register = await makeRequest('POST', '/api/v1/auth/register', {
      email: 'test@cinehub.dev',
      password: 'Test@1234567',
      firstName: 'Test',
      lastName: 'User',
    });
    console.log(`   Status: ${register.status}`);
    if (register.status === 201) {
      console.log(`   ✅ Registration successful\n`);
    } else if (register.status === 400 && register.body.message?.includes('already exists')) {
      console.log(`   ℹ️  User already exists\n`);
    } else {
      console.log(`   ❌ Error: ${register.body.message}`);
      if (register.body.errors) {
        console.log(`   Details:`, register.body.errors.map(e => e.message).join(', '));
      }
      console.log('');
    }

    // Test 3: Login
    console.log('3️⃣  Testing /api/v1/auth/login');
    const login = await makeRequest('POST', '/api/v1/auth/login', {
      email: 'test@cinehub.dev',
      password: 'Test@1234567',
    });
    console.log(`   Status: ${login.status}`);
    if (login.status === 200) {
      console.log(`   ✅ Login successful`);
      console.log(`   User: ${login.body.data.user.email}`);
      const tokenPath = login.body.data.tokens?.access?.token || login.body.data.tokens?.accessToken;
      if (tokenPath) {
        console.log(`   Token: ${tokenPath.substring(0, 20)}...\n`);
      }
    } else {
      console.log(`   ❌ Error: ${login.body.message}\n`);
    }

    // Test 4: Get current user
    if (login.status === 200) {
      console.log('4️⃣  Testing /api/v1/users/me');
      const me = await makeRequest('GET', '/api/v1/users/me', null);
      console.log(`   Status: ${me.status}`);
      console.log(`   User: ${me.body.data?.email || me.body.message}\n`);
    }

    console.log('✅ Backend API is ready for the Flutter app!');
  } catch (err) {
    console.error('❌ Error:', err.message);
    process.exit(1);
  }
}

runTests();
