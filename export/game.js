document.querySelector(".qr-ready-btn").addEventListener("click", function () {
	godotBridge.test({message:"ready"});
	document.querySelector(".qr-bg").style.display = "none";
});