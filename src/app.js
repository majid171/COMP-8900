App = {
  loading: false,
  contracts: {},

  load: async () => {
    await App.loadWeb3();
    await App.loadAccount();
    await App.loadContract();
    await App.render();
  },

  // https://medium.com/metamask/https-medium-com-metamask-breaking-change-injecting-web3-7722797916a8
  loadWeb3: async () => {
    if (typeof web3 !== "undefined") {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      window.alert("Please connect to Metamask.");
    }
    // Modern dapp browsers...
    if (window.ethereum) {
      window.web3 = new Web3(ethereum);
      try {
        // Request account access if needed
        await ethereum.enable();
        // Acccounts now exposed
        web3.eth.sendTransaction({
          /* ... */
        });
      } catch (error) {
        // User denied account access...
      }
    }
    // Legacy dapp browsers...
    else if (window.web3) {
      App.web3Provider = web3.currentProvider;
      window.web3 = new Web3(web3.currentProvider);
      // Acccounts always exposed
      web3.eth.sendTransaction({
        /* ... */
      });
    }
    // Non-dapp browsers...
    else {
      console.log(
        "Non-Ethereum browser detected. You should consider trying MetaMask!"
      );
    }
  },

  loadAccount: async () => {
    // Set the current blockchain account
    App.account = web3.eth.accounts[0];
    web3.eth.defaultAccount = App.account;
  },

  loadContract: async () => {
    // Create a JavaScript version of the smart contract
    const privacyPreservingDelivery = await $.getJSON(
      "PrivacyPreservingDelivery.json"
    );
    App.contracts.PrivacyPreservingDelivery = TruffleContract(
      privacyPreservingDelivery
    );
    App.contracts.PrivacyPreservingDelivery.setProvider(App.web3Provider);

    // Hydrate the smart contract with values from the blockchain
    App.privacyPreservingDelivery =
      await App.contracts.PrivacyPreservingDelivery.deployed();

    App.contractAddress = App.privacyPreservingDelivery.address;
  },

  commitAddress: async () => {
    const country = $("#inputCountry").val();
    const province = $("#inputProvince").val();
    const city = $("#inputCity").val();
    const postalcode = $("#inputPostalcode").val();
    await App.privacyPreservingDelivery.commitAddresses(
      country,
      province,
      city,
      postalcode
    );
    window.location.reload();
  },
  revealAddress: async () => {
    let revealedAddress = await App.privacyPreservingDelivery.reveal();
    $("#revealSection").append(
      "<p>" + revealedAddress.logs[0].args.stepReveal + " </p>"
    );
  },
  render: async () => {
    // Prevent double render
    if (App.loading) {
      return;
    }

    // Update app loading state
    App.setLoading(true);

    // Render Account
    $("#account").html(App.account);
    $("#contact").html(App.contractAddress);
    $("#revealBtn").on("click", App.revealAddress);
    $("#commitBtn").on("click", App.commitAddress);
    // Update loading state
    App.setLoading(false);
  },
  setLoading: (boolean) => {
    App.loading = boolean;
  },
};

$(() => {
  $(window).load(() => {
    App.load();
  });
});
