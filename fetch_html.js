const https = require('https');
const fs = require('fs');

const url = "https://contribution.usercontent.google.com/download?c=CgthaWRhX2NvZGVmeBJ7Eh1hcHBfY29tcGFuaW9uX2dlbmVyYXRlZF9maWxlcxpaCiVodG1sXzZjMzgzZDEyMTdlMDQzYzBiMWRlYmNhYTRhODhiMTVmEgsSBxCqlN_2hBoYAZIBIwoKcHJvamVjdF9pZBIVQhMzMjE2ODQ3NjA2MTg4ODM5MTY3&filename=&opi=89354086";

https.get(url, (res) => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    fs.writeFileSync('stitch.html', data);
    console.log("HTML successfully downloaded to stitch.html");
  });
}).on('error', err => {
  console.log("Error: ", err.message);
});
