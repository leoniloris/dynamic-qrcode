// img = document.getElementById("qr_code_image_id");
function hexToBase64(str) {return btoa(String.fromCharCode.apply(null, str.replace(/\r|\n/g, "").replace(/([\da-fA-F]{2}) ?/g, "0x$1 ").replace(/ +$/, "").split(" ")));};
// img.src = 'data:image/jpeg;base64,' + hexToBase64(#{qr_code_image});
// document.getElementById("testestes").innerHTML = "Paragraph changed!";