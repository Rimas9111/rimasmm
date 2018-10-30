var bar = document.querySelector(".fa-bars");
console.log(bar)
var barList = document.querySelector(".menu");
console.log(barList)
if(bar) {
    bar.addEventListener("click", function () {
        if (barList.classList.contains("hidden")) {
            barList.classList.remove("hidden")
        } else {
            barList.classList.add("hidden")
        }
    }); 
}