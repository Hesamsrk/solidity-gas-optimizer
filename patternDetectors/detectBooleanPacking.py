from slither.slither import Slither


def detect_boolean_packing(slither: Slither):
    """
    Detects boolean packing inefficiencies in the Solidity contract.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_boolean_packing", "contract_name":contract.name}
        
        boolVariables = [var for var in contract.variables if str(var.type) == "bool"]
        if len(boolVariables) == 0:
            result["message"] = "No boolean variables - no packing required"
            results.append(result)
            break
        if len(boolVariables) == 1:
            result["message"] = "Only one boolean variable - no packing required"
            results.append(result)
            break
        result["boolean_variables"] = [var.name for var in boolVariables]
        result["message"] = "One uint256 can be used to merge all boolean variables, use this pattern ./templates/booleanPacking.sol"
        results.append(result)
                        
    return results