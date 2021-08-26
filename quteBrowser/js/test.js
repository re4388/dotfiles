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
console.log(allTicket.toString().replace(/,/g, ' '));

// console.log(allTicket);
// var re = /RAI-\d+/gm;
// var str = 'fee fi fo fum';
// var myArray = str.match(re);
// console.log(myArray);

// const issues = 'RAI-3114 RAI-790 RAI-2873';
