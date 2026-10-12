async page => {
  const sel = 'ytd-playlist-video-renderer';
  const total = await page.evaluate(() => {
    const t = document.body.innerText;
    const m = t.match(/(\d+)\s*部影片/) || t.match(/(\d+)\s*videos/);
    return m ? parseInt(m[1], 10) : 0;
  });
  for (let i = 0; i < 300; i++) {
    const n = await page.locator(sel).count();
    if (total && n >= total) break;
    await page.evaluate(() => {
      const els = document.querySelectorAll('ytd-playlist-video-renderer');
      els[els.length - 1]?.scrollIntoView({ block: 'end' });
    });
    await page.waitForTimeout(1000);
  }
  const items = await page.evaluate(() => {
    const seen = new Set();
    return [...document.querySelectorAll('ytd-playlist-video-renderer')].map(el => {
      const a = el.querySelector('a#video-title') || el.querySelector('h3 a');
      const title = (a?.getAttribute('title') || a?.textContent || '').trim();
      const href = a?.getAttribute('href') || '';
      const id = new URL(href, location.origin).searchParams.get('v');
      return { title, url: id ? 'https://www.youtube.com/watch?v=' + id : '' };
    }).filter(x => x.url && !seen.has(x.url) && seen.add(x.url));
  });
  return JSON.stringify({ declaredTotal: total, loaded: items.length, items });
}
