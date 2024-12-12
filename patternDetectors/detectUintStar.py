from slither.slither import Slither


def detect_uintstar(slither: Slither):
    """
    Detects uint* inefficiencies in the Solidity contract.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_uintstar", "contract_name":contract.name}
        
        uintVariables = [var for var in contract.variables if str(var.type).startswith("uint") and not str(var.type).startswith("uint256")]
        if len(uintVariables) == 0:
            result["message"] = "No uint* variables - no packing required"
            results.append(result)
            continue
        result["uint*_variables"] = [{"var_name":var.name,"var_type":str(var.type)} for var in uintVariables]
        result["message"] = "Instead of all these uint* datatypes, you better use uint256 to help avoid the need for conversion and save gas."
        results.append(result)
                        
    return results