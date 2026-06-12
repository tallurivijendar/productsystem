function verifyUser()
{
    return new Promise((resolve)=>
    {
        resolve("User Verfied");
    })
}
function checkBalance(userStatus)
{
    return new Promise((resolve,reject)=>{
        setTimeout(()=>{
            
            resolve(10000);
        },2000)
    })
}
function debitMoney(balance)
{
    return new Promise((resolve,reject)=>{
        setTimeout(()=>{
            let amount=3000;
            if(amount<=balance)
            {
                resolve(balance-amount);
            }
        },1000)

    })
}
function transactionStatus(remainingBalance)
{
    return new Promise((resolve,reject)=>{
        setTimeout(()=>{
            resolve(`Transaction successfull ${remainingBalance}`);
        },500)
    })
}
async function display()
{
    let userStatus=await verifyUser();
    console.log(userStatus);
    let balance=await checkBalance(userStatus);
    console.log(balance);
    let remainBalance=await debitMoney(balance);
    console.log(remainBalance);
    let status=await transactionStatus(remainBalance);
    console.log(status);
}
display();