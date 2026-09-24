#!/usr/bin/env node
// Reliable HLS downloader for the anime1 mirror sites that `anime1-cli` cannot
// parse (anime1.in, mmov.io, ...). Reuses anime1-core's HLS engine, which
// fetches segments in parallel, retries flaky CDNs, and resumes from cached
// parts. Optionally remuxes to mp4 with ffmpeg (`-c copy`, no re-encode).
//
// Usage:  node hls-to-mp4.mjs <m3u8-url> <output-base> [--mp4]
//   <output-base> must NOT include the extension (e.g. ".../示範 [01]").
//
// Why not plain `ffmpeg -i <m3u8> out.mp4`: ffmpeg has no read timeout on a
// stalled CDN connection and hangs forever; this engine does not.
import { execFileSync, execSync } from 'node:child_process';
import { rmSync } from 'node:fs';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
function coreEntry() {
  try {
    return require.resolve('anime1-core');
  } catch {
    const root = execSync('npm root -g', { encoding: 'utf8' }).trim();
    return `${root}/anime1-cli/node_modules/anime1-core/dist/index.js`;
  }
}
const { downloadHls } = await import(coreEntry());

const [m3u8, outBase, flag] = process.argv.slice(2);
if (!m3u8 || !outBase) {
  console.error('usage: node hls-to-mp4.mjs <m3u8-url> <output-base> [--mp4]');
  process.exit(2);
}
const UA = process.env.ANIME1_UA || 'Mozilla/5.0';

let path;
for (let attempt = 1; ; attempt++) {
  try {
    path = await downloadHls({ src: m3u8, cookies: {} }, outBase, { net: { userAgent: UA }, connections: 6 });
    break;
  } catch (e) {
    if (attempt >= 20) throw e;
    console.error(`attempt ${attempt} failed (${e.cause?.code ?? e.message}); retrying`);
    await new Promise((r) => setTimeout(r, 3000));
  }
}
if (flag === '--mp4' && path.endsWith('.ts')) {
  const mp4 = `${outBase}.mp4`;
  execFileSync('ffmpeg', ['-hide_banner', '-loglevel', 'error', '-y', '-i', path, '-c', 'copy', '-bsf:a', 'aac_adtstoasc', mp4]);
  rmSync(path, { force: true });
  path = mp4;
}
console.log(path);
