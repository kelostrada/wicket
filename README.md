# Wicket

To start Wicket:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix s`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Some steps

`mix phoenix.gen.html Deposit deposits address:string txid:string amount:decimal confirmations:integer timereceived:integer pushed:boolean pushed_conf:integer connector:string`

`mix phoenix.gen.html Withdrawal withdrawals external_id:string address:string txid:string amount:decimal fee:decimal confirmations:integer timereceived:integer pushed:boolean pushed_conf:integer connector:string`

# O czym mówić

1. przedstawić siebie i firmę
2. czym jest bramka bitcoinowa i po co w ogóle robić skoro sa gotowe cloudowe rozwiazania
3. co to bitcoind i regtest
4. dlaczego nazwa Wicket
