import express from 'express';
const app = express();

let a:number=4;

app.get('/', (req, res) => {
  const name = process.env.NAME || 'World';
  res.send(`Hello ${name}!`);
});

app.post('/hallo', (req, res) => {
  res.send('Hallo! its my hallo from docker in ts');
});

const port = parseInt(process.env.PORT || '3000');
app.listen(port, () => {
  console.log(`listening on port ${port}`);
});

// function just for test stages and exception
function sayHallo(name: string): string {
  return `Hallo ${name}`;
}

// this will fail
// sayHallo(a)