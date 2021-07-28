const PrivacyPreservingDelivery = artifacts.require(
  "./PrivacyPreservingDelivery.sol"
);

module.exports = function (deployer) {
  deployer.deploy(PrivacyPreservingDelivery);
};
