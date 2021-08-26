const doneText = `
RAI-790
merge

RAI-2873
merge

RAI-3114
begin to work on, doc finished
`;

const todoText = `
RAI-3114
continue.
`;

// TODO this shall be auto-gen from above text
// const issues = 'RAI-3114 RAI-790 RAI-2873';
const regexForTicket = /RAI-\d+/gm;
const doneTicketArray = doneText.match(regexForTicket);
const todoTicketArray = todoText.match(regexForTicket);
const allTicket = [...new Set([...doneTicketArray, ...todoTicketArray])];
const allTicketString = allTicket.toString().replace(/,/g, ' ');

async function createStandupButton() {
  document.querySelector('#scrumstandup-standup-button-link').click();
  return new Promise((resolve) => setTimeout(resolve, 5000));
}

async function createStandupButtonDropDown() {
  document
    .querySelector('#scrum_standup_prepare_create_dialog_save_button')
    .click();
  return new Promise((resolve) => setTimeout(resolve, 5000));
}

async function inputDone(doneText) {
  // document.body.style.zoom = '70%';
  document.querySelector('#done').click();
  document.querySelector('#done').value = doneText;
  return new Promise((resolve) => setTimeout(resolve, 2000));
}

async function inputTodo(todoText) {
  document.querySelector('#toDo').click();
  document.querySelector('#toDo').value = todoText;
  return new Promise((resolve) => setTimeout(resolve, 2000));
}

async function linkedIssue(ticketNums) {
  let doc = document.querySelector('#issues_field-textarea');
  doc.value = ticketNums;
  // var e = new KeyboardEvent('keydown', {
  //   bubbles: true,
  //   cancelable: true,
  //   key: 'Enter',
  //   shiftKey: false,
  // });
  // doc.dispatchEvent(e);
  return new Promise((resolve) => setTimeout(resolve, 500));
}

async function clickSave(ticketNums) {
  document.querySelector('#save_button').click();
}

async function run() {
  // await createStandupButton();
  // await createStandupButtonDropDown();
  await inputDone(doneText);
  await inputTodo(todoText);
  await linkedIssue(allTicketString);
  // await clickSave();
}

run();
//
