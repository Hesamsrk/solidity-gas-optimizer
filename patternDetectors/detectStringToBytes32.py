from slither.slither import Slither


def detect_string_to_bytes32(slither: Slither):
    """
    Detects strings smaller than 32 byte, suggests to store them into bytes32 datatype instead.
    """
    results = []

    for contract in slither.contracts:
        result = {"analysis_type": "detect_string_to_bytes32", "contract_name":contract.name}
        
        stringVariables = [var for var in contract.variables if str(var.type) == "string"]
        if len(stringVariables) == 0:
            result["message"] = "No string variables - no conversion required"
            results.append(result)
            break
        result["string_variables"] = [{"var_name":var.name,"var_intialized":var.initialized} for var in stringVariables]
        result["message"] = "Instead of string variables that are initialized with a fixed value, in most cases you can fit it in a bytes32 instead."
        results.append(result)
                        
    return results