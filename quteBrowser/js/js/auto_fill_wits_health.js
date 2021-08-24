#!/usr/bin/env node
// const qute = require('qutejs');

console.log('this showup in dev tool');

async function openWebsite(url) {
  qute.open(['-t', url]);
  return new Promise((resolve) => setTimeout(resolve, 2000));
}

async function autoHealthyChecked(sleepInMs) {
  document.querySelector('#temperatureType0').click();
  return new Promise((resolve) => setTimeout(resolve, sleepInMs));
}

async function autoCheckNoProblem(sleepInMs) {
  document.querySelector('#symptomList0').click();
  return new Promise((resolve) => setTimeout(resolve, sleepInMs));
}

// btn btn-primary btn-block
async function clickSubmit(sleepInMs) {
  // document.querySelectorAll("button[type='submit']")[0].click();
  document.querySelectorAll(".btn-primary button[type='submit'"])[0].click();
  return new Promise((resolve) => setTimeout(resolve, sleepInMs));
}

async function run() {
  // TODO: able to open website from JS
  // await openWebsite('https://wits-rms.wistronits.com/healthy-tp/im011a');
  await autoHealthyChecked(1000);
  await autoCheckNoProblem(1000);
  await clickSubmit(1000);
}

run();

// ref
// https://www.reddit.com/r/qutebrowser/comments/p490cf/evaluate_javascript_in_qutebrowser/
// https://www.reddit.com/r/qutebrowser/comments/nctrpf/how_to_write_to_fifo_from_javascript/
