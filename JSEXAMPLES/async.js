


//callback example
function placeOrder(callback)
{
    setTimeout(()=>{
        console.log("order placed");
        callback();

    },1000);
}
function prepareFood(callback)
{
    setTimeout(()=>{
        console.log("food prepared");
        callback();
    },2000);
}
function packFood(callback)
{
    setTimeout(()=>{
        console.log("food packed");
        callback();
    },1500);
}
function deliverFood(callback)
{
    setTimeout(()=>{
        console.log("food delivered");
    },500);
}
placeOrder(()=>{
    prepareFood(()=>{
        packFood(()=>{
            deliverFood();
        })
    })
})