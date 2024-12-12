# Solidity Gas Optimizer

Refer to [Project Report](./project_report.pdf) PDF file for more information.


```bash
# In order to run the SolSAT tool you need to have docker
# and docker-compose installed on your environment, then run:

# Step 1:
make build 
# if makefile not available directly run: docker-compose build

# Step 2:
make run
# if makefile not available directly run: docker-compose run solidity-analyzer

# Step 3:
# In the new opened console run:
./solsat examples/inefficient_contract.sol --output report.json

# Check the report.json file for the results.

```