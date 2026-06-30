import struct
import math

sr = 44100
dur = 2.5
n = int(sr * dur)
freqs = [(440, 0.3), (554.37, 0.2), (659.26, 0.15), (880, 0.1)]
samples = []

for i in range(n):
    # A cinematic orchestral swell (major chord)
    val = sum(a * math.sin(2 * math.pi * f * i / sr) * max(0, (1 - i / (sr * dur)))**(0.5 + f / 2000) for f, a in freqs)
    # Add a bass drop/boom at the beginning
    val += 0.08 * math.sin(2 * math.pi * 120 * i / sr) * max(0, 1 - i / (sr * 0.3))
    samples.append(val)

mx = max(abs(s) for s in samples) or 1
samples_int = [int(max(-32768, min(32767, s / mx * 28000))) for s in samples]

raw = b''.join(struct.pack('<h', s) for s in samples_int)
ch = 1
bps = 16
bs = ch * bps // 8
br = sr * bs
dl = len(raw)
fl = 36 + dl

hdr = struct.pack('<4sI4s4sIHHIIHH4sI', b'RIFF', fl, b'WAVE', b'fmt ', 16, 1, ch, sr, br, bs, bps, b'data', dl)

with open('e:/cinehub/assets/audio/splash_sound.wav', 'wb') as f:
    f.write(hdr + raw)
