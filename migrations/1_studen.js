const ManagmentSystem = artifacts.require("StudentManagmentSystem");

module.exports = function (deployer){

    deployer.deploy(ManagmentSystem);
}