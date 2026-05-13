
/* FILTER */
function filter(type) {
    let products = document.getElementsByClassName("product-card");

    for (let i = 0; i < products.length; i++) {
        if (type === "all") {
            products[i].style.display = "block";
        } else {
            if (products[i].classList.contains(type)) {
                products[i].style.display = "block";
            } else {
                products[i].style.display = "none";
            }
        }
    }
}

/* SEARCH */
function searchProduct() {
    let input = document.getElementById("searchBox").value.toLowerCase();
    let products = document.getElementsByClassName("product-card");

    for (let i = 0; i < products.length; i++) {
        let name = products[i].getElementsByTagName("h3")[0].innerText.toLowerCase();

        if (name.includes(input)) {
            products[i].style.display = "block";
        } else {
            products[i].style.display = "none";
        }
    }
}