## The (E)UTxO mdoel in a nutshell

refer to this video if you're confused https://youtu.be/_zr3W8cgzIQ?t=402

In order for you to write plutus contracts, YOU MUST understand Cardano's Transaction model as it is very different from Bitcoin and Ethereum.

This is the extended unspent transaction model.

Ethereum uses a an account based model which is comparable to a bank balance.

These are outputs from previous transactions on the blockchain that have not been spent

![image](https://user-images.githubusercontent.com/63081938/129947913-c293ee7a-8212-4cbf-9e37-9b091439e267.png)

As you can see above, Alice wants to send Bob 10 ADA. 
In order for her to do that, she must spend all of her ADA and she recieves 90 ADA in change.

(this example doesn't factor in transaction fees)

Here is another example of this when Alice and Bob send ADA to Charlie.
This may seem counterintuitive so I suggest taking a moment to look at the diagram.

![image](https://user-images.githubusercontent.com/63081938/129948826-e2d7d712-7c29-4425-a5c3-d943f0ecdecc.png)

An important note is that you can't just spend somebody else's ADA during a transaction, that's why signatures are put into place!

Because the transaction consumes both Alice and Bob's UTXO as input, both need a signature.
You need to use the Cardano command line for that.

(the extension part comes when we work on smart contracts)

Rather than having one condition being met, like an address, we replace this with arbitrary logic
that can decide under which conditions a utxo can be spent in a transaction.

What is arbitrary logic?

All the script sees is a redeemer.

In Ethereum, the scipt can see the whole state of the blockchain and its state.
The main problem with this, there's a lot of security dangers.

The Cardano blockchain is not as restricted as Bitcoin nor something as powerful as Ethereum.

the script in cardano can see all of the transaction including the input and outputs.

The script can see the spending transaction and run arbitrary logic to see if the transaction to consume the utxo

Disclaimer: this document is subject to update as my understanding of the (E)UTxO model.
