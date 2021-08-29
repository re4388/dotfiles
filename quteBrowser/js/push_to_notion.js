// Still no working due to below error:
// access to XMLHttpRequest at 'https://api.notion.com/v1/pages' from origin 'https://news.google.com'
// has been blocked by CORS policy: Response to preflight request doesn't pass access control check:
// No 'Access-Control-Allow-Origin' header is present on the requested resource.

console.log(window.location.href);
console.log(document.getElementsByTagName('title')[0].innerHTML);
var data = JSON.stringify({
  parent: {
    type: 'database_id',
    database_id: '310cf079c91340ffaedf149a8ab84ff4',
  },
  properties: {
    Name: {
      type: 'title',
      title: [
        {
          type: 'text',
          text: {
            content: 'Tomatoes2222',
          },
        },
      ],
    },
    URL: {
      type: 'url',
      url: 'https://google222.com',
    },
  },
});

var xhr = new XMLHttpRequest();
xhr.withCredentials = true;

xhr.addEventListener('readystatechange', function () {
  if (this.readyState === 4) {
    console.log(this.responseText);
  }
});

xhr.open('POST', 'https://api.notion.com/v1/pages');
xhr.setRequestHeader('Notion-Version', '2021-05-13');
xhr.setRequestHeader(
  'Authorization',
  'Bearer secret_hMeSRFpPeXjIPOsSispHjNjBQuqcxtG31TFgGCqBxaE'
);
xhr.setRequestHeader('Content-Type', 'application/json');

xhr.send(data);
