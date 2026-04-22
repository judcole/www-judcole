/*
    2026-04-21 Puppeteer configuration
*/

/** @type {import("puppeteer").Configuration} */

export default {
  // Download Chrome (default `skipDownload: false`).
  chrome: {
    skipDownload: false,
  },
  // Download Firefox (default `skipDownload: true`).
  firefox: {
    skipDownload: true,
  },
}
