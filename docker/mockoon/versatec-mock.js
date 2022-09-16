/* eslint-disable @typescript-eslint/no-require-imports */
/* eslint-disable @typescript-eslint/no-var-requires */
/* eslint-disable no-console */
const express = require('express');
const app = express();

const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const HTTP_PORT = 8060;

app.listen(HTTP_PORT, () => {
  console.log(`Server running on port ${HTTP_PORT}`);
});

app.post('/api/EmisorCta/VtcPreRegistroTH', (req, res, _next) => {
  console.log('VtcPreRegistroTH', req.body);
  res.json({
    InfoTran: {
      IsError: false
    }
  });
});

let accountRequest = 0;
app.post('/api/EmisorCta/VtcObtenerCuentasCliente', (req, res, _next) => {
  console.log('VtcObtenerCuentasCliente', req.body);
  const accounts = accountRequest > 3 ? [{
    CuentaIBANML: 'iban-prueba-ml',
    cuentaIBANME: 'iban-prueba-me',
    Cuenta: 'cuenta-prueba'
  }] : [];
  res.json({
    InfoTran: {
      IsError: false
    },
    Model: accounts
  });
  accountRequest++;
});

let cardRequest = 0;
app.post('/api/EmisorCta/VtcObtenerPlasticosNuevos', (req, res, _next) => {
  console.log('VtcObtenerPlasticosNuevos', req.body);
  const previous = [{
    CodigoCliente: 1,
    IdPlastico: 1
  }, {
    CodigoCliente: 1,
    IdPlastico: 2
  }];
  const cards = cardRequest > 3 ? [{
    CodigoCliente: '145',
    Tarjeta: 'tarjeta-prueba',
    IdPlastico: 3
  }, ...previous] : previous;
  res.json({
    InfoTran: {
      IsError: false
    },
    Model: cards
  });
  cardRequest++;
});

app.post('/api/token', (req, res, _next) => {
  res.json({
    access_token: '',
    expires_in: 5 * 60
  });
});
