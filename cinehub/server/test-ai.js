/**
 * Quick test script for the unified POST /ai/generate endpoint.
 * Run: node test-ai.js
 */
const http = require('http');

const BASE = 'http://localhost:5000';

function request(method, path, body, token) {
  return new Promise((resolve, reject) => {
    const data = body ? JSON.stringify(body) : null;
    const url = new URL(path, BASE);
    const opts = {
      hostname: url.hostname,
      port: url.port,
      path: url.pathname,
      method,
      headers: { 'Content-Type': 'application/json' },
    };
    if (data) opts.headers['Content-Length'] = Buffer.byteLength(data);
    if (token) opts.headers['Authorization'] = `Bearer ${token}`;

    const req = http.request(opts, (res) => {
      let buf = '';
      res.on('data', (c) => (buf += c));
      res.on('end', () => {
        try {
          resolve(JSON.parse(buf));
        } catch {
          resolve(buf);
        }
      });
    });
    req.on('error', reject);
    req.setTimeout(120000);
    if (data) req.write(data);
    req.end();
  });
}

async function main() {
  console.log('═══════════════════════════════════════');
  console.log('  CineHub AI Orchestration — Test Run');
  console.log('═══════════════════════════════════════\n');

  // 1. Login
  console.log('1️⃣  Logging in...');
  const loginRes = await request('POST', '/api/v1/auth/login', {
    email: 'test@cinehub.ai',
    password: 'TestPass123!',
  });

  if (loginRes.status !== 'success') {
    console.error('❌ Login failed:', loginRes.message);
    return;
  }

  const token = loginRes.data.tokens.accessToken;
  console.log('   ✅ Logged in as:', loginRes.data.user.displayName);
  console.log('   Token:', token.substring(0, 30) + '...\n');

  // 2. Test GET /ai/capabilities
  console.log('2️⃣  Fetching AI capabilities...');
  const capsRes = await request('GET', '/api/v1/ai/capabilities', null, token);
  if (capsRes.status === 'success') {
    const caps = capsRes.data;
    console.log('   ✅ Modules available:');
    for (const mod of caps) {
      console.log(`      • ${mod.module} (${mod.tasks.length} tasks)`);
    }
  } else {
    console.log('   ❌ Error:', capsRes.message || capsRes);
  }
  console.log();

  // 3. Test POST /ai/generate — Story Expansion
  console.log('3️⃣  Testing AI Generate: script-development / story-expansion');
  console.log('   Prompt: "A detective solving cyber crimes in 2050"');
  console.log('   ⏳ Calling Gemini...\n');

  const startTime = Date.now();
  const genRes = await request('POST', '/api/v1/ai/generate', {
    module: 'script-development',
    task: 'story-expansion',
    input: 'A detective solving cyber crimes in 2050',
    options: { genre: 'sci-fi noir', tone: 'dark and gritty' },
  }, token);

  const elapsed = Date.now() - startTime;

  if (genRes.status === 'success') {
    const result = genRes.data;
    console.log('   ✅ AI Generation Successful!');
    console.log('   ─────────────────────────────');
    console.log(`   Module:   ${result.module}`);
    console.log(`   Task:     ${result.task}`);
    console.log(`   Workflow: ${result.meta?.workflowName}`);
    console.log(`   Provider: ${result.meta?.provider}`);
    console.log(`   Model:    ${result.meta?.model}`);
    console.log(`   Tokens:   ${result.meta?.tokensUsed}`);
    console.log(`   Time:     ${elapsed}ms`);
    console.log(`   Cached:   ${result.meta?.cached}`);
    console.log('   ─────────────────────────────');

    if (result.data) {
      const d = result.data;
      console.log(`   Title:    ${d.title || '(none)'}`);
      console.log(`   Logline:  ${(d.logline || '').substring(0, 120)}...`);
      console.log(`   Keys:     ${Object.keys(d).join(', ')}`);
      if (d.characters) {
        console.log(`   Characters: ${d.characters.length} defined`);
      }
      if (d.threeActStructure) {
        console.log('   Three-Act Structure: ✅ present');
      }
    }
  } else {
    console.log('   ❌ Generation failed:', genRes.message || genRes.code);
    if (genRes.errors) console.log('   Errors:', JSON.stringify(genRes.errors));
    if (genRes.stack) console.log('   Stack:', genRes.stack.split('\n')[0]);
  }

  console.log('\n═══════════════════════════════════════');
  console.log('  Test complete');
  console.log('═══════════════════════════════════════');
}

main().catch((err) => {
  console.error('Fatal error:', err.message);
});
