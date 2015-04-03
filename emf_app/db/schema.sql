DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS transections;

CREATE TABLE accounts (
  id          SERIAL PRIMARY KEY,
  name        TEXT NOT NULL,
  balance     INTEGER NOT NULL
);

CREATE TABLE transections (
  id            SERIAL PRIMARY KEY,
  payee         TEXT NOT NULL,
  amount        INTEGER,
  category      TEXT,
  credit        INTEGER,
  debit         INTEGER,
  time_add      TIMESTAMP,
  account_id    INTEGER REFERENCES accounts(id)
);
