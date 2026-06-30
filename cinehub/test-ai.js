const http = require('http');

const data = JSON.stringify({
  module: 'script-development',
  task: 'story-expansion',
  input: 'A detective solving cyber crimes',
  options: { genre: 'sci-fi noir' }
});

const options = {
  hostname: 'localhost',
  port: 5000,
  path: '/api/v1/ai/test-generate',
  method: 'POST',
  timeout: 120000,
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': data.length
  }
};

console.log('🚀 Sending AI request...');
const startTime = Date.now();

const req = http.request(options, (res) => {
  let body = '';
  res.on('data', chunk => body += chunk);
  res.on('end', () => {
    const elapsed = ((Date.now() - startTime) / 1000).toFixed(2);
    console.log(`✅ Response received in ${elapsed}s`);
    console.log('Status:', res.statusCode);
    try {
      const parsed = JSON.parse(body);
      console.log('Response:', JSON.stringify(parsed, null, 2));
    } catch (e) {
      console.log('Response:', body);
    }
  });
});

req.on('error', e => {
  console.error('❌ Error:', e.message);
  process.exit(1);
});

req.on('timeout', () => {
  console.error('❌ Request timeout');
  req.destroy();
  process.exit(1);
});

req.write(data);
req.end();

setTimeout(() => {
  console.log('⏱️ Still waiting for response...');
}, 10000);
