function toggleMenu(id){
    let menu = document.getElementById(id);

    if(menu.style.display === "block"){
        menu.style.display = "none";
    }else{
        menu.style.display = "block";
    }
}
