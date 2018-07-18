var animeCard = artifacts.require("AnimeCard");

module.exports = function(deployer) {
  deployer.deploy(animeCard, {gas:5000000});

};
