function sample()
{
    console.log("WELCOME JS");
    let hdg=document.getElementById("hdg");
    hdg.innerHTML="hello js";
    let name=document.getElementById("name").value;
    console.log(name);
    let hdg2=document.getElementById("hdg2");
    hdg2.innerHTML="hello"+name;
}
let btn=document.getElementById("btn");
btn.addEventListener("click",sample);

let name=document.getElementById("name").value;
console.log(name);

//arrow functions
let data=(a)=>{
    return a*a;
}
let res=data(2);
console.log(res);


let obj={
    name:"vijendar",
    age:20,
    display:function(){
        console.log(this.name);
        setTimeout(()=>{
            console.log(this.age);
        },100);
    }
}
obj.display();
function Student(name,age)
{
    this.name=name;
    this.age=age;
    this.display=function()
    {
        console.log(this.name);
        console.log(this.age);
    }
}
let s1=new Student("naresh",20);
let s2=new Student("lokesh",20);
s1.display();
s2.display();



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