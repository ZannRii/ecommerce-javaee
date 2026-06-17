
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

    let keyword =
        document.getElementById("searchBox").value;

    window.location =
        "home?keyword=" +
        encodeURIComponent(keyword);
}

function toggleMenu() {
    const menu = document.getElementById("dropdownMenu");

    if (menu.style.display === "block") {
        menu.style.display = "none";
    } else {
        menu.style.display = "block";
    }
}

// close menu when click outside
window.onclick = function(event) {
    if (!event.target.matches('.user-icon')) {
        const menu = document.getElementById("dropdownMenu");
        if (menu) {
            menu.style.display = "none";
        }
    }
}


