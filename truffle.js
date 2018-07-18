/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() {
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>')
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

// Allows us to use ES6 in our migrations and tests.

var HDWalletProvider = require("truffle-hdwallet-provider");
//var mnemonic = "connect differ ticket issue expect roast idle arrest cannon draft valve limits";
var mnemonic ="connect differ ticket issue expect roast idle arrest cannon draft valve limit";
module.exports = {
  networks: {
  	  development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "http://127.0.0.1:7545")
      },
      network_id: '1',
    //  gas: 6612388, // Gas limit used for deploys
	  //gasPrice: 2700000000000,

    }

  }
};
