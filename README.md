# Solidity Gas Optimizer

Refer to [Project Report](./project_report.pdf) PDF file for more information.


```bash
# In order to run the SolSAT tool you need to have docker and docker-compose installed on your environment, then run:

make build # if makefile not available directly run: docker-compose build
make run # if makefile not available directly run: docker-compose run solidity-analyzer
# In the new opened console run:
./solsat examples/inefficient_contract.sol --output report.json

```